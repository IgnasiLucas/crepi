#!/bin/bash

# Archivos BAM no filtrados (lecturas totales) en el directorio actual
bam_files=$(ls ../2023-05-18/BAM/*.bam)

# Archivos SAM filtrados (lecturas mapeadas) en el directorio actual
sam_files=$(ls ../2023-05-18/BAM/*_on_ref.sam)

# Verificar que el número de archivos BAM y SAM coincida
if [ $(echo "$bam_files" | wc -l) -ne $(echo "$sam_files" | wc -l) ]; then
    echo "Error: El número de archivos BAM y SAM no coincide."
    exit 1
fi

# Crear un archivo temporal para almacenar las tasas de éxito de mapeo
tmp_file=$(mktemp)

# Función para procesar un solo archivo BAM/SAM
process_file() {
    bam_file=$1
    sam_file="${bam_file%.bam}_on_ref.sam"
    if [ ! -f "$sam_file" ]; then
        echo "Error: No se encontró el archivo SAM correspondiente para $bam_file" >&2
        exit 1
    fi
    
    echo "Procesando archivos: $bam_file y $sam_file"
    total_reads=$(samtools view -c "$sam_file")
    mapped_reads=$(samtools view -c "$bam_file")
    
    echo "Lecturas totales: $total_reads"
    echo "Lecturas mapeadas: $mapped_reads"
    
    # Verificar que no haya lecturas totales iguales a cero para evitar división por cero
    if [ $total_reads -eq 0 ]; then
        echo "Error: El archivo $bam_file no tiene lecturas totales." >&2
        echo "0" >> "$tmp_file"
        return
    fi

    mapping_rate=$(echo "scale=2; ($mapped_reads / $total_reads) * 100" | bc)
    echo "Tasa de mapeo: $mapping_rate%"
    echo "$mapping_rate" >> "$tmp_file"
}

export -f process_file
export tmp_file

# Procesar archivos en paralelo utilizando 24 hilos
parallel -j 48 process_file ::: $bam_files

# Calcular la media y la desviación estándar de las tasas de éxito de mapeo
mean=$(awk '{sum+=$1} END {printf "%.2f", sum/NR}' "$tmp_file")
std_dev=$(awk '{sum+=$1; sumsq+=$1*$1} END {printf "%.2f", sqrt(sumsq/NR - (sum/NR)**2)}' "$tmp_file")

echo "Media del éxito de mapeo: $mean%"
echo "Desviación estándar del éxito de mapeo: $std_dev%"

# Eliminar archivo temporal
rm "$tmp_file"
