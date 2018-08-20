#This script will
# merge rest and nback timeseries
# take a list of scanids to create imageslist required for 
# distance computation for rest and naback
 
#scanids 
datadir=$(ls -d  /data/jux/BBL/projects/pncItcNetworks/subjectData)
restdir=$(ls -d /data/jux/BBL/projects/pncItcNetworks/subjectData/restnifti)
nbackdir=$(ls -d /data/jux/BBL/projects/pncItcNetworks/subjectData/nbacknifti)
scanid=$(cat  $datadir/demographics/n292scanidrest.txt)
outputdir=$(ls -d /data/jux/BBL/projects/pncItcNetworks/subjectData/rest_nback_4mm)


#data format in imagedir
#rm $datadir/imageinput_rest_nback.txt # remove previous output if exit 

nsubj=$(echo $scanid | wc | awk '{print $2}')
	
	echo "$nsubj subjects"

for b  in $scanid;  do 

     img1=$(ls -d $restdir/${b}_rest.nii.gz)
     echo "$img1"
     img2=$(ls -d $nbackdir/${b}_nback.nii.gz)
     echo "$img2"
     echo "split the rest and nback to 2D "
     fslsplit $img1 $restdir/vol1
     fslsplit $img2 $nbackdir/vol2

     echo "merge all the 2Ds"

     fslmerge -t $outputdir/${b}_rest_nback.nii.gz $restdir/vol1* $nbackdir/vol2*

     rm -rf $restdir/vol1* $nbackdir/vol2*

     echo "downsample to 4mm "

     fslmaths $outputdir/${b}_rest_nback.nii.gz -subsamp2 $outputdir/${b}_rest_nback_4mm.nii.gz

     rm -rf $outputdir/${b}_rest_nback.nii.gz  # to free more space 
     imagelist=$(ls -d $outputdir/${b}_rest_nback_4mm.nii.gz)
     
     echo "$imagelist" >> $datadir/imageinput_rest_nback.txt
done
	
exit 
