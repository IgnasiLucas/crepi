#!/bin/bash

cp template.ctl twoMig1.ctl
sed -i "/seqfile = /c seqfile = crepiRad2.phy"    twoMig1.ctl
sed -i "/Imapfile =/c Imapfile = imap2.txt"       twoMig1.ctl
sed -i "/jobname = /c jobname = twoMig/out1"      twoMig1.ctl
sed -i "/phase = /c *newline  \nphase = 1 1"      twoMig1.ctl
sed -i "/*newline /c wprior = 2.0 0.5\n*newline " twoMig1.ctl
sed -i "/*newline /c migration = 2\n  A B\n  B A" twoMig1.ctl
sed -i "/finetune =/c finetune = 1 Gage:99.000000 Gspr:0.485247 th1:0.000565 th2:0.000055 tau:0.000129 mix:0.037367 alfa:2.645878 mu_i:0.871051 mrte:99.000000" twoMig1.ctl
sed -i "/threads = /c threads = 8 33 1"           twoMig1.ctl

cp twoMig1.ctl twoMig2.ctl
sed -i "/jobname = /c jobname = twoMig/out2"      twoMig2.ctl
sed -i "/threads = /c threads = 8 41 1"           twoMig2.ctl

if [ ! -e twoMig/out1.txt ]; then
   bpp --cfile twoMig1.ctl 1> twoMig/out1.log 2> twoMig/out1.err &
fi
if [ ! -e twoMig/out2.txt ]; then
   bpp --cfile twoMig2.ctl 1> twoMig/out2.log 2> twoMig/out2.err &
fi
wait
