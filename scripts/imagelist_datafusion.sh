#This script will take a list of scanids to create imageslist for data fustion
 
#scanids 

datadir=$(ls -d /data/jux/BBL/projects/pncItcNetworks/datafusion)
scanid=$(cat $datadir/demographic/fusion_scanid.txt)
bblid=$(cat $datadir/demographic/fusion_bblid.txt)


alffdir=$(ls -d /data/joy/BBL/studies/pnc/processedData/restbold/restbold_201607151621)
cortdir=$(ls -d /data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/t1struct/voxelwiseMaps_antsCt)


# make directory for the data

mkdir $datadir/niftidata 


nsubj=$(echo $scanid | wc | awk '{print $2}')
	
	echo "$nsubj subjects"
c=0
for b  in $bblid;  do 
     
     set -- $scanid
     arr=($scanid)
     s=${arr[$c]}
     echo "$s" 	
     echo "copy image the $b $s image"
     echo "    "
     mkdir $datadir/niftidata/${s}  
     mri_convert   $alffdir/${b}/*x${s}/alff/${b}_*x${s}_alff_Z.nii.gz  $datadir/niftidata/${s}/alff_${s}_alff.img 
     mri_convert   $cortdir/${s}_CorticalThicknessNormalizedToTemplate2mm.nii.gz $datadir/niftidata/${s}/cort_${s}_cort.img  
      
     c=$(($c+1));
    
done
	
exit 
