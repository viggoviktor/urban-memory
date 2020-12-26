Xdata
#### producerer marginale plot####
sapply(Xdata, class)
tmp <- lapply(names(Xdata), function(x)ggplot(data = Xdata[,x,drop=FALSE])+aes_string(x)+xlab(x)+ylab(""))
gd<-geom_density(adjust=2,fill=gray(0.5), colour = gray(0.5))
gb<-geom_bar(fill=gray(0.5))
tmp
grid
grid.arrange(
  #tmp[[1]]+gb,
  tmp[[2]]+get("gb"),
  tmp[[3]]+gd,
  tmp[[4]]+gb,
  tmp[[5]]+gb,
  tmp[[6]]+gd,
  tmp[[7]]+gd,
  tmp[[8]]+gd,
  tmp[[9]]+gd,
  tmp[[10]]+gd,
  tmp[[11]]+gd,
  tmp[[12]]+gd,
  tmp[[13]]+gd,
  tmp[[14]]+gb,
  tmp[[15]]+gb,
  tmp[[16]]+gb,
  tmp[[17]]+gb,
  tmp[[18]]+gb,
  tmp[[19]]+gb,
  tmp[[20]]+gb,
  tmp[[21]]+gb,
  tmp[[22]]+gb,
  tmp[[23]]+gb,
  tmp[[24]]+gd
)

grid.arrange(tmp[[6]]+gb,
             tmp[[13]]+gd,
             tmp[[14]]+gb,
             tmp[[15]]+gb,
             tmp[[16]]+gb,
             tmp[[17]]+gb,
             tmp[[18]]+gb,
             tmp[[19]]+gb,
             tmp[[20]]+gb,
             tmp[[21]]+gb,
             tmp[[22]]+gb,
             tmp[[23]]+gb)



