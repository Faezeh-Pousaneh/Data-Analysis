
#!/bin/bash
#PBS -A nn9573k 
#PBS -l walltime=60:30:00
#PBS -l select=16:ncpus=32:mpiprocs=16


module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR


rm NPT_B.t* NPT_B.edr  NPT_B.xtc  NPT_B.log

 gmx grompp -f NPT_B.mdp -c f.gro -p topol.top -o NPT_B.tpr   -maxwarn 3 
 mpiexec_mpt  mdrun   -s  NPT_B.tpr    -deffnm NPT_B





