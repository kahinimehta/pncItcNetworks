#scanids 
datadir=$(ls -d /data/jux/BBL/projects/pncItcNetworks/subjectData)
scanid=$(cat $datadir/demographics/dti_scanid.txt)
bblid=$(cat $datadir/demographics/dti_bblid.txt)

outputdir=/data/joy/BBL/studies/pnc/processedData/diffusion/deterministic_20171118
#data format in imagedir
#rm $datadir/imageinput1.txt # remove previous output if exit 


c=0
for b  in $bblid;  do 
     
  
     set -- $scanid
     arr=($scanid)
     s=${arr[$c]}
     echo "$s" 	
     
     echo "    "
     dd=$(ls -d $outputdir/${b}/*${s})
      if [ -d $dd] 
      then 
       echo "$b, $s">>noT1.txt
      else 
       echo "$b" >>dti_T1_bblidid.txt 
        echo "$s" >>dti_T1_scanid.txt  
      
      fi
      
      c=$(($c+1));
     
done
	
exit 
