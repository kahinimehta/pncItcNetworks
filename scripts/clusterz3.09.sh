
   dir1=/cbica/projects/GURLAB/projects/pncitc
  grf_fslcluster.sh -i ${dir1}/output/cwas307/logk_motion_sex_age2/zstats_logk.nii.gz  \ # zstats dfrom mdmr
   -m ${dir1}//output/cwas307/mask.nii.gz \ # mask 
   -t 3.09 \ # high threshold 
    -o ${dir}/output/  # output directory 
    