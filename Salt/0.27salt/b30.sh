
#!/bin/bash
#PBS -A nn9572k
#PBS -l walltime=20:00:00
#PBS -l select=8:ncpus=32:mpiprocs=16

# NVT 24.06
# 8: 52 ns/day
# 16: 85 ns/day

module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR


 gmx convert-tpr -s NPT.tpr -extend 100000 -o NPT.tpr
 mpiexec_mpt mdrun -s NPT.tpr -cpi NPT.cpt -deffnm NPT





