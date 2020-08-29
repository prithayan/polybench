#!/bin/bash
set -o xtrace
MAXUNROLL=8
MAXUNROLL2=$MAXUNROLL
MAXUNROLL1=$MAXUNROLL
#MAXUNROLL2=1

for (( unroll1=1; unroll1<=$MAXUNROLL; unroll1=$unroll1*2 )); do
  for (( unroll2=1; unroll2<=$MAXUNROLL1; unroll2=$unroll2*2 )); do
#    for (( unroll3=1; unroll3<=$MAXUNROLL2; unroll3=$unroll3*2 )); do
    export UNROLL1=$unroll1
    export UNROLL2=$unroll2
    export UNROLL3=$unroll3
      make clean ; make
      #echo -n "$unroll1 , $unroll2 , $unroll3," >> runtime.csv
      echo -n "$unroll1 , $unroll2 ," >> runtime.csv
      ./bicg  >> runtime.csv
      #bash ../../../utilities/time_benchmark.sh ./bicg >> runtime.csv
      #PerfTempOut="perfout_${unroll1}_${unroll2}.csv"
      #~/sftwr/bin/bin/valgrind --tool=cachegrind --D1=32768,8,128 --I1=32768,8,128 --LL=524288,8,128 --cachegrind-out-file=valCacheOut_${unroll1}_${unroll2}.txt ./bicg
      #~/sftwr/bin/bin/cg_annotate  valCacheOut_${unroll1}_${unroll2}.txt 2>&1 > annotateCG__${unroll1}_${unroll2}.txt
      #perf stat -e cycles,instructions,cache-references,cache-misses,L1-dcache-loads,L1-dcache-load-misses,branches,branch-misses,L1-icache-loads,L1-icache-load-misses -x, -o  $PerfTempOut  ./bicg
#    done
  done
done

