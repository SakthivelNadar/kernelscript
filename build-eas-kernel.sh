##################
#  PowerKernel   #
##################

# Set defaults
wd=$(pwd)
out=$wd/out
BUILD="/home/builder2/kernelsp/PowerKernel_lavender"
# Set kernel source workspace
cd $BUILD
# Export ARCH <arm, arm64, x86, x86_64>
export ARCH=arm64
# Export SUBARCH <arm, arm64, x86, x86_64>
export SUBARCH=arm64
# Set kernal name
# export LOCALVERSION=-
# Export Username
export KBUILD_BUILD_USER=SparXFusion
# Export Machine name
export KBUILD_BUILD_HOST=InfusionX
# Compiler String
CC=/home/builder2/kernelsp/aosp-clang/bin/clang
export KBUILD_COMPILER_STRING="$(${CC} --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')"
# Make and Clean
make O=$out clean
make O=$out mrproper
# Make <defconfig>
make O=$out ARCH=arm64 lavender-perf_defconfig
# Build Kernel
make O=$out ARCH=arm64 \
CC="/home/builder2/kernelsp/aosp-clang/bin/clang" \
CROSS_COMPILE="/home/builder2/kernelsp/aarch64-maestro-linux-android/bin/aarch64-maestro-linux-gnu-" \
CROSS_COMPILE_ARM32="/home/builder2/kernelsp/arm-maestro-linux-gnueabi/bin/arm-maestro-linux-gnueabi-" \
-j$(nproc --all) Image.gz-dtb
