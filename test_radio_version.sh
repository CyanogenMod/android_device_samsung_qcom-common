#!/sbin/sh

# Script to verify that the radio is at least newer than a specified minimum.
#
# Usage
#   arguments are in the form MODEL:MINVERSION (e.g. "I727:UCMC1 I727R:UXUMA7")
#   result 0: radio is equal to or newer than the minimum radio version
#   result 1: radio is older than the minimum radio version

# Variables
RADIO_PARTITION=/dev/block/mmcblk0p17
MOUNT_POINT=/tmp/radio_partition
FILE_CONTAINING_VERSION=image/DSP2.MBN
IMAGE_TO_CHECK=/tmp/radio_image_to_check

# Extract the firmware image
echo "Copying the radio to /tmp..."
mkdir $MOUNT_POINT
mount -r $RADIO_PARTITION $MOUNT_POINT
cp $MOUNT_POINT/$FILE_CONTAINING_VERSION $IMAGE_TO_CHECK
umount $MOUNT_POINT
rmdir $MOUNT_POINT

# Iterate through the possible model/minversion pairs
#   - grep out the firmware version based on the model
#   - compare to the specified minversion
echo "Searching radio image for version..."
for PAIR in "$@"; do
    MODEL=`echo $PAIR | cut -d : -f 1`
    MINVERSION=`echo $PAIR | cut -d : -f 2`
    RADIO_VERSION=`grep -E ^$MODEL[A-Z] -m 1 $IMAGE_TO_CHECK`
    if [ $? -eq 0 ];then
        echo "Found radio version: $RADIO_VERSION"
        if [ "$RADIO_VERSION" \< "$MODEL$MINVERSION" ];then
            echo "Radio must be newer than $MINVERSION"
            exit 1
        fi
        echo "Radio is new enough."
        exit 0
    fi
done

# Error out
echo "Could not determine the radio version."
exit 1

