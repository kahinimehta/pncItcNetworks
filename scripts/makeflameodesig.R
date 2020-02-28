
# script to make the design matrices for flameo

library(pracma)
demogr=read.csv('~/Box/projects/ITC2/demographics/n307_demographics.csv')
#logk+relMeanRMSmotion+age+sex 
desigmatlogkonly=cbind(rep(1,307),demogr$logk,demogr$sex,demogr$relMeanRMSmotion,demogr$age)

grp=ones(307,1) # only one group

contrast4=zeros(5,5); 
diag(contrast4)=1; 


write.table(desigmatlogkonly,'~/Box/projects/ITC2/demographics/desigmatlogkonly.txt',sep=' ',quote = FALSE,row.names = FALSE,col.names = FALSE)
write.table(contrast4,'~/Box/projects/ITC2/demographics/contrast4.txt',sep=' ',quote = FALSE,row.names = FALSE,col.names = FALSE)
write.table(grp,'~/Box/projects/ITC2/demographics/grp.txt',sep=' ',quote = FALSE,row.names = FALSE,col.names = FALSE)
