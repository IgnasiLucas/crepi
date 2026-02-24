seed = -1
seqfile = input.phy
Imapfile = imap.txt
jobname = out.txt
speciesdelimitation = 0
speciestree = 0
species&tree = 2 A B
                 7 7  * maxseqs
               (A,B); * guidetree
phase = 1 1
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
