plotAdmix <- function(q, pop=NULL, ord=NULL, inds=NULL,
                      colorpal= c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"),
                      main=paste("Admixture proportions assuming K =",k),
                      cex.main=1.5, cex.lab=1, rotatelab=0,padj=0, cex.inds=1,
                      drawindslines=TRUE){
  # simple function to plot admixture proprotions, just to make sure the ordering of individuals is handled as in plotCorRes.
  
  k <- ncol(q)
  
  if(k>length(colorpal))
    warning("not enought colors for all Ks in palette.")
  
  # if(!is.null(ord)) if(!ord) ord <- 1:nrow(q)
  
  if(is.null(ord)&!is.null(pop)) ord <- order(pop)
  if(is.null(ord)&is.null(pop)) ord <- 1:nrow(q)
  
  barplot(t(q)[,ord], col=colorpal, space=0, border=NA, cex.axis=1.5,cex.lab=1.5,
          ylab="", xlab="", main=main, cex.main=cex.main,xpd=NA)
  
  if(!is.null(inds)){
    text(x = 1:nrow(q) - 0.5,-0.1, inds[ord],xpd=NA,srt=90, cex=cex.inds)
  }
  
  if(!is.null(pop)){
    
    text(sort(tapply(1:length(pop),pop[ord],mean)),-0.05-padj,unique(pop[ord]),xpd=NA, srt=rotatelab, cex=cex.lab)
    if(drawindslines) abline(v=1:nrow(q), col="white", lwd=0.2)
    abline(v=cumsum(sapply(unique(pop[ord]),function(x){sum(pop[ord]==x)})),col=1,lwd=1.2)
    
  }
  
}