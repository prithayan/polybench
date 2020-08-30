#LLVM_HOME=/localscratch/pbarua3/IBM/llvm-project/build/bin
CC=${LLVM_HOME}/clang
UNROLLJAM_OPTIONS=${VECT_OPTIONS} -fexperimental-new-pass-manager -O3 -fno-inline-functions  -mllvm -enable-simple-unroll-and-jam -mllvm -enable-unroll-and-jam  -mllvm -allow-unroll-and-jam   -mllvm -unroll-and-jam-skip-dependency-checks -mllvm -allow-simple-unroll-and-jam -mllvm -enable-perfect-nest-unroll-and-jam  -mllvm -da-disable-delinearization-checks -DUNROLL_1=${UNROLL1} -DUNROLL_2=${UNROLL2} -DUNROLL_3=${UNROLL3}   -Rpass=unroll
PAPI=-DPOLYBENCH_PAPI -I/${PAPI_DIR}/include -L/${PAPI_DIR}/lib -lpapi -DEXTRALARGE_DATASET
#PAPI=-DPOLYBENCH_TIME
CFLAGS=${PAPI} -DEXTRALARGE_DATASET -DPOLYBENCH_USE_RESTRICT -DPOLYBENCH_USE_SCALAR_LB ${UNROLLJAM_OPTIONS}
#-DPOLYBENCH_PAPI -I/${PAPI_DIR}/include -L/${PAPI_DIR}/lib -lpapi 
