perl utilities/run-all.pl ./ /localscratch/pbarua3/unroll-jam/benchmarks/cgo_exp/polybench/INTEL_papi_result_enable_vect.csv
export VECT_OPTIONS="-fno-vectorize"
perl utilities/run-all.pl ./ /localscratch/pbarua3/unroll-jam/benchmarks/cgo_exp/polybench/INTEL_papi_result_enable_slp.csv
export VECT_OPTIONS="-fno-slp-vectorize -fno-vectorize"
perl utilities/run-all.pl ./ /localscratch/pbarua3/unroll-jam/benchmarks/cgo_exp/polybench/INTEL_papi_result_disabl_vect.csv
