source('mcmc.R')
source('plotModel.R')

one1 <- read.table('onesp/out1.mcmc.txt', header = TRUE)
one2 <- read.table('onesp/out2.mcmc.txt', header = TRUE)
two1 <- read.table('twosp/out1.mcmc.txt', header = TRUE)
two2 <- read.table('twosp/out2.mcmc.txt', header = TRUE)
mig0 <- read.table('twoMig/out0.mcmc.txt', header = TRUE)
mig1 <- read.table('twoMig/out1.mcmc.txt', header = TRUE)
mig2 <- read.table('twoMig/out2.mcmc.txt', header = TRUE)

autocorPlot(one1)
autocorPlot(one2)
autocorPlot(two1)
autocorPlot(two2)
autocorPlot(mig0, step = 20:500)
autocorPlot(mig1, step = 10:50)
autocorPlot(mig2, step = 10:80)

f11 <- seq(from = 1, to = nrow(one1), by = 5)
f12 <- seq(from = 1, to = nrow(one2), by = 5)
f21 <- seq(from = 1, to = nrow(two1), by = 15)
f22 <- seq(from = 1, to = nrow(two2), by = 15)
fm0 <- seq(from = 1, to = nrow(mig0), by = 80)
fm1 <- seq(from = 1, to = nrow(mig1), by = 20)
fm2 <- seq(from = 1, to = nrow(mig2), by = 50)

tendencyPlot(one1[f11,])
tendencyPlot(one2[f12,])
tendencyPlot(two1[f21,])
tendencyPlot(two2[f22,])
tendencyPlot(mig0[fm0,])
tendencyPlot(mig1[fm1,])
tendencyPlot(mig2[fm2,])

convergencePlot(one1[f11,], one2[f12,])
convergencePlot(two1[f21,], two2[f22,])
convergencePlot(mig1[fm1, 1:4], mig2[fm2, 1:4])
convergencePlot(mig1[fm1, -c(2,3,4)], mig2[fm2, -c(2,3,4)])
convergencePlot(mig0[fm0, 1:4], mig1[fm1, 1:4])
convergencePlot(mig0[fm0, -c(2,3,4)], mig1[fm1, -c(2,3,4,8)])
convergencePlot(mig0[fm0, 1:4], mig2[fm2, 1:4])
convergencePlot(mig0[fm0, -c(2,3,4)], mig2[fm2, -c(2,3,4,8)])

one <- rbind(one1[f11,], one2[f12,])
two <- rbind(two1[f21,], two2[f22,])
mig <- rbind(mig1[fm1,], mig2[fm2,])

plotAB(mean(mig$theta.1.A), mean(mig$theta.2.B),
       mean(mig$theta.3.A.B), mean(mig$tau.3.A.B),
       main = "With Migration")
plotAB(mean(two$theta.1.A), mean(two$theta.2.B),
       mean(two$theta.3.A.B), mean(two$tau.3.A.B),
       main = "Without Migration")
plotAB(mean(mig0$theta.1.A), mean(mig0$theta.2.B),
       mean(mig0$theta.3.A.B), mean(mig0$tau.3.A.B),
       main = "Prior with Migration")
plot(c(0.0015, 0.03), c(0, 2300), type = 'n',
     xlab = '', ylab = 'Density')
lines(density(one$theta.1.A, bw = 'SJ'), col = 'black')
lines(density(two$theta.1.A, bw = 'SJ'), col = 'orange')
lines(density(two$theta.2.B, bw = 'SJ'), col = 'purple')
lines(density(two$theta.3.A.B, bw = 'SJ'), col = 'red')
lines(density(mig$theta.1.A, bw = 'SJ'), col = 'orange', lty = 2)
lines(density(mig$theta.2.B, bw = 'SJ'), col = 'purple', lty = 2)
lines(density(mig$theta.3.A.B, bw = 'SJ'), col = 'red', lty = 2)
legend(0.012, 2200, c('One species', 'C. farionis without migration',
                     'C. pseudofarionis without migration',
                     'Ancestor without migration',
                     'C. farionis with migration',
                     'C. pseudofarionis with migration',
                     'Ancestor with migration'),
       col = c('black', 'orange', 'purple', 'red',
               'orange', 'purple', 'red'),
       lty = c(1, 1, 1, 1, 2, 2, 2), bty = 'n')
