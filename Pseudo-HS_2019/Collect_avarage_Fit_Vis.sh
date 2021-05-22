#!/bin/bash 
#!/usr/local/bin/gnuplot -persist


rm summary_distances.dat

array=(10 100 200 300 500 700 1000 1200 1600 2000 3000 3500 4000 4500 5500 6000 6500 8000   )

for j in "${array[@]}"
do

rm *#*
cd P$j
rm *#*

rm summary_distances.dat
cp Fit_VIS_table.txt  Fit_VIS_table.xvg

rm errest* aver*
rm density*


echo 13 | gmx energy -f NPT.edr  -o density.xvg -b 10000
echo 8 | gmx energy -f NPT.edr  -o pressure.xvg -b 10000
echo 29 | gmx energy -f NVT2.edr  -o PPM.xvg -b 2000

gmx analyze -f Fit_VIS_table.xvg  -ee errest_Fit.xvg 
gmx analyze -f density.xvg  -ee errest_Dens.xvg
gmx analyze -f pressure.xvg  -ee errest_pressure.xvg
gmx analyze -f PPM.xvg  -ee errest_PPM.xvg

sed -n  's/@ s1 legend "ee //p'      errest_Fit.xvg   > Fit_err.txt
sed 's/"//' Fit_err.txt -i

sed -n  's/@ s0 legend "av //p'      errest_Fit.xvg   > Fit_av.txt
sed 's/"//' Fit_av.txt -i

sed -n  's/@ s1 legend "ee //p'      errest_Dens.xvg  > Dens_err.txt
sed 's/"//' Dens_err.txt -i

sed -n  's/@ s0 legend "av //p'      errest_Dens.xvg   > Dens_av.txt
sed 's/"//' Dens_av.txt -i

sed -n  's/@ s1 legend "ee //p'      errest_pressure.xvg   > pressure_err.txt
sed 's/"//' pressure_err.txt -i


sed -n  's/@ s0 legend "av //p'      errest_pressure.xvg   > pressure_av.txt
sed 's/"//' pressure_av.txt -i



sed -n  's/@ s1 legend "ee //p'      errest_PPM.xvg   > PPM_err.txt
sed 's/"//' PPM_err.txt -i


sed -n  's/@ s0 legend "av //p'      errest_PPM.xvg   > PPM_av.txt
sed 's/"//' PPM_av.txt -i

a=`tail -1  Dens_av.txt  | awk '{print ($1/(39.9400*1.660))*(0.34094)^3.0}'`
b=`tail -1  Dens_err.txt  | awk '{print ($1/(39.9400*1.660))*(0.34094)^3.0}'`
c=`tail -1  Fit_av.txt  | awk '{print $1*100.0/11.03510}'`
d=`tail -1  Fit_err.txt  | awk '{print $1*100.0/11.03510}'`
k=`tail -1  pressure_av.txt  | awk '{print $1*1.59722*0.0010}'`
l=`tail -1  pressure_err.txt  | awk '{print $1*1.59722*0.0010}'`
m=`tail -1  PPM_av.txt  | awk '{print (1.0/$1)*100000.0/11.03510}'`
n=`tail -1  PPM_err.txt  | awk '{print $1 }'`
p=`tail -1  PPM_av.txt  | awk '{print $1 }'`

f= awk 'BEGIN {max = 0.00000} {if ($1>max) max=$1} END {print max}' Fit_VIS_err.txt > max_err.dat
g=`tail -1  max_err.dat  | awk '{print $1*100.0/11.03510}'`  


echo "scale=15;${d}+${g}" | bc > t.dat
z=`tail -1  t.dat  | awk '{print $1}'`


echo "scale=15;(${n}/(${p}*${p}))*(100000.0/11.03510)" | bc > t2.dat
q=`tail -1  t2.dat  | awk '{print $1}'`

echo "scale=15;$j*1.597220*0.001" | bc > p.dat
p=`tail -1  p.dat  | awk '{print $1}'`

echo P$j   ${p}  ${k}  ${l} ${a}   ${b}  ${c}   ${z}   ${m}    ${q} >> ../summary_distances.dat




cd ..
done

