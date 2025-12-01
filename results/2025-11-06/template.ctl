seed = -1
seqfile = crepi.phy
Imapfile = imap.txt
jobname = out.txt
speciesdelimitation = 0
speciestree = 0
species&tree = 2 A B
                 7 7   * maxseqs
                (A,B); * guidetree
phase = 0 0
usedata = 1
nloci = 200
alphaprior = 1 1 4
cleandata = 1
thetaprior = 3 0.04 e
tauprior = 3 0.01
phiprior = 1 1
clock = 1
finetune = 1 Gage:99.000000 Gspr:0.001201 th1:0.000255 th2:0.000775 tau:0.000274 mix:0.122370 alfa:2.758459
print = 1 0 0 0 0
burnin = 25000
sampfreq = 75
nsample = 200000
threads = 1
