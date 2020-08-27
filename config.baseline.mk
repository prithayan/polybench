LLVM_HOME=/localscratch/pbarua3/IBM/llvm-project/build/bin
CC=${LLVM_HOME}/clang
UNROLLJAM_OPTIONS=-fexperimental-new-pass-manager -O3 -fno-inline-functions -fno-slp-vectorize -fno-vectorize  -Rpass=unroll
CFLAGS=-DPOLYBENCH_PAPI -I/${PAPI_DIR}/include -L/${PAPI_DIR}/lib -lpapi -DLARGE_DATASET -DPOLYBENCH_USE_RESTRICT -DPOLYBENCH_USE_SCALAR_LB -DUNROLL_1=${UNROLL1} -DUNROLL_2=${UNROLL2} ${UNROLLJAM_OPTIONS}
