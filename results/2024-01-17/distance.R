z <- read.tree(file = "RAxML/28S_round03/T2.raxml.bestTreeCollapsed")

z <- drop.tip(z, tip = "MT196347_C.metoecus_JA")
z <- drop.tip(z, tip = "MT196350_C.metoecus_JA")
plot(z, cex=0.5)
plot(midpoint.root(z), cex=0.5)
nodelabels(cex=0.5, font= 0)
a <- cbind(z$edge,z$edge.length)

cbind(z$edge,z$edge.length)[z$edge[,1] == 104, ]
