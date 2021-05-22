
#!/bin/bash
#PBS -A nn9572k
#PBS -l walltime=80:00:00
#PBS -l select=16:ncpus=32:mpiprocs=16

# NVT 24.06
# 8: 52 ns/day
# 16: 85 ns/day

module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR

 #rm *#* *.edr* *.tpr* *.trr* *sh.* *.xtc* *.log*
 #rm em.gro NVT.gro NPT.gro

 # EM
 #gmx grompp -f em.mdp -c salted30.gro -p topol.top -o em.tpr  -maxwarn 3
 #mpiexec_mpt  mdrun   -s  em.tpr    -deffnm em   

 #gmx convert-tpr -s em.tpr -extend 50000 -o em.tpr
 #mpiexec_mpt mdrun -s em.tpr -cpi em.cpt -deffnm em

 # NVT
 #gmx grompp -f NVT.mdp -c em.gro -p topol.top -o NVT.tpr -maxwarn 3
 #mpiexec_mpt  mdrun   -s  NVT.tpr    -deffnm NVT   

 #gmx convert-tpr -s NVT.tpr -extend 200000 -o NVT.tpr
 #mpiexec_mpt mdrun -s NVT.tpr -cpi NVT.cpt -deffnm NVT

 # NPT
 #gmx grompp -f NPT_B.mdp -c NVT.gro -p topol.top -o NPT_B.tpr   -maxwarn 3  -t NVT.cpt
 #mpiexec_mpt  mdrun   -s  NPT_B.tpr    -deffnm NPT_B 

 gmx convert-tpr -s NPT_B.tpr -extend 200000 -o NPT_B.tpr
 mpiexec_mpt mdrun -s NPT_B.tpr -cpi NPT_B.cpt -deffnm NPT_B



