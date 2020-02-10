bblid=/cbica/projects/GURLAB/projects/pncitc/demographics/n307_blbid_scanid.csv
imagedir=/cbica/projects/GURLAB/projects/pncitc/output/seedcorrmaps/seed/
scriptdir=/cbica/projects/GURLAB/projects/pncitc/scripts
outputdir=/cbica/projects/GURLAB/projects/pncitc/output/seedcorrmaps
demogdir=/cbica/projects/GURLAB/projects/pncitc/demographics


imagelist1=$scriptdir/flameolistseed1.csv
imagelist2=$scriptdir/flameolistseed2.csv


rm -rf $imagelist1
rm -rf $imagelist2


cat $bblid | while IFS="," read -r a b ; 

do 
     img1=$(ls -f $imagedir/mask1/${a}_${b}_connectivity_mask1Z_sm6.nii.gz)
     img2=$(ls -f $imagedir/mask2/${a}_${b}_connectivity_mask2Z_sm6.nii.gz)
     
     echo $img1 >> $imagelist1
     echo $img2 >> $imagelist2

done 


mask=/cbica/projects/GURLAB/projects/pncitc/subjectData/PNCgrey2mm.nii.gz

fslmerge -t ${outputdir}/4Dcopeseed1.nii.gz $(cat $imagelist1)
fslmerge -t ${outputdir}/4Dcopeseed2.nii.gz $(cat $imagelist2)

flameo --copefile=${outputdir}/4Dcopeseed1.nii.gz   --mask=${mask}   --dm=${demogdir}/desigmatlogkonly.mat  --tc=${demogdir}/contrast4.con  --cs=${demogdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask1/logk

flameo --copefile=${outputdir}/4Dcopeseed2.nii.gz   --mask=${mask}   --dm=${demogdir}/desigmatlogkonly.mat  --tc=${demogdir}/contrast4.con  --cs=${demogdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask2/logk
