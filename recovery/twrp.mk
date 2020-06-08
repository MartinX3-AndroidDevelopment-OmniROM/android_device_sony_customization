#
# This is for TWRP Recovery
#

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
# TODO Reenable with TWRP 10.0
# A 9.0 RAMDISK won't work in a 10.0 ROM.
# The result is an unbootable system and a always into recovery booting phone.
#TW_INCLUDE_REPACKTOOLS := true
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
# This will override the values from the buildimage with the correct ones from system/build.prop (SAR/Treble)
# Needed for the userdata decryption ny the keymaster.
TW_OVERRIDE_SYSTEM_PROPS := "ro.build.version.release;ro.build.version.security_patch"
# Additional ovverides needed to make the decryption working in TWRP
# These values need to match the security patch level of the rom.
# If they repesent the past /earlier android or the future/newer android,
# then the keymaster won't decrypt the userdata.
# Since these values are part of the bootimage header and directly consumed by the bootloader,
# They can't get changed dynamically for an always working TWRP.
# So the TWRP needs a new release each month or AvB 2.0 will refuse the TWRP to boot.
# A workaround would be a disabled decryption.
PLATFORM_VERSION := 10.0.0
ifneq ($(PLATFORM_SECURITY_PATCH_OVERRIDE), )
	PLATFORM_SECURITY_PATCH_OVERRIDE := $(PLATFORM_SECURITY_PATCH_OVERRIDE)
endif

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
