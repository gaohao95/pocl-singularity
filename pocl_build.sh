mkdir build
cd build

PREFIX=/home/gaohao95/singularity/miniconda
EXTRA_HOST_CLANG_FLAGS=""

LINKER_FLAG=""
OPENCL_LIBRARIES="${PREFIX}/lib/libOpenCL.so"

cmake \
  -D CMAKE_BUILD_TYPE="Release" \
  -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
  -D CMAKE_PREFIX_PATH="${PREFIX}" \
  -D POCL_INSTALL_ICD_VENDORDIR="${PREFIX}/etc/OpenCL/vendors" \
  -D LLVM_CONFIG="/usr/lib/llvm-8/bin/llvm-config" \
  -D INSTALL_OPENCL_HEADERS="off" \
  -D KERNELLIB_HOST_CPU_VARIANTS=distro \
  -D OPENCL_LIBRARIES="${OPENCL_LIBRARIES}" \
  $LINKER_FLAG \
  -D EXTRA_HOST_LD_FLAGS="${EXTRA_HOST_LD_FLAGS}" \
  -D EXTRA_HOST_CLANG_FLAGS="${EXTRA_HOST_CLANG_FLAGS}" \
  -D CMAKE_INSTALL_LIBDIR=lib \
  -D ENABLE_ICD=on \
  ..

make -j 8
# install needs to come first for the pocl.icd to be found
make install
make check

