#
# This is for TWRP Recovery
#

# The device subversion of TWRP
# Example:
# TWRP 3.4.0 + TW_DEVICE_VERSION := 99 = 3.4.0-99
TW_DEVICE_VERSION := 0

# user interface
TW_THEME := portrait_hdpi
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 255
TW_NEW_ION_HEAP := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"

# timekeep
TARGET_RECOVERY_QCOM_RTC_FIX := true

# init
TW_EXCLUDE_DEFAULT_USB_INIT := true

# features
TW_USE_TOOLBOX := true
TW_EXCLUDE_SUPERSU := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_REPACKTOOLS := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true

# storage
RECOVERY_SDCARD_ON_DATA := true
TW_INCLUDE_FUSE_EXFAT := true
TW_FLASH_FROM_STORAGE := true
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TARGET_NO_SEPARATE_RECOVERY := true

# crypto
TW_INCLUDE_FBE := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/bootdevice/by-name/userdata"
TW_CRYPTO_FS_OPTIONS := "nosuid,nodev,barrier=1,noauto_da_alloc,discard"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "footer"
# Empty TW_CRYPTO_USE_SYSTEM_VOLD, so we can use our own "init.recovery.vold_decrypt.rc"
# without modifying the "rootdir/init.recovery.common.rc" in "device-sony-common" repo
# with "import /init.recovery.twrp.rc" at its beginning
TW_CRYPTO_USE_SYSTEM_VOLD :=
# This will override the values from the buildimage with the correct ones from system/build.prop (SAR/Treble).
# It is needed for the userdata decryption by the keymaster in a persistent installed TWRP.
# ro.vendor.build.version.release is needed for keymaster 4.0
# ro.vendor.build.security_patch is needed for keymaster 4.0
TW_OVERRIDE_SYSTEM_PROPS := "ro.build.version.release;ro.build.version.security_patch;ro.vendor.build.version.release=ro.build.version.release;ro.vendor.build.security_patch=ro.build.version.security_patch"
# These overrides are needed to make the decryption working in TWRP.
# They are part of the bootimage header and directly consumed by the bootloader.
# After that they're used by the keymaster.
PLATFORM_VERSION := 10
PLATFORM_SECURITY_PATCH_OVERRIDE := 2020-05-01
# Needed for keymaster 4.0
PRODUCT_PROPERTY_OVERRIDES += \
		ro.vendor.build.version.release=10 \
    ro.vendor.build.security_patch=2020-05-01

# init
TARGET_RECOVERY_DEVICE_MODULES += \
    init.recovery.vold_decrypt.rc \
    init.recovery.usb.rc \
		twrp.fstab \
    manifest.xml \
		qseecomd \
		android.hardware.gatekeeper@1.0-service \
		android.hardware.gatekeeper@1.0-impl-qti.so \
		libgptutils.so \
		libicuuc.so \
		libandroidicu.so \
		libicui18n.so \
		libQSEEComAPI.so \
		libdrmfs.so \
		libdiag.so \
		librpmb.so \
		libssd.so \
		libdrmtime.so \
		libtime_genoff.so \
    libkeymasterdeviceutils.so \
		libspcom.so \
		libion.so \
		libxml2.so \
		libsecureui.so \
		libqisl.so \
		libspl.so \
		libGPreqcancel.so \
		libops.so \
		bootctrl.sdm845.so
TW_RECOVERY_ADDITIONAL_RELINK_FILES += \
		$(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/qseecomd \
		$(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/hw/android.hardware.gatekeeper@1.0-service

ifneq ($(TARGET_KEYMASTER_V4),true)
TARGET_RECOVERY_DEVICE_MODULES += \
		android.hardware.keymaster@3.0-service \
		android.hardware.keymaster@3.0-impl-qti.so
TW_RECOVERY_ADDITIONAL_RELINK_FILES += \
		$(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/hw/android.hardware.keymaster@3.0-service
endif

ifeq ($(TARGET_KEYMASTER_V4),true)
TARGET_RECOVERY_DEVICE_MODULES += \
		android.hardware.keymaster@4.0-service-qti \
		libqtikeymaster4.so \
		libkeymasterutils.so
TW_RECOVERY_ADDITIONAL_RELINK_FILES += \
		$(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/hw/android.hardware.keymaster@4.0-service-qti
endif

# The stock kernel modules to enable touch support
ifeq ($(TARGET_STOCK),true)
TARGET_RECOVERY_DEVICE_MODULES += \
		preptouch.sh

#XZ2 XZ2C Clearpad & TCM
ifneq ($(filter omni_akari omni_apollo, $(TARGET_PRODUCT)),)
TARGET_RECOVERY_DEVICE_MODULES += \
		clearpad_rmi_dev.ko \
		clearpad_core.ko \
		clearpad_i2c.ko \
		synaptics_tcm_i2c.ko \
		synaptics_tcm_core.ko \
		synaptics_tcm_touch.ko \
		synaptics_tcm_device.ko \
		synaptics_tcm_testing.ko \
		synaptics_tcm_reflash.ko \
		synaptics_tcm_recovery.ko \
		synaptics_tcm_diagnostics.ko
endif

#XZ2P SSW
ifneq ($(filter omni_akari, $(TARGET_PRODUCT)),) # Because the Aurora is build as akari (no customROM support)
TARGET_RECOVERY_DEVICE_MODULES += \
		ssw49501.ko \
		ssw_mon.ko
endif

#XZ3 ATMEL
ifneq ($(filter omni_akatsuki, $(TARGET_PRODUCT)),)
TARGET_RECOVERY_DEVICE_MODULES += \
		atmel_mxt640u.ko
endif
endif
