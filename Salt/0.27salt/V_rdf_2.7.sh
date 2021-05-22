
#!/bin/bash
#PBS -A nn9572k 
#PBS -l walltime=4:30:00
#PBS -l select=4:ncpus=32:mpiprocs=16


module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR



 gmx grompp -f NPT_rdf.mdp -c NPT.gro -p topol.top -o NPT_rdf.tpr   -maxwarn 3 
 mpiexec_mpt  mdrun   -s  NPT_rdf.tpr    -deffnm NPT_rdf





