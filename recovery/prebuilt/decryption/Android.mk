LOCAL_PATH := $(call my-dir)

# TWRP fstab
include $(CLEAR_VARS)
LOCAL_MODULE := twrp.fstab
LOCAL_SRC_FILES := etc/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/etc
include $(BUILD_PREBUILT)

# static manifest for twrp
# includes only the hals required to get decryption to work
include $(CLEAR_VARS)
LOCAL_MODULE := manifest.xml
ifeq ($(TARGET_KEYMASTER_V4),true)
LOCAL_SRC_FILES := vendor/etc/vintf/manifest_km4.xml
else
LOCAL_SRC_FILES := vendor/etc/vintf/manifest_km3.xml
endif
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/vintf
include $(BUILD_PREBUILT)

### Add prebuilt sbin ###
### We want TWRP to be independent of the installed system ###

include $(CLEAR_VARS)
LOCAL_MODULE := qseecomd
LOCAL_SRC_FILES := vendor/bin/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/bin
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.gatekeeper@1.0-service
LOCAL_SRC_FILES := vendor/bin/hw/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/hw
include $(BUILD_PREBUILT)

# Needed by android.hardware.gatekeeper@1.0-service
# need to copy hw modules to /vendor/lib64/hw
# hw_get_module() does not look for them under /sbin
include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.gatekeeper@1.0-impl-qti.so
LOCAL_SRC_FILES := vendor/lib64/hw/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/hw
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libgptutils.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libicuuc.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libandroidicu.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libicui18n.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libQSEEComAPI.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libdrmfs.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libdiag.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := librpmb.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libssd.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libdrmtime.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libtime_genoff.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by android.hardware.gatekeeper@1.0-impl-qti.so & android.hardware.keymaster@4.0-service-qti
include $(CLEAR_VARS)
LOCAL_MODULE := libkeymasterdeviceutils.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by android.hardware.gatekeeper@1.0-impl-qti.so & android.hardware.keymaster@4.0-service-qti
include $(CLEAR_VARS)
LOCAL_MODULE := libspcom.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libion.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libxml2.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libsecureui.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libqisl.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libspl.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libGPreqcancel.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by qseecomd
include $(CLEAR_VARS)
LOCAL_MODULE := libops.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by android.hardware.gatekeeper@1.0-service
# need to copy hw modules to /vendor/lib64/hw
# hw_get_module() does not look for them under /sbin
# Fixed "E:Error getting bootctrl module" on switching A/B slots.
include $(CLEAR_VARS)
LOCAL_MODULE := bootctrl.sdm845.so
LOCAL_SRC_FILES := vendor/lib64/hw/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/hw
include $(BUILD_PREBUILT)

ifneq ($(TARGET_KEYMASTER_V4),true)
include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.keymaster@3.0-service
LOCAL_SRC_FILES := vendor/bin/hw/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/hw
include $(BUILD_PREBUILT)

# Needed by android.hardware.gatekeeper@1.0-service
# need to copy hw modules to /vendor/lib64/hw
# hw_get_module() does not look for them under /sbin
# Copy the 3.0 implementation only if the device declares support for it.
# Keymaster device enumeration would otherwise load both 3.0 and 4.0, with 3.0 crashing due to incompatible libs.
include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.keymaster@3.0-impl-qti.so
LOCAL_SRC_FILES := vendor/lib64/hw/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/hw
include $(BUILD_PREBUILT)
endif

ifeq ($(TARGET_KEYMASTER_V4),true)
include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.keymaster@4.0-service-qti
LOCAL_SRC_FILES := vendor/bin/hw/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/hw
include $(BUILD_PREBUILT)

# Needed by android.hardware.keymaster@4.0-service-qti
include $(CLEAR_VARS)
LOCAL_MODULE := libqtikeymaster4.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)

# Needed by android.hardware.keymaster@4.0-service-qti
include $(CLEAR_VARS)
LOCAL_MODULE := libkeymasterutils.so
LOCAL_SRC_FILES := vendor/lib64/$(LOCAL_MODULE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64
include $(BUILD_PREBUILT)
endif
