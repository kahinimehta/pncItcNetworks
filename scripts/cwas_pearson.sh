#SING=/share/apps/singularity/2.5.1/bin/singularity # singularity directory on chead 
singimage=/cbica/projects/GURLAB/applications/bids_apps/cwasmdmr.simg # cwasmdmr image on chead
scriptdir=/usr/local/bin # script to run inside the image 


mdmrouput=/cbica/home//adebimpa/cbica/projects/GURLAB/projects/pncitc/output/cwas307 #output directory. note that i added /home/username in front 
brainmask=/cbica/home//adebimpa//cbica/projects/GURLAB/projects/pncitc/subjectData/PNCgrey.nii.gz #brainmask usually greymatter mask  
bgim=/cbica/home//adebimpa//cbica/projects/GURLAB/projects/pncitc/subjectData/PNCbrain.nii.gz #usually pnc template

imagelist=/cbica/home//adebimpa/cbica/projects/GURLAB/projects/pncitc/subjectData/imageinput_rest.csv # list of image in nifti # check image list, /home/username  
#modelcsv=/cbica/home//adebimpa/cbica/projects/GURLAB/projects/pncitc/subjectData/demographics/model.csv # demographic and factors, 
## 

#rm  -rf $mdmrouput # remove previous run if exist 
metric=pearson # pearson correllation 

# compute distance matrix

singularity exec -e -B /cbica:/cbica/home/adebimpa/cbica $singimage $scriptdir/Rscript $scriptdir/connectir_subdist.R \
        $mdmrouput \
	    --infuncs1=$imagelist \
	    --ztransform \
        --automask1  -c 3 -t 4 \
	    --brainmask1=$brainmask \
        --method="$metric"  \
        --bg=$bgim   --overwrite \
	    --memlimit=30 