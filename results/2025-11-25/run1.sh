#!/bin/bash

if [ ! -e onesp/out1.txt ]; then
   bpp --cfile onesp1.ctl 1> onesp/out1.log 2> onesp/out1.err &
fi
if [ ! -e onesp/out2.txt ]; then
   bpp --cfile onesp2.ctl 1> onesp/out2.log 2> onesp/out2.err &
fi
wait
