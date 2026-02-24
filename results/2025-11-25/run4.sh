#!/bin/bash

cp template.ctl twoMig0.ctl
sed -i "/seqfile = /c seqfile = crepiRad2.phy"    twoMig0.ctl
sed -i "/Imapfile =/c Imapfile = imap2.txt"       twoMig0.ctl
sed -i "/jobname = /c jobname = twoMig/out0"      twoMig0.ctl
sed -i "/phase = /c *newline  \nphase = 1 1"      twoMig0.ctl
sed -i "/*newline /c wprior = 2.0 0.5\n*newline " twoMig0.ctl
sed -i "/*newline /c migration = 2\n  A B\n  B A" twoMig0.ctl
sed -i "/usedata =/c usedata = 0"                 twoMig0.ctl
sed -i "/finetune =/c finetune = 1"               twoMig0.ctl
sed -i "/threads = /c threads = 8 49 1"           twoMig0.ctl

if [ ! -e twoMig/out0.txt ]; then
   bpp --cfile twoMig0.ctl 1> twoMig/out0.log 2> twoMig/out0.err &
fi
wait
