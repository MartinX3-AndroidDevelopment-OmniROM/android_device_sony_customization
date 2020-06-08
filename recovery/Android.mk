LOCAL_PATH:= $(call my-dir)

# TWRP fstab
include $(CLEAR_VARS)
LOCAL_MODULE := twrp.fstab
LOCAL_SRC_FILES := prebuilt/etc/twrp.fstab
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/etc
include $(BUILD_PREBUILT)

# Common USB setup
include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.usb.rc
LOCAL_SRC_FILES := init.recovery.usb.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)

# TWRP specific & keymaster setup
include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.vold_decrypt.rc
LOCAL_SRC_FILES := init.recovery.vold_decrypt.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)

# prepdecrypt
include $(CLEAR_VARS)
LOCAL_MODULE := prepdecrypt.sh
LOCAL_SRC_FILES := prepdecrypt.sh
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_PREBUILT)

# static manifest for twrp
# includes only the hals required to get decryption to work
include $(CLEAR_VARS)
LOCAL_MODULE := manifest.xml
ifeq ($(TARGET_KEYMASTER_V4),true)
LOCAL_SRC_FILES := prebuilt/vendor/etc/vintf/manifest_km4.xml
else
LOCAL_SRC_FILES := prebuilt/vendor/etc/vintf/manifest_km3.xml
endif
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/vintf
include $(BUILD_PREBUILT)

### Add prebuilt sbin ###
### We want TWRP to be independent of the installed system ###

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libgptutils.so
LOCAL_SRC_FILES := prebuilt/sbin/libgptutils.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libicuuc.so
LOCAL_SRC_FILES := prebuilt/sbin/libicuuc.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libandroidicu.so
LOCAL_SRC_FILES := prebuilt/sbin/libandroidicu.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libicui18n.so
LOCAL_SRC_FILES := prebuilt/sbin/libicui18n.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_PREBUILT)
