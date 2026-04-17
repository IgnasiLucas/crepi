autocor <- function(mcmc, skip) {
   cor(mcmc[1:(length(mcmc) - skip)],
       mcmc[(skip + 1):(length(mcmc))])
}
autocorPlot <- function(mcmc, step = 1:20, paleta = 'Egypt', main = ''){
   R <- lapply(
      mcmc[, -1],
      function(x) {
         r <- sapply(
            step,
            function(y) {
               autocor(x, y)
            }
         )
      }
   )
   plot(range(step), range(do.call(c, R)), type = 'n',
        xlab = 'Step size', ylab = 'Autocorrelation', main = main)
   pal <- MetBrewer::met.brewer(paleta, length(R))
   devnull <- lapply(
      1:length(R),
      function(x) lines(step, R[[x]], col = pal[x])
   )
   abline(h = 0, lty = 2, col = 'gray')
   ypos <- max(do.call(c, R)) * 0.9
   legend(max(step) * 0.70, ypos, names(mcmc)[-1], lwd = 2,
          col = pal, box.lwd = 0, bg = 'white', yjust = 1)
}
tendencyPlot <- function(mcmc){
   n <- ncol(mcmc) - 1
   r <- nrow(mcmc)
   if (r > 12000) {
      mcmc <- mcmc[sample(1:r, 10000),]
      r <- 10000
   }
   m <- ifelse(n > 3, 2, 1)
   l <- ceiling(n / m)
   previous.mar <- par('mar')
   par(mfrow = c(l, m), mar = c(1, 1, 4, 1))
   devnull <- lapply(
      2:ncol(mcmc),
      function(x) {
         plot(mcmc[, 1], mcmc[, x], axes = FALSE,
              xlab = '', ylab = '', main = names(mcmc)[x],
              col = 'gray')
         abline(h = mean(mcmc[, x]), col = 'red', lty = 2)
      }
   )
   par(mfrow = c(1, 1), mar = previous.mar)
}
convergencePlot <- function(mcmc1, mcmc2){
   stopifnot(all.equal(names(mcmc1), names(mcmc2)))
   n <- ncol(mcmc1) - 1
   m <- ifelse(n > 3, 2, 1)
   l <- ceiling(n / m)
   previous.mar <- par('mar')
   par(mfrow = c(l, m))
   pal <- MetBrewer::met.brewer('Egypt', 2)
   devnull <- lapply(
      2:ncol(mcmc1),
      function(x){
         plot(range(c(mcmc1[,x], mcmc2[,x])),
              range(c(density(mcmc1[,x], bw = 'SJ')$y,
                      density(mcmc2[,x], bw = 'SJ')$y)),
              type = 'n', xlab = '', main = names(mcmc1)[x],
              ylab = 'Density')
         lines(density(mcmc1[,x], bw = 'SJ'), col = pal[1])
         lines(density(mcmc2[,x], bw = 'SJ'), col = pal[2])
      }
   )
   par(mfrow = c(1, 1), mar = previous.mar)
}