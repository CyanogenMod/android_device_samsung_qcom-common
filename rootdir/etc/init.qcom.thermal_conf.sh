#!/system/bin/sh
# Copyright (c) 2012, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

THERMALD_CONF_SYMLINK=/etc/thermald.conf
THERMAL_ENGINE_CONF_SYMLINK=/etc/thermal-engine.conf
THERMAL_PLATFORM="8960"

# Set a default value
setprop qcom.thermal thermald

platformid=`cat /sys/devices/system/soc/soc0/id`
case "$platformid" in
    "109" | "130") THERMAL_PLATFORM="8064";;                   #APQ/MPQ8064
    "153")                                                     #APQ/MPQ8064ab
      # use thermal-engine for 8064ab
      setprop qcom.thermal thermal-engine;
      THERMAL_PLATFORM="8064ab";;
    "116" | "117" | "118" | "119") THERMAL_PLATFORM="8930";;   #MSM8930
    "138" | "139" | "140" | "141") THERMAL_PLATFORM="8960ab";; #MSM8960ab
esac

# Check if symlink does not exist
if [ ! -h $THERMALD_CONF_SYMLINK ]; then
 # create symlink to target-specific config file
 ln -s /etc/thermald-$THERMAL_PLATFORM.conf $THERMALD_CONF_SYMLINK 2>/dev/null
fi

# Check if symlink does not exist
if [ ! -h $THERMAL_ENGINE_CONF_SYMLINK ]; then
 # create symlink to target-specific config file
 ln -s /etc/thermal-engine-$THERMAL_PLATFORM.conf $THERMAL_ENGINE_CONF_SYMLINK 2>/dev/null
fi
