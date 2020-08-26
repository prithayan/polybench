#!/bin/bash
set -o xtrace
#DIR="/localscratch/pbarua3/IBM/benchmark/unroll-project-experiments/polybench/exp/polybench-c-4.2.1-beta"
DIR=$1
kernel=$2
targetDir=$3
OUTFILE=$4
CfgFile="$DIR/config.mk";
OutputMake="$DIR/outputMakefile";
OutputMakeBase="$DIR/outputMakefile.baseline";
PerfCsvOut="$DIR/perfExp.csv"
PerfCsvOut="$DIR/tmp"
PerfTempOut="temp.perfout"
ProfileCmd="perf stat -e cycles,instructions,cache-references,cache-misses,L1-dcache-loads,L1-dcache-load-misses,branches,branch-misses,L1-icache-loads,L1-icache-load-misses -x, -o  $PerfTempOut ./$kernel "
ProfileCmd="timeout 120m bash $DIR/utilities/time_benchmark.sh ./$kernel"
#ProfileCmd="perf stat -e cycles,L1-dcache-loads,L1-dcache-load-misses -x, -o  $PerfTempOut ./$kernel "
#if grep -q "pragma unroll_and_jam" *.c; then
  echo found
  echo $targetDir >> $PerfCsvOut ;  
  echo $targetDir >>  $OutputMakeBase ;  
  echo "BASELINE=========" >> $OutputMakeBase ;
	make clean; timeout 45m make -f Makefile.baseline 2>>$OutputMakeBase ; O0=`$ProfileCmd` ;
  #O0=`grep "L1\|cycles" $PerfTempOut | cut -f1 -d',' | perl -p  -e 's/\R/,/g;'`;
  mv $kernel ${kernel}_baseline
  #perl -p  -e 's/\R//g;'  $PerfTempOut >> $PerfCsvOut ; echo "" >> $PerfCsvOut
  echo $targetDir >>  $OutputMake ;  
  echo "UnJ Pass=========" >> $OutputMake
	make clean; timeout 45m make -f Makefile 2>>$OutputMake ; O1=`$ProfileCmd` ;
  #O1=`grep "L1\|cycles" $PerfTempOut | cut -f1 -d',' | perl -p  -e 's/\R/,/g;'` ;
	echo -n $targetDir >> $OUTFILE; echo ",$O0,$O1" >> $OUTFILE; 
