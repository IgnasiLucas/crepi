seed = -1
seqfile = crepiRad3.phy
Imapfile = imap.txt
jobname = threeMig/out1
speciesdelimitation = 0
speciestree = 0
species&tree = 3 A B C
4 4 4
((A,B),C);
migprior = 2 200
migration 2
  A B
  B A
phase = 1 1 1
usedata = 1
nloci = 1000
alphaprior = 1 1 4
cleandata = 0
thetaprior = 3 0.04 e
tauprior = 3 0.01
locusrate = 1 0 0 5.0 iid
clock = 1
finetune = 1
print = 1 0 0 0 0
burnin = 25000
sampfreq = 250
nsample = 100000
threads = 8 25 1
