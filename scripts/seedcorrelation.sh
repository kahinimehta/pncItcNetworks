


seedpoint1=/cbica/projects/GURLAB/projects/pncitc/output/cluster_Z3.09/mask1_2mm.nii.gz
seedpoint2=/cbica/projects/GURLAB/projects/pncitc/output/cluster_Z3.09/mask2_2mm.nii.gz

 bblid=/cbica/projects/GURLAB/projects/pncitc/demographics/n307_bblid_scandid.csv
 image=/cbica/projects/GURLAB/projects/pncitc/subjectData/rest/
 outputdir=/cbica/projects/GURLAB/projects/pncitc/output/seedcorrmaps

 mkdir -p ${outdir}

cat $bblid | while IFS="," read -r a b ; 

do 
     img=$(ls -f $image/${a}_${b}_rest.nii.gz)
     ${XCPEDIR}/utils/seedconnectivity -i $img -s $seedpoint1 -o $outputdir -p ${a},${b}  \
     -k 6 -n mask1 

     rm -rf $outputdir/seed/mask1/${a}_${b}_connectivity_mask1_seed.nii.gz

     ${XCPEDIR}/utils/seedconnectivity -i $img -s $seedpoint2 -o $outputdir -p ${a},${b}  \
     -k 6 -n mask2

     rm -rf $outputdir/seed/mask2/${a}_${b}_connectivity_mask1_seed.nii.gz

done