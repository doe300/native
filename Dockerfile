FROM debian:buster

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
   git curl cmake bc automake libtool build-essential pkg-config make debian-archive-keyring \
   ca-certificates devscripts python unzip libllvm7 llvm-7-dev opencl-c-headers \
   g++-8 clang-7 ocl-icd-opencl-dev ocl-icd-dev clang-format-7 diffutils spirv-tools \
   wget \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Build and install Khronos LLVM-SPIRV-Translator
RUN git clone https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git /opt/SPIRV-LLVM-Translator \
 && cd /opt/SPIRV-LLVM-Translator/ && mkdir build && cd build && git checkout v7.0.1-1 \
 && cmake .. && make llvm-spirv -j`nproc` \
 && rm -rf ../.git/
