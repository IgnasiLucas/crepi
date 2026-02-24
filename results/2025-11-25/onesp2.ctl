seed = -1
seqfile = crepiRad2.phy
* Imapfile = imap.txt
jobname = onesp/out2
speciesdelimitation = 0
speciestree = 0
species&tree = 1 A
14 * maxseqs
* guidetr
phase = 1
usedata = 1
nloci = 1000
alphaprior = 1 1 4
cleandata = 0
thetaprior = 3 0.04 e
tauprior = 3 0.01
phiprior = 1 1
locusrate = 1 0 0 5.0 iid
clock = 1
finetune = 1 Gage:99.000000 Gspr:0.001216 th1:0.000382 tau:0.000000 mix:0.041259 alfa:2.638333 mu_i:0.867624
print = 1 0 0 0 0
burnin = 25000
sampfreq = 500
nsample = 100000
threads = 8 17 1
