#!/bin/bash 
#PBS -A nn9572k
#PBS -l walltime=04:05:00
#PBS -l select=1:ncpus=32:mpiprocs=16

module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR



array=( 100 200 300 500 700 1000 1200 1600 2000 3000 3500 4000 4500 5500 6000 6500 8000 9000  )

for j in "${array[@]}"
do

cd P$j


sed "s/ cos_acceleration          =/ cos_acceleration          = 0.006;/" NVT2.mdp -i


 gmx grompp -f NVT2.mdp -c NPT.gro -p topol.top -o NVT2.tpr   -maxwarn 3  -t NPT.cpt
 mpiexec_mpt  mdrun   -s  NVT2.tpr    -deffnm NVT2  -table Table_HS_modif.xvg

cd ..
done
