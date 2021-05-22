
#!/bin/bash
#PBS -A nn9572k
#PBS -l walltime=13:30:00
#PBS -l select=4:ncpus=32:mpiprocs=16


module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR



#array=( 0.045  0.09 0.27 0.54 0.90 2.70  )

array=( 2.70  )
for j in "${array[@]}"
do

cd ${j}salt
rm sq_weo*


echo 4 | gmx saxs -f NPT_rdf.xtc -s NPT_rdf.tpr -b 400 -sq sq_weo.xvg
 
cd ..
done




