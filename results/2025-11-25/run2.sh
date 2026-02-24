#!/bin/bash

sed -i "/threads = /c threads = 8 1 1" twosp1.ctl
sed -i "/threads = /c threads = 8 9 1" twosp2.ctl
sed -i "/finetune =/c finetune = 1 Gage:99.000000 Gspr:0.001803 th1:0.000455 th2:0.000087 tau:0.000129 mix:0.043115 alfa:2.673584 mu_i:0.865843" twosp1.ctl
sed -i "/finetune =/c finetune = 1 Gage:99.000000 Gspr:0.001803 th1:0.000455 th2:0.000087 tau:0.000129 mix:0.043115 alfa:2.673584 mu_i:0.865843" twosp2.ctl

if [ ! -e twosp/out1.txt ]; then
   bpp --cfile twosp1.ctl 1> twosp/out1.log 2> twosp/out1.err &
fi
if [ ! -e twosp/out2.txt ]; then
   bpp --cfile twosp2.ctl 1> twosp/out2.log 2> twosp/out2.err &
fi
wait
