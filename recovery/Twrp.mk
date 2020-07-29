#
# This is for TWRP Recovery inherited from the uppercase Customization.mk
#

# Bundle the recovery image with the DTBO partition.
# See https://source.android.com/devices/bootloader/recovery-image
BOARD_BOOTIMG_HEADER_VERSION := 2
# TODO: The 9.0 device trees overwrite the BOARD_MKBOOTIMG_ARGS
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOTIMG_HEADER_VERSION) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
#BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
