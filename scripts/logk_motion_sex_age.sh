

singularity exec -e -B /cbica:/cbica/home/adebimpa/cbica  \
/cbica/projects/GURLAB/applications/bids_apps/cwasmdmr.simg \
/usr/local/bin/Rscript /usr/local/bin/connectir_mdmr.R  \
--indir=/cbica/home//adebimpa/cbica/projects/GURLAB/projects/pncitc/output/cwas307 \
--formula=logk+relMeanRMSmotion+sex+age --model=/cbica/home//adebimpa/cbica/projects/GURLAB/projects/pncitc/subjectData/demographics/n307_demographics.csv \ 
--factors2perm=logk --save-perms -c 30 -t 20  --ignoreprocerror logk_motion_sex_age