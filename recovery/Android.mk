# Save LOCAL_PATH of the current Android.mk file
SAVED_LOCAL_PATH := $(call my-dir)
# Include/Call all Android.mk recursively
include $(call all-subdir-makefiles)
# Restore LOCAL_PATH variable
LOCAL_PATH:= $(SAVED_LOCAL_PATH)

# Common USB setup
include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.usb.rc
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)

# Decryption setup
include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.vold_decrypt.rc
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)
