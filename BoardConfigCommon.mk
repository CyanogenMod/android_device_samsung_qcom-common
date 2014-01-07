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

BOARD_VENDOR := samsung

# Bootloader
TARGET_NO_BOOTLOADER := true

# Architecture
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon

# PowerHAL
TARGET_USES_CM_POWERHAL := true

# chargers
BOARD_CHARGER_RES := device/samsung/qcom-common/charger

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# QCOM hardware
TARGET_QCOM_AUDIO_VARIANT := caf
TARGET_QCOM_DISPLAY_VARIANT := caf
BOARD_USES_LEGACY_ALSA_AUDIO := true

# Graphics
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true

# Charging mode
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging
BOARD_BATTERY_DEVICE_NAME := "battery"

TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/qcom-common

BOARD_HARDWARE_CLASS := hardware/samsung/cmhw

# Override healthd HAL
BOARD_HAL_STATIC_LIBRARIES := libhealthd.qcom

