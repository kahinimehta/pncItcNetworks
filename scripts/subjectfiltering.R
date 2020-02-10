

# read the subject demographics
restdatapnc=read.csv('~/Box/projects/ITC2/demographics/n2416_RestQAData_20170714.csv') # pnc QA for resting-state data
nmel=read.csv('~/Box/projects/ITC2/demographics/n452_pnc_itc_whole_sample_20160825.csv') # Marieta final subject QA  
pncitc=merge(nmel,restdatapnc,by=c('bblid','scanid')) # merge by Ids  


# select the neccessary variable for screening and further processing
# age, logk, sex, rest exclusion  variables: voxelwise and motion
pncit1 <- data.frame(
  pncitc$bblid,
  pncitc$scanid,pncitc$logk,pncitc$ageAtScan,pncitc$logAlpha,pncitc$sex,pncitc$race,pncitc$race2,pncitc$restExclude,pncitc$restExcludeVoxelwise,
  pncitc$restNoDataExclude,pncitc$relMeanRMSmotion,pncitc$restNSpikesMotion,pncitc$restNSpikesMotionExclude,pncitc$restRelMeanRMSMotionExclude
)

colnames(pncit1)=c('bblid',
                   'scanid','logk','ageAtScan','logAlpha','sex','race','race2','restExclude','restExcludeVoxelwise',
                   'restNoDataExclude','relMeanRMSmotion','restNSpikesMotion','restNSpikesMotionExclude','restRelMeanRMSMotionExclude')

pncit1=pncit1[which(pncit1$restExcludeVoxelwise==0),]
pncit1=pncit1[which(pncit1$restRelMeanRMSMotionExclude==0),]
pncit1=pncit1[-which(is.na(pncit1$relMeanRMSmotion)),]


# during manual checking, one subject (id:96832) has data points 90 less than 120 expected 
pncit1=pncit1[-which(pncit1$bblid==96832),]

#get the ids of final subjects
ids=data.frame(pncit1$bblid,pncit1$scanid) # get bblid and scanid for futher analyses 

# write out demographics and bblid and scanid
write.csv(ids,'~/Box/projects/ITC2/demographics/n307_blbid_scanid.csv',row.names = FALSE,quote = FALSE)
pncit1$age=pncit1$ageAtScan/12
write.csv(pncit1,'~/Box/projects/ITC2/demographics/n307_demographics.csv',row.names = FALSE,quote = FALSE)