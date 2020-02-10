
# this script extracts positive and negative seed-based correlation value
# from zstats mask of logk for each mask

# zstats (fdrcorrected) are thresholded at p=0.05 for both negative and positive  values
# the masks are binarized and mean value are extratced from seed-correlation map of each subjects


#set the library paths and read read all the required packages 
.libPaths("/cbica/home/adebimpa/R/x86_64-conda_cos6-linux-gnu-library/3.6") 
rm(list = ls())
library(RNifti)
library(pracma)

setwd('/cbica/projects/GURLAB/projects/pncitc/')

# make the masks
mask1=readNifti('/cbica/projects/GURLAB/projects/pncitc//output/seedcorrmaps/mask1/logk/zfdr2.nii.gz')
mask2=readNifti('/cbica/projects/GURLAB/projects/pncitc//output/seedcorrmaps/mask2/logk/zfdr2.nii.gz')

#get the  postive masks
p_m1=mask1; p_m1[p_m1>1.64]=0; p_m1[p_m1>0]=1
p_m2=mask2; p_m2[p_m2>1.64]=0; p_m2[p_m2>0]=1

#get the negative masks
n_m1=(-1)*mask1;  n_m1[n_m1>1.64]=0; n_m1[n_m1>0]=1
n_m2=(-1)*mask2;  n_m2[n_m2>1.64]=0; n_m2[n_m2>0]=1

#bblid and scanid 
b=read.csv('/cbica/projects/GURLAB/projects/pncitc/subjectData/demographics/n307_bblid_scanid.csv',header=FALSE)

#make table 

corrdata=zeros(307,6)

for (i in 1:307 ) {
     img1=readNifti(paste0('/cbica/projects/GURLAB/projects/pncitc/output/seedcorrmaps/seed/mask1/',b[i,1],'_',b[i,2],'_connectivity_mask1Z_sm6.nii.gz'))
     img2=readNifti(paste0('/cbica/projects/GURLAB/projects/pncitc/output/seedcorrmaps/seed/mask2/',b[i,1],'_',b[i,2],'_connectivity_mask2Z_sm6.nii.gz'))
     datap1=img1[p_m1==1]; datap2=img2[p_m2==1]
     datam1=img1[n_m1==1]; datam2=img2[n_m2==1]
     corrdata[i,]=c(b[i,1],b[i,2],mean(datap1),mean(datam1),mean(datap2),mean(datam2))
}

colnames(corrdata)=c('bblid','scanid','tpj_posmask','tpj_negmask','fro_posmask','fro_negmask')

write.csv(corrdata,'/cbica/projects/GURLAB/projects/pncitc/subjectData/n307_meanseedcorr.csv',quote = FALSE,row.names = FALSE) 