seed = -1
seqfile = crepi.phy
* Imapfile = imap.txt
jobname = onespecies/prior
speciesdelimitation = 0
speciestree = 0
species&tree = 1 A
14 * maxseqs
* guidetree
phase = 0
usedata = 0
nloci = 50
alphaprior = 1 1 4
cleandata = 1
thetaprior = 3 0.04 e
tauprior = 3 0.01
phiprior = 1 1
clock = 1
finetune = 1
print = 1 0 0 0 0
burnin = 1000
sampfreq = 5
nsample = 50000
