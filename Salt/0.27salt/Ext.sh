#!/bin/bash
#PBS -A nn9573k
#PBS -l walltime=18:30:60
#PBS -l select=16:ncpus=32:mpiprocs=16
 
module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR


gmx convert-tpr  -s  NPT.tpr -extend  200000 -o NPT.tpr
mpiexec_mpt  mdrun   -s  NPT.tpr    -deffnm NPT -append    -cpi  NPT.cpt  

