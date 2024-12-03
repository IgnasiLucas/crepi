#!/bin/bash

for i in FAR PSE; do
  if [ ! -e ${i}/EBSP.log ]; then 
    beast -prefix ${i}/ -threads 4 ${i}/${i}.xml &> ${i}/screenlog.txt &
  fi
done
wait
