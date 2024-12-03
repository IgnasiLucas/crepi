#!/bin/bash

## Running the second chain

for i in FAR PSE; do
  if [ ! -e ${i}/chain2.log ]; then 
    beast -prefix ${i}/chain2 -threads 4 ${i}/chain2.xml &> ${i}/screenlog2.txt &
  fi
done
wait