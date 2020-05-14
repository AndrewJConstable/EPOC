function (dVBpart,dWtlen,AgeInt,FracYear)
# Function:           B.PD.vB_general.01
# Description:        Population dynamics, generalised von Bertalanffy growth
# Primary attributes: von Bertalanffy growth allowing growth in only part of year which may overlap growth curve origin
#                       e.g. krill, returns the weight at age
#                     the values are relative to the birthday (i.e. no adjustment for calendar day)

# Input parameters:   dVBpart = parameters for partial year von Bertalanffy function
#                               as vector (Linf,K,t0,dayStart,dayEnd)
#                                           vBLinf = L infinity
#                                           vBK    = growth rate
#                                           vBt0   = age when size is zero
#                                           g.origin = proportion of calendar year to day of time origin (time=0.0) on growth curve
#                                           tr     = start of growth period as proportion of year since origin (time=0.0) of growth curve
#                                           tg     = total proportion of the year in which growth occurs
#                                                     (over one continuous period that may overlap with origin)
#                     dWtlen  = parameters for weight length relationship as vector (a,b)
#                     AgeInt     = age class for when size is needed
#                     FracYear = the time of the year as a fraction since start

########################################################
#      Signature <- list(
#        ID           =  29006,
#        Name.full    = "von Bertalanffy growth in part of year - weight at age",
#        Name.short   = "vB part-WL",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "6 June 2005"
#        ) # end Signature


########################################################
{

tr<-dVBpart$tr
tg<-dVBpart$tg
g.origin<-dVBpart$g.origin

# if needed - alter the times relative to the start of the year to become relative to the birthday (g.origin)

#if (FracYear < g.origin)  TimeInGrowthYear <- (1-g.origin+FracYear)
#if (FracYear >= g.origin) TimeInGrowthYear <- (FracYear-g.origin)
#if (tr < g.origin) GrowthStart <- (1-g.origin+tr)
#if (tr >= g.origin) GrowthStart <- (tr-g.origin)
#AgeFrac<-TimeInGrowthYear
#GrowthEnd<-GrowthStart+tg

AgeFrac<-FracYear
GrowthStart<-tr
GrowthEnd<-tr+tg

# the growth period might cross from the end of the year to the beginning of the year
#   the rule [if(end < beginning] is used below

if (GrowthEnd>1) GrowthEnd<-GrowthEnd-1

# when the fraction of the year is greater than the start of the first complete growth period

tadj<-ifelse (AgeFrac <= GrowthEnd,
          ifelse (GrowthEnd<=GrowthStart,AgeFrac/tg, # AgeFrac is in growth period at the beginning of the year
                      ifelse(AgeFrac<GrowthStart,0,       # AgeFrac is in no growth period and there is no earlier growth period in the year
                            (AgeFrac-GrowthStart)/tg)),   # AgeFrac is in growth period with no earlier growth before the no growth period

#         end yes for if(AgeFrac <= GrowthEnd)

          ifelse (GrowthEnd>GrowthStart,(GrowthEnd-GrowthStart)/tg, # AgeFrac is in no growth period
                    ifelse(AgeFrac>=GrowthStart,(GrowthEnd+AgeFrac-GrowthStart)/tg,     # in growth period that may or may not have a no growth period in the middle
                          GrowthEnd/tg)))       # in no growth period after a growth period early in the year

#         end no for if(AgeFrac <= GrowthEnd)

#if (GrowthEnd>GrowthStart & AgeFrac<=GrowthStart) tadj<-0
#if (GrowthEnd>GrowthStart & AgeFrac>GrowthStart & AgeFrac<=GrowthEnd) tadj<-(AgeFrac-GrowthStart)/tg
#if (GrowthEnd>GrowthStart & AgeFrac>GrowthEnd) tadj<-(GrowthEnd-GrowthStart)/tg
#if (GrowthEnd<=GrowthStart & AgeFrac<=GrowthEnd) tadj<-AgeFrac/tg
#if (GrowthEnd<=GrowthStart & AgeFrac>GrowthEnd & AgeFrac<GrowthStart) tadj<-GrowthEnd/tg
#if (GrowthEnd<=GrowthStart & AgeFrac>=GrowthStart) tadj<-(GrowthEnd+AgeFrac-GrowthStart)/tg





#print(c(FracYear,tr,g.origin,AgeFrac,tadj))

# calculate length at age based on the adjusted fraction of the year. NB that t0 doesn't interfere with
# the calculations above for adjusting the fraction of the year.
Len<-dVBpart$Linf*(1-exp(-dVBpart$Kappa*(AgeInt+tadj-dVBpart$vBt0)))
# return age, weight at age
c((AgeInt+AgeFrac),dWtlen$WLa*Len^dWtlen$WLb)
}

