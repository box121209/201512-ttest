library(shiny)

addTrans <- function(color,trans)
{
  # This function adds transparancy to a color.
  # Define transparancy with an integer between 0 and 255
  # 0 being fully transparant and 255 being fully visable
  # Works with either color and trans a vector of equal length,
  # or one of the two of length 1.
  
  if (length(color)!=length(trans)&!any(c(length(color),length(trans))==1)) stop("Vector lengths not correct")
  if (length(color)==1 & length(trans)>1) color <- rep(color,length(trans))
  if (length(trans)==1 & length(color)>1) trans <- rep(trans,length(color))
  
  num2hex <- function(x)
  {
    hex <- unlist(strsplit("0123456789ABCDEF",split=""))
    return(paste(hex[(x-x%%16)/16+1],hex[x%%16+1],sep=""))
  }
  rgb <- rbind(col2rgb(color),trans)
  res <- paste("#",apply(apply(rgb,2,num2hex),2,paste,collapse=""),sep="")
  return(res)
}

dat <- function(x1,x2){
  x <- c(x1,x2)
  n1 <- length(x1)
  n2 <- length(x2)
  cls <- c(rep('A',n1), rep('B',n2)) 
  data.frame(x, cls)
}
welch.test <- function(x1,x2){
  df <- dat(x1,x2)
  alt <- if(mean(x1)>mean(x2)) 'g' else 'l'
  t.test(df$x ~ df$cls, alternative=alt)
}
plot.test <- function(x1,x2){
  df <- dat(x1,x2)
  boxplot(df$x ~ df$cls, col='yellow')
  means <- tapply(df$x, df$cls, mean)
  points(means, col="red", pch='-', cex=3)
}

