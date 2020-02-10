

singularity exec -e -B /cbica:/cbica/home/adebimpa/cbica  \
/cbica/projects/GURLAB/applications/bids_apps/cwasmdmr.simg \
/usr/local/bin/Rscript /usr/local/bin/connectir_mdmr.R  \ # connectome script 
--indir=/cbica/home//adebimpa/cbica/projects/GURLAB/projects/pncitc/output/cwas307 \ # matrix output 
--formula=logk+relMeanRMSmotion+sex+age \ #formula
--model=/cbica/home//adebimpa/cbica/projects/GURLAB/projects/pncitc/demographics/n307_demographics.csv \  #model 
--factors2perm=logk  --save-perms -c 30 -t 20  --ignoreprocerror logk_motion_sex_age