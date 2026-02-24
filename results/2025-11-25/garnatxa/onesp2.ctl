seed = -1
seqfile = crepiRad2.phy
* Imapfile = imap.txt
jobname = /scr/joiglu/crepi/results/2025-11-25/onesp/out2
speciesdelimitation = 0
speciestree = 0
species&tree = 1 A
14 * maxseqs
* guidetr
phase = 1
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
nsample = 30000
threads = 8
