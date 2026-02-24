plotAB <- function(Theta.A, Theta.B, Theta.R, Tau, i = 4, ...){
   alpha <- pi / i
   while (2 * Tau / tan(alpha) < Theta.A + Theta.B) {
      i <- i + 0.5
      alpha <- pi / i
   }
   l <- Tau / tan(alpha)
   m <- l + Theta.R * Theta.A / (Theta.A + Theta.B)
   r <- l + Theta.R
   u <- r + Tau / tan(alpha)
   v <- u - Theta.B
   xlimit <- max(u, Tau + Theta.R)
   ylimit <- xlimit
   #ylimit <- Tau + Theta.R * 1.05
   plot(c(0, xlimit), c(0, ylimit), type = 'n', axes = FALSE,
        xlab = '', ylab = 'Substitutions per site', ...)
   abline(h = Tau, lty = 2, col = 'gray')
   abline(h = Theta.A / 2, lty = 2, col = 'orange')
   abline(h = Theta.B / 2, lty = 2, col = 'purple')
   polygon(x = c(0, Theta.A, m, v, u, r, r, l, l, 0),
           y = c(0, 0, Tau, 0, 0, Tau, Tau + Theta.R, Tau + Theta.R, Tau, 0))
   axis(2)
   text(rep(xlimit, 3), c(Tau, Theta.A / 2, Theta.B / 2),
        c(expression(tau[R]), expression(T[2]^A), expression(T[2]^B)),
        col = c('gray', 'orange', 'purple'), adj = c(0, 1), )
}
