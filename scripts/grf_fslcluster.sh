#!/usr/bin/env bash

###################################################################
#  ⊗⊗ ⊗⊗⊗⊗ ⊗⊗⊗⊗⊗⊗⊗⊗⊗ ⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗ ⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗⊗ ⊗⊗⊗⊗⊗⊗⊗⊗ ⊗⊗⊗⊗ ⊗⊗  #
###################################################################

###################################################################
# Combine all text file output
###################################################################

###################################################################
# Usage function
###################################################################
Usage(){
  echo ""; echo ""; echo ""
  echo "Usage: `basename $0`  grf_fslcluster.sh -i zstat -m mask -t threshold -o output"
  echo ""
  echo "Compulsory arguments:"
  echo "  -i : zstats: compulsory"
  echo "  -m: mask"
  echo "  -o : Output file name"
  echo "       "
  exit 2
}

###################################################################
# Parse arguments
###################################################################
while getopts "i:t:m:o:h" OPTION ; do
  case ${OPTION} in
    i)
      zstat=${OPTARG}
      ;;
    t)
      thresh=${OPTARG}
      ;;
    m)
      mask=${OPTARG}
      ;;
    o)
      outdir=${OPTARG}
      ;;
    h)
      Usage
      ;;
    *)
      Usage
      ;;
    esac
done

###################################################################
# Ensure that all compulsory arguments have been defined
###################################################################
[[ -z ${outdir} ]] && Usage
[[ -z ${zstat} ]] && Usage
[[ -z ${mask} ]] && Usage

###################################################################
# Now run through each file that we find and append it to the output file
###################################################################
 
if [[ -z ${thresh} ]]; then 
   thresh=2.3
   echo "voxel threshold is 2.3 (default)"
fi 

echo " find d and v " 
dv=$(smoothest -z ${zstat} -m ${mask})

id0=$(echo $dv |cut -d' ' -f2)
id1=$(echo $dv |cut -d' ' -f4)
echo " the dlh is ${id0}"
echo "                  "
echo " the number of volume: ${id1}"

mkdir -p ${outdir}/cluster_Z${thresh}

cluster -i ${zstat} -d ${id0} --volume=${id1} -t ${thresh} -p 0.05 \
   -o  ${outdir}/cluster_Z${thresh}/cluster_Z${thresh} >  \
    ${outdir}/cluster_Z${thresh}/cluster_Z${thresh}.csv

echo "done"









