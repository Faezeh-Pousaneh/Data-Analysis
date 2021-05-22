#!/bin/bash 
#PBS -A nn9572k
#PBS -l walltime=07:05:00
#PBS -l select=1:ncpus=32:mpiprocs=16

module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR

rm MM_*
 rm *step*   *em.gro*   *.sh.*    *#*    *.edr*      *.tpr*        *.trr*   *.xtc*  *.log*  
 rm   NVT.gro  NVT_e.gro    NPT.gro  NVT2.gro NPT_e.*

P=9000.

cp ../IMPUT/em.mdp em.mdp
cp ../IMPUT/NVT_e.mdp NVT_e.mdp
cp ../IMPUT/NPT.mdp NPT.mdp
cp ../IMPUT/NVT.mdp NVT.mdp
cp ../IMPUT/NVT2.mdp NVT2.mdp
cp ../IMPUT/box.gro box.gro

sed "s/ ref_p                     =/ ref_p                     = $P;/" NVT_e.mdp -i
sed "s/ ref_p                     =/ ref_p                     = $P;/" NPT.mdp -i
sed "s/ ref_p                     =/ ref_p                     = $P;/" NVT.mdp -i
sed "s/ ref_p                     =/ ref_p                     = $P;/" NVT2.mdp -i

 gmx grompp -f em.mdp -c box.gro  -p topol.top -o em.tpr  -maxwarn 3
 mpiexec_mpt  mdrun   -s  em.tpr    -deffnm em   -table Table_HS_modif.xvg

 gmx grompp -f NVT_e.mdp -c em.gro -p topol.top -o NVT_e.tpr -maxwarn 3
 mpiexec_mpt  mdrun   -s  NVT_e.tpr    -deffnm NVT_e   -table Table_HS_modif.xvg

 gmx grompp -f NPT.mdp -c NVT_e.gro -p topol.top -o NPT.tpr   -maxwarn 3 -t NVT_e.cpt
 mpiexec_mpt  mdrun   -s  NPT.tpr    -deffnm NPT   -table Table_HS_modif.xvg

 gmx grompp -f NVT.mdp -c NPT.gro -p topol.top -o NVT.tpr   -maxwarn 3 -t NPT.cpt
 mpiexec_mpt  mdrun   -s  NVT.tpr    -deffnm NVT  -table Table_HS_modif.xvg



echo 0 | gmx tcaf  -f NVT.trr -s NVT.tpr -normalize -b 1000  -ov  MM_1000.xvg
echo 0 | gmx tcaf  -f NVT.trr -s NVT.tpr -normalize -b 2000  -ov  MM_2000.xvg
echo 0 | gmx tcaf  -f NVT.trr -s NVT.tpr -normalize -b 3000  -ov  MM_3000.xvg
echo 0 | gmx tcaf  -f NVT.trr -s NVT.tpr -normalize -b 4000  -ov  MM_4000.xvg

rm NVT.t*
rm NVT.x*


 gmx grompp -f NVT2.mdp -c NPT.gro -p topol.top -o NVT2.tpr   -maxwarn 3  -t NPT.cpt
 mpiexec_mpt  mdrun   -s  NVT2.tpr    -deffnm NVT2  -table Table_HS_modif.xvg


rm *#*

