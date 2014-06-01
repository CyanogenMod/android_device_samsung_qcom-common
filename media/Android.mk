ifeq ($(call is-board-platform-in-list,msm8960 msm8660),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

include $(CLEAR_VARS)
LOCAL_MODULE := media_codecs.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/
LOCAL_SRC_FILES := media_codecs.xml
include $(BUILD_PREBUILT)

else

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := media_codecs.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/
LOCAL_SRC_FILES := media_codecs_8974.xml
include $(BUILD_PREBUILT)

endif