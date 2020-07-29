ifneq ($(filter omni_akari omni_apollo, $(TARGET_PRODUCT)),)
TARGET_SCREEN_HEIGHT := 2160
TARGET_SCREEN_WIDTH := 1080
endif

ifneq ($(filter omni_akatsuki, $(TARGET_PRODUCT)),)
TARGET_SCREEN_HEIGHT := 2880
TARGET_SCREEN_WIDTH := 1440
endif

TARGET_BOOT_ANIMATION_RES := $(TARGET_SCREEN_WIDTH)

TARGET_RECOVERY_DEVICE_MODULES := tune2fs strace

# USB debugging at boot
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.recovery_update=true

-include vendor/omni/config/common.mk

# TWRP
WITH_TWRP := true
ALLOW_MISSING_DEPENDENCIES := true # Needed for the minimal omnirom twrp environment
$(call inherit-product, device/sony/customization/recovery/twrp.mk)
