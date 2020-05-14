function (List,NamedElement)
# Function:           U.element.ref.in.list.01
# Description:        Return a reference number for a named element of a list
# Primary attributes: Return a reference number
# Returns:            Reference number

# Input parameters:   List    = list in which named element resides
#                     NamedElement  = name of the element
########################################################
#      Signature <- list(
#        ID           =  81003,
#        Name.full    = "Element Reference Number from list",
#        Name.short   = "Ref in list",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "12 June 2005"
#        ) # end Signature


########################################################
{

# locate NamedElement
    l1<-match(attributes(List)$names,NamedElement)

# coerce result into a matrix (single column)
    m1<-as.matrix(l1)

# create identity matrix
    m2<-row(m1)

# collapse into reference and return value

    as.vector(na.omit(m1*m2))[1]

}

