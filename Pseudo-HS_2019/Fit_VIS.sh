#!/bin/bash 
#!/usr/local/bin/gnuplot -persist


array=(10 100 200 300 500 700 1000 1200 1600 2000 3000 3500 4000 4500 5500 6000 6500 8000 9000  )


for j in "${array[@]}"
do

rm *#*
cd P$j
rm Fit_VIS_table.*
for (( i=1000; i<5000; i += 1000 ))
do

gnuplot <<- EOF
reset
vai(k,a0,a1,a2)=a0*(1-a1*k*k)+a2*k*k*k*k

set xlabel "{k}^*"
set ylabel "{/Symbol h}^*"
set key top left Left reverse
set terminal postscript color enhanced
set print "Fit_VIS_table.txt" append
fit [0.001:4] vai(x,a0,a1,a2) "MM_${i}.xvg" u 1:2 via a0,a1,a2
print "",a0," \


unset table
set output
EOF
done 
cd ..
done




########################
# compile summary
#touch summary_distances.dat
#for (( i=1; i<10; i++ ))
#do
 #   d=`tail -n 1 dist${i}.xvg | awk '{print $2}'`
  #  echo "${i} ${d}" >> summary_distances.dat
   # rm dist${i}.xvg
#done

