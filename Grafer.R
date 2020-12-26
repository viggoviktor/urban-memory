
tmp <- lapply(names(Xdata), function(x)ggplot(data = Xdata[,x,drop=FALSE])+aes_string(x)+xlab(x)+ylab(""))
gd<-geom_density(adjust=2,fill=gray(0.5), colour = gray(0.5))
gb<-geom_bar(fill=gray(0.5))

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
cp <- cor(data.matrix(subset(XdataF, select = c(year, pol_no_claims_discount, drv_age1,drv_age_lic1, drv_age2,drv_age_lic2,vh_age ,vh_speed,vh_value,vh_weight, population, town_surface_area))), method = "spearman")
ord <- rev(hclust(as.dist(1 - abs(cp)))$order)
colPal <- colorRampPalette(c("blue", "yellow"), space = "rgb")(100)
levelplot(cp[ord, ord],
          xlab = "",
          ylab = "",
          col.regions = colPal,
          at = seq(-1, 1, length.out = 100),
          colorkey = list(space = "top", labels = list(cex = 1.5)),
          scales = list(x = list(rot = 45),
                        y = list(draw = FALSE),
                        cex = 0.8)
)
corrplot.mixed(cp,lower="color", upper="number",order="hclust", tl.col="black", tl.pos="lt", tl.srt=38,tl.cex=0.6, number.cex=0.8, lower.col=colPal, upper.col=colPal)
