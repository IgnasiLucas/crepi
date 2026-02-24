seed = -1
seqfile = crepiRad2.phy
Imapfile = imap2.txt
jobname = twoMig/out1
speciesdelimitation = 0
speciestree = 0
species&tree = 2 A B
                 7 7  * maxseqs
               (A,B); * guidetree
wprior = 2.0 0.5
migration = 2
  A B
  B A
phase = 1 1
usedata = 1
nloci = 1000
alphaprior = 1 1 4
cleandata = 0
thetaprior = 3 0.04 e
tauprior = 3 0.01
locusrate = 1 0 0 5.0 iid
clock = 1
finetune = 1 Gage:99.000000 Gspr:0.485247 th1:0.000565 th2:0.000055 tau:0.000129 mix:0.037367 alfa:2.645878 mu_i:0.871051 mrte:99.000000
print = 1 0 0 0 0
burnin = 25000
sampfreq = 250
nsample = 100000
threads = 8 33 1
