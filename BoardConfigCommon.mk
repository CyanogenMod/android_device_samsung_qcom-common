# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# inherit from qcom-common
-include device/qcom/qcom-common/BoardConfigCommon.mk

BOARD_VENDOR := samsung

# chargers
BOARD_CHARGER_RES := device/samsung/qcom-common/charger

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# FM Radio
#BOARD_HAVE_FM_RADIO := true
#BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO

# Charging mode
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging
BOARD_BATTERY_DEVICE_NAME := "battery"

TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/qcom-common

BOARD_HARDWARE_CLASS := hardware/samsung/cmhw
