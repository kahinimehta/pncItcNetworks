# multivariate analysis with flameo12 

# design  and contrast file 
projectdir=/data/jux/BBL/projects/pncItcNetworks
design=$projectdir/scripts
copefile1=$projectdir/subjectData/n269/n269_pearson/logk_motion_sex/cluster_correct_v001_c05/easythresh/ROI2map
maskfile=/data/joy/BBL/studies/pnc/template/priors/prior_mask.nii.gz

#mkdir $projectdir/seedcorrmap
mkdir $projectdir/seedcorrmap/seed2

outputdir1=$projectdir/seedcorrmap/seed2


#merge the files to 4D
fslmerge -t  $outputdir1/ROI2map4D.nii.gz $copefile1/*ROI2map_z.nii.gz



flameo --copefile=$outputdir1/ROI2map4D.nii.gz  --mask=$maskfile  --dm=$design/design.mat --tc=$design/contrast.con --cs=$design/grp.grp --runmode=flame1 --ld=$outputdir1/stats 



flameo --copefile=$outputdir1/ROI2map4D.nii.gz  --mask=$maskfile  --dm=$design/design_mean.mat --tc=$design/contrast.con --cs=$design/grp.grp --runmode=flame1 --ld=$outputdir1/stats_demean



