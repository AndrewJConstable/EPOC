function (ab,pv,M,i)
{
ab*(1-pv[i]*(1-exp(-M))/(1-sum(pv[1:(i-1)])*(1-exp(-M))))

}

