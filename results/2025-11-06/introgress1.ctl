seed = -1
seqfile = crepi.phy
Imapfile = imap.txt
jobname = introgression/out1
speciesdelimitation = 0
speciestree = 0
species&tree = 2 A B
                 7 7   * maxseqs
((A, Y)X, (B, X)Y) R;
phase = 0 0
usedata = 1
nloci = 500
alphaprior = 1 1 4
cleandata = 1
thetaprior = 3 0.04 e
tauprior = 3 0.01
phiprior = 1 1
clock = 1
finetune = 1 Gage:99.000000 Gspr:0.001078 th1:0.000240 th2:0.042187 tau:0.000672 mix:0.112042 phis:0.037160 alfa:2.829299
print = 1 0 0 0 0
burnin = 500000
sampfreq = 5000
nsample = 10000
threads = 8 57 1
