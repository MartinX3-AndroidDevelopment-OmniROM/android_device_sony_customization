# Kernel inline building
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_SOURCE := kernel/sony/msm-4.14/kernel
# TODO: Can this get removed?
#TARGET_NEEDS_DTBOIMAGE := false # Set by device tree
TARGET_PROVIDES_DTBOIMAGE := false

# TWRP
$(call inherit-product, device/sony/customization/recovery/Twrp.mk)
