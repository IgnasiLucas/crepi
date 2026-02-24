seed = -1
seqfile = crepiRad2.phy
Imapfile = imap2.txt
jobname = twoMig/out0
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
usedata = 0
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
threads = 8 49 1
