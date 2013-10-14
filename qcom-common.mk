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


# Media config
PRODUCT_COPY_FILES += \
    device/samsung/qcom-common/media/media_codecs.xml:system/etc/media_codecs.xml

# QCOM Display
PRODUCT_PACKAGES += \
    libgenlock \
    libmemalloc \
    liboverlay \
    libqdutils \
    libtilerenderer \
    libI420colorconvert

PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.hw=1 \
    debug.egl.hw=1 \
    persist.hwc.mdpcomp.enable=true \
    debug.mdpcomp.logs=0 \
    ro.telephony.ril_class=SamsungQualcommRIL \
    ro.telephony.call_ring.multiple=0

# TODO: Move here
#PRODUCT_PACKAGES += \
#     GalaxyS3Settings \
#     SamsungServiceMode

# Omx
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt \
    libmm-omxcore \
    libOmxCore \
    libstagefrighthw \
    libOmxVdec \
    libOmxVenc \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libdashplayer

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    e2fsck \
    setup_fs

# Thermal profiles
ifeq ($(TARGET_BOARD_PLATFORM),msm8960)
PRODUCT_PACKAGES += \
    thermald-8064ab.conf \
    thermald-8064.conf \
    thermald-8930.conf \
    thermald-8930ab.conf \
    thermald-8960.conf \
    thermald-8960ab.conf \
    thermal-engine-8064ab.conf
endif

# Init scripts
PRODUCT_PACKAGES += \
    init.qcom.post_boot.sh \
    init.qcom.efs.sync.sh \
    init.qcom.sh \
    init.qcom.class_core.sh \
    init.qcom.class_main.sh \
    init.qcom.syspart_fixup.sh \
    init.qcom.early_boot.sh \
    init.qcom.mdm_links.sh \
    init.qcom.modem_links.sh \
    init.qcom.usb.sh \
    lpm.rc \
    init.qcom.lpm_boot.sh \
    init.qcom.thermal_conf.sh \
    init.recovery.qcom.rc \
    init.qcom.ril.sh

# Charger
PRODUCT_PACKAGES += charger charger_res_images

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Common overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/qcom-common/overlay
