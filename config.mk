LLVM_HOME=/localscratch/pbarua3/IBM/llvm-project/build/bin
CC=${LLVM_HOME}/clang
UNROLLJAM_OPTIONS=-fexperimental-new-pass-manager -O3 -fno-inline-functions -fno-slp-vectorize -fno-vectorize -mllvm -enable-simple-unroll-and-jam -mllvm -enable-unroll-and-jam  -mllvm -allow-unroll-and-jam   -mllvm -unroll-and-jam-skip-dependency-checks -mllvm -allow-simple-unroll-and-jam -mllvm -enable-perfect-nest-unroll-and-jam  -mllvm -da-disable-delinearization-checks    -Rpass=unroll
CFLAGS=-DPOLYBENCH_PAPI -I/${PAPI_DIR}/include -L/${PAPI_DIR}/lib -lpapi -DLARGE_DATASET -DPOLYBENCH_USE_RESTRICT -DPOLYBENCH_USE_SCALAR_LB ${UNROLLJAM_OPTIONS}
