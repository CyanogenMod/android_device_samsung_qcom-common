#!/sbin/sh

# The partition to use is named "PARAM" and can be found by dumping the PIT.

# 0: charge
# 1: direct
# 2: recovery_enter
# 3: recovery_end
# 4: download_end

target=`getprop ro.board.platform`

case "$target" in
    "msm8660")
        # hack because 8660 doesn't support partitions by-name
        echo -n -e '\x03\x00\x00\x00' > /dev/block/mmcblk0p12
        ;;
    "msm8916")
        echo -n -e '\x03\x00\x00\x00' > /dev/block/bootdevice/by-name/param
        ;;
    *)
        echo -n -e '\x03\x00\x00\x00' > /dev/block/platform/msm_sdcc.1/by-name/param
        ;;
esac
