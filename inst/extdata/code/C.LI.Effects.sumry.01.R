function (Links.mat)
# Function:           C.LI.Effects.sumry.01
# Description:        General controller for summarising the elements (columns) affecting elements (rows)
# Primary attributes: As for predator-prey system, determine predators that affect each prey

# Input parameters:   Matrix of linkages (does not have to be rows=cols) with Elements in columns affecting elements in rows

# Returned            List with one item per row giving the column numbers that impact on it
#                     e.g. list of each taxa in biota with a vector of numbers (as per address in biota)
#                          relating to which predators eat it
#
#                     NB if all columns do not affect a row then a vector of length '0' will be returned for that row

########################################################
#      Signature <- list(
#        ID           =  11005,
#        Name.full    = "Effects.summary",
#        Name.short   = "Effects01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "29 May 2005"
#        ) # end Signature


########################################################
{
# replace values greater than zero with respective column numbers and return only the column numbers greater than zero
# for each row - returned in a list of vectors - one for each row.

# 1. make values greater than zero equal to 1
#           protect against values greater than one by dividing each element in Links.mat by itself
# 2. multiply matrix of column numbers by binary matrix

      m1<-col(Links.mat)*Links.mat/Links.mat

# 3. for each column select elements greater than zero
      Links<-NULL

      for (i in 1:nrow(m1)) {
        v1<-as.vector(na.omit(m1[i,m1[i,]>0]))
        L1<-list(v1)
        Links<-c(Links,L1)
      }

# 4. return list of elements for each column

Links

}

