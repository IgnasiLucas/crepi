seed = -1
seqfile  = /home/joiglu/crepi/2025-11-25/crepiRad2.phy
Imapfile = /home/joiglu/crepi/2025-11-25/imap2.txt
jobname  = twoMig
speciesdelimitation = 0
speciestree = 0
species&tree = 2 A B
                 7 7  * maxseqs
               (A,B); * guidetree
wprior = 2.0 100
migration = 2
  A B
  B A
phase = 1 1
usedata = 1
nloci = 1218
alphaprior = 1 1 4
cleandata = 0
thetaprior = invgamma 3 0.002 e
tauprior = invgamma 3 0.02
locusrate = 1 0 0 5.0 iid
clock = 1
finetune = 1
print = 1 0 0 0 0
burnin = 25000
sampfreq = 500
nsample = 15000
threads = 8
