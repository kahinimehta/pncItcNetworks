
#dti scrip directory 
dtirun=/data/joy/BBL/applications/DSI-Studio # call to run by $dtirun/dsi_studio
dtisubjdir=/data/joy/BBL/studies/pnc/processedData/diffusion/deterministic_20171118 #dtisubject diretcory 
datadir=$(ls -d /data/jux/BBL/projects/pncItcNetworks/subjectData)
scanid=$(cat /data/jux/BBL/projects/pncItcNetworks/scripts/dti/dti_T1_scanid.txt) 
bblid=$(cat /data/jux/BBL/projects/pncItcNetworks/scripts/dti/dti_T1_bblid.txt) 
outputdir=/data/jux/BBL/projects/pncItcNetworks/output/dtidensity
mkdir $outputdir

roiseed=/data/jux/BBL/projects/pncItcNetworks/output/n269/n269_pearson/logk_motion_scanageYrs/cluster_correct_v001_c05/easythresh/ROI.nii.gz # in PNC


c=0
for b  in $bblid;  do 
     
     set -- $scanid
     arr=($scanid)
     s=${arr[$c]}
     echo "$s" 	

#tr
     structdir=/data/joy/BBL/studies/pnc/processedData
     dti_refVol=$structdir/diffusion/dti2xcp_201606230942/${b}/*x${s}/dti2xcp/${b}*x${s}_referenceVolume.nii.gz
     struct2seq_coreg=$structdir/diffusion/dti2xcp_201606230942/${b}/*x${s}/coreg/${b}_*x${s}_struct2seq.txt
     antsDir=$structdir/structural/antsCorticalThickness/${b}/*x${s}
     pncTemplate2subjAffine=$antsDir/TemplateToSubject1GenericAffine.mat
     pncTemplate2subjWarp=$antsDir/TemplateToSubject0Warp.nii.gz
     #pncTransformDir=/home/rciric/xcpAccelerator/xcpEngine/space/PNC/PNC_transforms

     

      antsApplyTransforms -e 3 -d 3 -i $roiseed -r ${dti_refVol} -o $outputdir/ROI_SUBJ_NATIVE.nii.gz -t ${struct2seq_coreg} -t ${pncTemplate2subjAffine} -t ${pncTemplate2subjWarp} -n MultiLabel


# dsistudio 
     cd  /home/aadebimpe/dtistudio 
     cp  $dtisubjdir/${b}/*x${s}/dsiStudioRecon/*.dti.fib.gz  image.src.gz.fy.dti.fib.gz
     cp  $outputdir/ROI_SUBJ_NATIVE.nii.gz ROI.nii.gz
  /share/apps/singularity/2.5.1/bin/singularity exec dsi-studio-docker-latest.simg /dsistudio/dsi_studio_64/dsi_studio --action=trk --source=image.src.gz.fy.dti.fib.gz --roi=ROI.nii.gz --output=track.nii.gz --export=tdi --fa_threshold=0.1 --random_seed=1 --turning_angle=35 --step_size=1 --fiber_count=500000 --thread_count=1


        fslcpgeom  $dti_refVol track.nii.gz.tdi.nii.gz -d 
        fslorient -swaporient track.nii.gz.tdi.nii.gz 

       subj2TemplateWarp=${antsDir}/SubjectToTemplate1Warp.nii.gz
       subj2TemplateAffine=${antsDir}/SubjectToTemplate0GenericAffine.mat
       seq2struct_coreg=/data/joy/BBL/studies/pnc/processedData/diffusion/dti2xcp_201606230942/${b}/*x$s/coreg/${b}_*${s}_seq2struct.txt 
       dti_input=/data/jux/BBL/projects/pncItcNetworks/output/dtidensity/${s}_trackdti.nii.gz
       pnc_template=/data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz


       antsApplyTransforms -e 3 -d 3 -i track.nii.gz.tdi.nii.gz -r ${pnc_template} -o $outputdir/${s}_tractdensity.nii.gz     -t ${subj2TemplateWarp} -t ${subj2TemplateAffine} -t ${seq2struct_coreg} -n NearestNeighbor
       
 c=$(($c+1));

     
done


exit




