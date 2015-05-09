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
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true

# CMHW
BOARD_HARDWARE_CLASS += hardware/samsung/cmhw

# Graphics
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true

# Healthd
BOARD_HAL_STATIC_LIBRARIES := libhealthd.qcom

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += device/samsung/qcom-common
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_HAS_DOWNLOAD_MODE := true
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
