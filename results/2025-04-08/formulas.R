# Estimate of FST from allele frequencies (and possibly heterozygosities)
# in one locus in more than one population, following Weir and Cockerham (1984).
# Without heterozygosities or with `hwe=TRUE`, HWE is assumed, and two different
# equations can be used: either equation 1 in @Weir1984, with a, b and c, where
# heterozygosities are assumed equal to HWE expectations; or expression
# on top of page 1363 of @Weir1984, which is supposed to be a / (a + d),
# but with an unknown definition of a.

WC84 <- function(p, n, h = NULL, hwe = TRUE, use.abc = TRUE) {
  stopifnot(all(p <= 1))
  stopifnot(all(p >= 0))
  stopifnot(all(n > 0))
  stopifnot(all.equal(length(p), length(n)))
  if (hwe) {
    h <- 2 * p * (1 - p)
  } else {
    stopifnot(! is.null(h))
    stopifnot(all.equal(length(h), length(p)))
  }
  p.bar <- weighted.mean(p, n)
  n.bar <- mean(n)
  r <- length(p)
  C2 <- sd(n) / n.bar
  nc <- n.bar * (1.0 - C2 / r)
  s2 <- sum(n * (p - p.bar)^2) / ((r - 1) * n.bar)
  h.bar <- weighted.mean(h, n)
  a <- (n.bar / nc) * (s2 - (1 / (n.bar - 1)) * (p.bar * (1 - p.bar) - (r - 1) * s2 / r - h.bar / 4))
  b <- (n.bar / (n.bar - 1)) * (p.bar * (1 - p.bar) - (r - 1) * s2 / r - (2 * n.bar - 1) * h.bar / (4 * n.bar))
  c <- h.bar / 2
  if (hwe) {
    if (use.abc) {
      FST <- a / (a + b + c)
    } else {
       FST <- (s2 - (1 / (2 * n.bar - 1)) * (p.bar * (1 - p.bar) - (r - 1) * s2 / r)) / ((1 - (2 * n.bar * C2) / ((2 * n.bar - 1) * r)) * p.bar * (1 - p.bar) + (1 + (2 * n.bar *(r - 1) * C2) / ((2 * n.bar - 1) * r)) * s2 / r)
    }
  } else {
    FST <- a / (a + b + c)
  }
  return(FST)
}

WC84w <- function(p, n, h = NULL, hwe = TRUE) {
  stopifnot(dim(p)[1] > 1)
  stopifnot(all(p >= 0))
  stopifnot(all(p <= 1))
  if (hwe | is.null(h)) {
    h <- 2 * p * (1 - p)
  } else {
    stopifnot(! is.null(h))
    stopifnot(all.equal(dim(h), dim(p)))
  }
  if (is.vector(n)) {
    stopifnot(all.equal(length(n), dim(p)[2]))
    n <- matrix(rep(n, dim(p)[1]), nrow = dim(p)[1], ncol = length(n), byrow = TRUE)
  } else {
    stopifnot(all.equal(dim(p), dim(n)))
  }
  p.bar <- rowSums(p * n) / rowSums(n)
  n.bar <- rowSums(n) / dim(n)[2]
  r <- dim(p)[2]
  C2 <- apply(n, 1, sd) / n.bar
  nc <- n.bar * (1.0 - C2 / r)
  s2 <- rowSums(n * (p - p.bar) ^ 2) / ((r - 1) * n.bar)
  h.bar <- rowSums(h * n) / rowSums(n)
    a <- (n.bar / nc) * (s2 - (1 / (n.bar - 1)) * (p.bar * (1 - p.bar) - (r - 1) * s2 / r - h.bar / 4))
  b <- (n.bar / (n.bar - 1)) * (p.bar * (1 - p.bar) - (r - 1) * s2 / r - (2 * n.bar - 1) * h.bar / (4 * n.bar))
  c <- h.bar / 2
  FST <- sum(a) / sum(a + b + c)
  return(FST)
}