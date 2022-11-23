
#############
############# Hello Word Example
#############

### This function goes into a library 

helloWorld = function(st) {paste("Hello",st)}

## let's specify a specific path

pth = "/home/anthony/USERA/CSC 265 SPRING 2016/How to Make R Packages"
setwd(pth)

package.skeleton(name='helloWorld',list='helloWorld')

system("ls")
system("R CMD build helloWorld")

####################
#################### A more ambitious example
####################

### recall generic functions summary(), plot(), print()

### rewrite my.lm to (1) assign class attribute, (2) set plotting functions in a separate generic function

myLmFun = function(x,y,pd=1,xl="X",yl="Y") {
  
  if (pd ==1) {
    fit = lm(y~x)
  } else
  {
    fit = lm(y~poly(x,pd))
  }
  lm.obj = list(fit=fit,pd=pd,xl=xl,yl=yl,x=x,y=y)
  class(lm.obj) = "myLm"  
  return(lm.obj)
}
  
### generic plot function 

plot.myLm = function(myLm) {
  with(myLm,{ 
    plot(x,y,xlab=xl,ylab=yl)
    ind = sort.list(x)
    lines(x[ind],fit$fitted.values[ind],col='green',lwd=2)
    plot(fit$fitted.values,fit$residuals,xlab="Fitted Values",ylab="Residuals")
    abline(h=0,col='green',lwd=2)
  })
}

### generic summary function

summary.myLm = function(myLm) {
  with(myLm,{ 
    summary(fit)
  })
}

x = rnorm(500)
y = x + rnorm(500)

i = 5
junk = myLmFun(x,y,i)
attributes(junk)
par(mfrow=c(1,2))
plot(junk)
summary(junk)

############### create package skeleton

### we can provide sample data

x.sample.myLm = x
y.sample.myLm = y


pth = "/home/anthony/USERA/CSC 265 SPRING 2016/How to Make R Packages"
setwd(pth)
package.skeleton(name='myLm',list=c('myLmFun','plot.myLm','summary.myLm','x.sample.myLm','y.sample.myLm'))


