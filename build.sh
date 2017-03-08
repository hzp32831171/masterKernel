#
# Custom build script 
#

yellow='\033[0;33m'
white='\033[0m'
red='\033[0;31m'
gre='\e[0;32m'
echo -e ""
echo -e "$gre=====================\n\n masterKernel \n\n=====================\n"
echo -e "$white"
Start=$(date +"%s")
KERNEL_DIR=$PWD
DTBTOOL=$KERNEL_DIR/dtbTool
cd $KERNEL_DIR
export ARCH=arm64
export CROSS_COMPILE="/home/dev/Desktop/aarch64-cortex_a72.a53-linux-gnueabi/bin/aarch64-cortex_a72.a53-linux-gnueabi-"
export LD_LIBRARY_PATH=home/dev/Desktop/aarch64-cortex_a72.a53-linux-gnueabi/lib/
STRIP="/home/dev/Desktop/Toolchain/aarch64-cortex_a72.a53-linux-gnueabi/bin/aarch64-cortex_a72.a53-linux-gnueabi-strip"
rm -rf $KERNEL_DIR/build
make clean
make masterKernel_defconfig
export KBUILD_BUILD_HOST="Ubuntu-Xenial"
export KBUILD_BUILD_USER="minz1"
make -j5
time=$(date +"%d-%m-%y-%T")
$DTBTOOL -2 -o $KERNEL_DIR/arch/arm64/boot/dt.img -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/
mkdir $KERNEL_DIR/build
mv $KERNEL_DIR/arch/arm64/boot/dt.img $KERNEL_DIR/build/dtb
cp $KERNEL_DIR/arch/arm64/boot/Image $KERNEL_DIR/build/zImage
