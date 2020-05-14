function (Cday,Cmonth)
# Function:           U.ST.DayFromDate.01
# Description:        Return a day of the year from a given date
# Primary attributes: Return a calendar day
# Returns:            Calendar Day

# Input parameters:   Cday    = day of the date
#                     Cmonth  = month of the date
########################################################
#      Signature <- list(
#        ID           =  81002,
#        Name.full    = "Calendar day from day-month",
#        Name.short   = "CalDay from date",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "7 June 2005"
#        ) # end Signature


########################################################
{

DaysInMonth<-c(31,28,31,30,31,30,31,31,30,31,30,31)
CalDay<-0
if(Cmonth>1) CalDay<-sum(DaysInMonth[1:(Cmonth-1)])
CalDay<-CalDay+Cday
CalDay

}

