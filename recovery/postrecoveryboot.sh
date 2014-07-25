#!/sbin/sh

# The partition to use is named "PARAM" and can be found by dumping the PIT.

# 0: charge
# 1: direct
# 2: recovery_enter
# 3: recovery_end
# 4: download_end

echo -n -e '\x03\x00\x00\x00' > /dev/block/platform/msm_sdcc.1/by-name/param
