#This script will
# merge rest and nback timeseries
# take a list of scanids to create imageslist required for 
# distance computation for rest and naback
 
#scanids 
datadir=$(ls -d  /data/jux/BBL/projects/pncItcNetworks/subjectData)
restdir=$(ls -d /data/joy/BBL/studies/pnc/processedData/restbold/restbold_201607151621)

scanid=/data/jux/BBL/projects/pncItcNetworks/scripts/n307_bblid_scanid.csv #bblid and scandid 
outputdir=/data/jux/BBL/projects/pncItcNetworks/subjectData/rest4mm 
outputdir2=/data/jux/BBL/projects/pncItcNetworks/subjectData/rest #ouputdir 
mkdir -p $outputdir
mkdir -p $outputdir2

rm -rf $datadir/imageinput_rest.txt



cat $scanid | while IFS="," read -r a b c; 


do 

     img1=$(ls -d $restdir/${a}/*${b}/norm/*_std.nii.gz)
     echo "$img1"
     

     fslmaths ${img1} -subsamp2 $outputdir/${a}_${b}_rest_4mm.nii.gz

     imcp ${img1} $outputdir2/${a}_${b}_rest.nii.gz # to free more space 

     imagelist=$(ls -d $outputdir/${a}_${b}_rest_4mm.nii.gz)
     
     echo "$imagelist" >>  $datadir/imageinput_rest.txt

done


	