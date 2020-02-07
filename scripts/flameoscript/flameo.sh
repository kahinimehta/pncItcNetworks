

bblid=/cbica/projects/GURLAB/projects/pncitc/subjectData/demographics/n307_bblid_scanid.csv
imagedir=/cbica/projects/GURLAB/projects/pncitc/output/seedcorrmaps/seed/
scriptdir=/cbica/projects/GURLAB/projects/pncitc/scripts
outputdir=/cbica/projects/GURLAB/projects/pncitc/output/seedcorrmaps/


imagelist1=$scriptdir/flameolistseed1.csv
imagelist1=$scriptdir/flameolistseed2.csv


rm -rf $imagelist1 $imagelist2


cat $bblid | while IFS=" " read -r a b ; 

do 
     img1=$(ls -f $imagedir/mask1/${a}_${b}_connectivity_mask1Z_sm6.nii.gz)
     img2=$(ls -f $imagedir/mask2/${a}_${b}_connectivity_mask2Z_sm6.nii.gz)
     
     echo $img1 >> $imagelist1
     echo $img2 >> $imagelist2

done 


mask=/cbica/projects/GURLAB/projects/pncitc/subjectData/PNCgrey2mm.nii.gz

fslmerge -t ${outputdir}/4Dcopeseed1.nii.gz $(cat $imagelist1)
fslmerge -t ${outputdir}/4Dcopeseed2.nii.gz $(cat $imagelist2)



flameo --copefile=${outputdir}/4Dcopeseed1.nii.gz   --mask=${mask}   --dm=${scriptdir}/desigmatlogkonly.mat  --tc=${scriptdir}/contrast4.con  --cs=${scriptdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask1/logk
flameo --copefile=${outputdir}/4Dcopeseed1.nii.gz   --mask=${mask}   --dm=${scriptdir}/designmatlogkage.mat  --tc=${scriptdir}/contrast3.con  --cs=${scriptdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask1/logkage
flameo --copefile=${outputdir}/4Dcopeseed1.nii.gz   --mask=${mask}   --dm=${scriptdir}/designmatlogksex.mat  --tc=${scriptdir}/contrast3.con  --cs=${scriptdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask1/logksex


flameo --copefile=${outputdir}/4Dcopeseed2.nii.gz   --mask=${mask}   --dm=${scriptdir}/desigmatlogkonly.mat  --tc=${scriptdir}/contrast4.con  --cs=${scriptdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask2/logk
flameo --copefile=${outputdir}/4Dcopeseed2.nii.gz   --mask=${mask}   --dm=${scriptdir}/designmatlogkage.mat  --tc=${scriptdir}/contrast3.con  --cs=${scriptdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask2/logkage
flameo --copefile=${outputdir}/4Dcopeseed2.nii.gz   --mask=${mask}   --dm=${scriptdir}/designmatlogksex.mat  --tc=${scriptdir}/contrast3.con  --cs=${scriptdir}/grp.grp --runmode=flame1 --ld=$outputdir/mask2/logksex
