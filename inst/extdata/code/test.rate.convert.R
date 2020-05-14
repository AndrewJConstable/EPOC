function (Cannual,Ninit)
{

Prop<-c(0.1,0.001,0.34,0.25)
Prop<-c(Prop,(1-sum(Prop)))

Periods<-length(Prop)
Cperiod<-rep(0,Periods)

Nfinal<-Ninit
SumFood<-0
for (pe in 1:Periods) {

  Cperiod<-(1-(1-Cannual)^Prop[pe])
  Food<-Nfinal*Cperiod
  Nfinal<-Nfinal-Food
  SumFood<-SumFood+Food
}

list(Ninit,Nfinal,((Ninit-Nfinal)/Ninit),SumFood,SumFood/Ninit)
}

