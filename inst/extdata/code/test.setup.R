function ()
{
  EnvSetup<-list()
# setup environments
EnvSetup<-c(EnvSetup,list(list(EnvParent = 0, eFn = test.0,EdSetName = "taxon1",EdSet = list(a=3,b=5,c=7))))
EnvSetup<-c(EnvSetup,list(list(EnvParent = 1, eFn = test.1,EdSetName = "action.1",EdSet = list(d=1,e=2,f=3))))
EnvSetup<-c(EnvSetup,list(list(EnvParent = 1, eFn = test.2,EdSetName = "action.2",EdSet = list(h=5,i=6,j=7))))


#assign("taxon1",list(a=3,b=5,c=7),Universe[[1]])     # assign parameter values to Universe environment
#assign("action.1",list(d=1,e=2,f=3),Universe[[2]])     # assign parameter values to function environment
#assign("action.2",list(h=5,i=6,j=7),Universe[[3]])     # assign parameter values to function environment
#EnvironList<-c(EnvironList,list(eFn = test.0, eEnv = parent.env))
#EnvironList<-c(EnvironList,list(eFn = test.0, eEnv = Universe[[1]]))
#EnvironList<-c(EnvironList,list(eFn = test.1, eEnv = Universe[[2]]))
#EnvironList<-c(EnvironList,list(eFn = test.2, eEnv = Universe[[3]]))
#EnvironList<-list(test.0,test.1,test.2)

#environment(test.0)<-Universe[[1]] # assign environment to nominated function
#environment(test.2)<-Universe[[3]] # assign environment to nominated function
#environment(test.1)<-Universe[[2]]  # assign environment to Diary function

EnvSetup
}

