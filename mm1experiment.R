library(ggplot2)

exp <- read.table("mm1experiment.csv", header=FALSE, sep=",")
names(exp) <- c("lambda", "exp", "qlen")
exp$rho <- exp$lambda/244.140625

rhos <- seq(from = 0.45, to = 0.999, by = 0.001)
qlens <- rhos*rhos/(1-rhos)
analytical <- data.frame(rho=rhos, qlen=qlens)

q <- ggplot() + theme_minimal(base_size = 10)

q <- q + geom_line(data=analytical, aes(x=rho,
    y=qlen,
    colour="Analytical"))
q <- q + stat_summary(data=exp, aes(x=rho, y=qlen, colour="Testbed Experiment"), fun.y = mean, fun.ymin = min, fun.ymax = max,alpha=0.4)
q <- q + scale_colour_discrete("")
q <- q + scale_x_continuous("p", limits=c(0.45,1))
q <- q + scale_y_continuous("Average queue length")
q <- q + theme(legend.position="bottom")

png("mm1-qlenexp.png")
print(q)
dev.off()

quit("no")
