
#dti scrip directory 
dtirun=/data/joy/BBL/applications/DSI-Studio # call to run by $dtirun/dsi_studio
dtisubjdir=/data/joy/BBL/studies/pnc/processedData/diffusion/deterministic_20171118 #dtisubject diretcory 
datadir=$(ls -d /data/jux/BBL/projects/pncItcNetworks/subjectData)
scanid=$(cat $datadir/demographics/dti_scanid1.txt) 
bblid=$(cat $datadir/demographics/dti_bblid1.txt) 
outputdir=/data/jux/BBL/projects/pncItcNetworks/output/dticorr3
mkdir $outputdir

roiseed=/data/jux/BBL/projects/pncItcNetworks/output/n269/n269_pearson/logk_motion_scanageYrs/cluster_correct_v001_c05/easythresh/ROI1_2mm_bin.nii.gz # in PNC


c=0
for b  in $bblid;  do 
     
     set -- $scanid
     arr=($scanid)
     s=${arr[$c]}
     echo "$s" 	

#transform ROI to subject space
     mkdir $outputdir
     structdir=/data/joy/BBL/studies/pnc/processedData
     dti_refVol=$structdir/diffusion/dti2xcp_201606230942/${b}/*x${s}/dti2xcp/${b}*x${s}_referenceVolume.nii.gz
     struct2seq_coreg=$structdir/diffusion/dti2xcp_201606230942/${b}/*x${s}/coreg/${b}_*x${s}_struct2seq.txt
     antsDir=$structdir/structural/antsCorticalThickness/${b}/*x${s}
     pncTemplate2subjAffine=$antsDir/TemplateToSubject1GenericAffine.mat
     pncTemplate2subjWarp=$antsDir/TemplateToSubject0Warp.nii.gz
     #pncTransformDir=/home/rciric/xcpAccelerator/xcpEngine/space/PNC/PNC_transforms

     

      antsApplyTransforms -e 3 -d 3 -i $roiseed -r ${dti_refVol} -o $outputdir/ROI_SUBJ_NATIVE.nii.gz -t ${struct2seq_coreg} -t ${pncTemplate2subjAffine} -t ${pncTemplate2subjWarp} -n MultiLabel


# dsistudio 
     cd  /home/aadebimpe/big 

  /share/apps/singularity/2.5.1/bin/singularity exec dsi-studio-docker-latest.simg /dsistudio/dsi_studio_64/dsi_studio --action=trk --source=$(ls -d $dtisubjdir/${b}/*x${s}/dsiStudioRecon/*.dti.fib.gz) --roi=$outputdir/ROI_SUBJ_NATIVE.nii.gz --output=$outputdir/${s}_track.nii.gz --export=tdi --fa_threshold=0.1 --random_seed=1 --turning_angle=35 --step_size=1 --fiber_count=50000 --thread_count=1
    
 
   
       #transfor  the dti track density to PNC template
       pnctemplate=/data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz
       subj2templatewarp=$antsDir/SubjectToTemplate1Warp.nii.gz
       subj2templateAffine=$antsDir/SubjectToTemplate0GenericAffine.mat
       antsApplyTransforms -e 3 -d 3 -v  0  -i $outputdir/${s}_track.nii.gz  -o $outputdir/${s}_track_2mm.nii.gz  -r  $pnctemplate -t ${subj2templatewarp} -t ${subj2templateAffine}
              


 c=$(($c+1));

     
done


exit




