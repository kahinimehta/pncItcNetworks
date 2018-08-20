# multivariate analysis with flameo12 

# design  and contrast file 
projectdir=/data/jux/BBL/projects/pncItcNetworks
design=$projectdir/scripts
copefile1=$projectdir/subjectData/n269/n269_pearson/logk_motion_scanageYrs/cluster_correct_v001_c05/easythresh/ROI1map
maskfile=/data/joy/BBL/studies/pnc/template/priors/prior_mask.nii.gz

mkdir $projectdir/seedcorrmap_motion_age


outputdir1=$projectdir/seedcorrmap_motion_age


#merge the files to 4D

flameo --copefile=$outputdir1/ROI1map4D.nii.gz  --mask=$maskfile  --dm=$design/design.mat --tc=$design/contrast.con --cs=$design/grp.grp --runmode=flame1 --ld=$outputdir1/stats 



flameo --copefile=$outputdir1/ROI1map4D.nii.gz  --mask=$maskfile  --dm=$design/design_mean.mat --tc=$design/contrast.con --cs=$design/grp.grp --runmode=flame1 --ld=$outputdir1/stats_demean



