#!/system/bin/sh
# Copyright (c) 2012, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target="$1"
serial="$2"

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

## [BEGIN] system_sw.sa: check the existence of necessary symbolic links in /system/etc/firmware
linksCreated=1
cd /firmware/image
testfiles=`ls modem* adsp* wcnss* mba* tima* lkmauth* venus* widevine* playread* dtcpip* skm* keymaste* sshdcpap* sec_stor* mc_v2*`

cd /system/etc/firmware
# Note: You can add requisite link names to extrafiles variable.
extrafiles='wcd9320/wcd9320_mbhc.bin ../thermald.conf ../thermal-engine.conf'
testfiles=$testfiles' '$extrafiles

for testfile in $testfiles; do
   case `ls $testfile` in
      $testfile)
         #echo "  file: $testfile" > /dev/kmsg
         continue;;
      *)
         echo "init: /init.qcom.syspart_fixup.sh: continuing because '${testfile}' doesn't exist." > /dev/kmsg
         linksCreated=0
         break;;
   esac
done

if [ "$linksCreated" = "1" ]; then
	#touch /system/etc/boot_fixup
	echo "init: /init.qcom.syspart_fixup.sh: skipping because symbolic links are alreay created." > /dev/kmsg
	exit 0
fi
## [END] system_sw.sa

# This should be the first command
# remount system as read-write.
mount -o rw,remount,barrier=1 /system

# **** WARNING *****
# This runs in a single-threaded, critical path portion
# of the Android bootup sequence.  This is to guarantee
# all necessary system partition fixups are done before
# the rest of the system starts up.  Run any non-
# timing critical tasks in a separate process to
# prevent slowdown at boot.

# Run modem link script
if [ -f /system/etc/init.qcom.modem_links.sh ]; then
  /system/bin/sh /system/etc/init.qcom.modem_links.sh
fi

# Run mdm link script
if [ -f /system/etc/init.qcom.mdm_links.sh ]; then
  /system/bin/sh /system/etc/init.qcom.mdm_links.sh
fi

# Run thermal script
if [ -f /system/etc/init.qcom.thermal_conf.sh ]; then
  /system/bin/sh /system/etc/init.qcom.thermal_conf.sh
fi

## [BEGIN] system_sw.sa: Ignore wifi script.
## Run wifi script
#if [ -f /system/etc/init.qcom.wifi.sh ]; then
#  /system/bin/sh /system/etc/init.qcom.wifi.sh "$target" "$serial"
#fi
## [END] system_sw.sa

## [BEGIN] system_sw.sa: Settings from init.qcom.audio.sh
rm -rf /system/etc/firmware/wcd9320/wcd9320_mbhc.bin
mkdir -p /system/etc/firmware/wcd9320
chmod 755 /system/etc/firmware/wcd9320
ln -s /data/misc/audio/mbhc.bin /system/etc/firmware/wcd9320/wcd9320_mbhc.bin
## [END] system_sw.sa

# Run the sensor script
if [ -f /system/etc/init.qcom.sensor.sh ]; then
  /system/bin/sh /system/etc/init.qcom.sensor.sh
fi

## [BEGIN] system_sw.sa: Ignore usf script.
## Run usf script
#if [ -f /system/etc/usf_settings.sh ]; then
#  /system/bin/sh /system/etc/usf_settings.sh
#fi
## [END] system_sw.sa

touch /system/etc/boot_fixup
chmod 664 /system/etc/boot_fixup

# This should be the last command
# remount system as read-only.
mount -o ro,remount,barrier=1 /system
