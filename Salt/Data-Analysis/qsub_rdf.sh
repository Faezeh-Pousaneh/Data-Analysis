#!/bin/bash
#!/usr/local/bin/gnuplot -persist

array=( 0.045  0.09 0.27 0.54 0.90   )
for j in "${array[@]}"
do

cd ${j}salt

cp ../2.70salt/V_rdf_2.7.sh   V_rdf_2.7.sh  
cp ../2.70salt/NPT_rdf.mdp   NPT_rdf.mdp
qsub  V_rdf_2.7.sh


cd ..
done


