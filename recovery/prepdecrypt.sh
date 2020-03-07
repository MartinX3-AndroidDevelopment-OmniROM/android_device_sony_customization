#!/sbin/sh

SCRIPTNAME="PrepDecrypt"
LOGFILE=/tmp/recovery.log

log_info()
{
	echo "I:$SCRIPTNAME:$1" >> "$LOGFILE"
}

log_error()
{
	echo "E:$SCRIPTNAME:$1" >> "$LOGFILE"
}

relink()
{
	if [ -f "$1" ]; then
		fname=$(basename "$1")
		target="/sbin/$fname"
		sed 's|/system/bin/linker64|///////sbin/linker64|' "$1" > "$target"
		chmod 755 $target
	fi
}

mountPartitions()
{
	#Suffix for A/B devices is either _a or _b depending on which slot is active
	suffix=$(getprop ro.boot.slot_suffix)

	oempath="/dev/block/bootdevice/by-name/oem_a"
	systempath="/dev/block/bootdevice/by-name/system$suffix"
	vendorpath="/dev/block/bootdevice/by-name/vendor$suffix"
	# On stock everything is in the vendor partition
	if [ true = "$is_stock" ]; then
		oempath=$vendorpath
	fi
	mkdir /prepOEM
	mkdir /prepSYSTEM
	mkdir /prepVENDOR
	mount -t ext4 -o ro "$oempath" /prepOEM
	mount -t ext4 -o ro "$systempath" /prepSYSTEM
	mount -t ext4 -o ro "$vendorpath" /prepVENDOR
}

finish()
{
	umount /prepOEM
	umount /prepSYSTEM
	umount /prepVENDOR
	rmdir /prepOEM
	rmdir /prepSYSTEM
	rmdir /prepVENDOR
	setprop crypto.ready 1
	log_info "Finished $SCRIPTNAME"
	exit 0
}

log_info "Started $SCRIPTNAME"

# Determine the needed keymaster version. It's either v3 or v4 on tama
keymaster_version=$(getprop ro.vendor.keymaster.version)

# Determine if it is the stock or the sodp based TWRP/ROM
if [[ -f /sbin/preptouch.sh ]]; then
	is_stock=true
else
	is_stock=false
fi

mountPartitions

# dependencies from odm
cp /prepOEM/lib64/libQSEEComAPI.so /sbin/ # Needed by qseecomd
cp /prepOEM/lib64/libdrmfs.so /sbin/ # Needed by qseecomd
cp /prepOEM/lib64/libdiag.so /sbin/ # Needed by qseecomd
cp /prepOEM/lib64/librpmb.so /sbin/ # Needed by qseecomd
cp /prepOEM/lib64/libssd.so /sbin/ # Needed by qseecomd
cp /prepOEM/lib64/libdrmtime.so /sbin/ # Needed by qseecomd
cp /prepOEM/lib64/libtime_genoff.so /sbin/ # Needed by qseecomd
cp /prepOEM/lib64/libkeymasterdeviceutils.so /sbin/ # Needed by android.hardware.gatekeeper@1.0-impl-qti.so & android.hardware.keymaster@4.0-service-qti
cp /prepOEM/lib64/libspcom.so /sbin/ # Needed by android.hardware.gatekeeper@1.0-impl-qti.so & android.hardware.keymaster@4.0-service-qti
if [ "v4" = "$keymaster_version" ]; then
	cp /prepOEM/lib64/libqtikeymaster4.so /sbin/ # Needed by android.hardware.keymaster@4.0-service-qti
	cp /prepOEM/lib64/libkeymasterutils.so /sbin/ # Needed by android.hardware.keymaster@4.0-service-qti
fi

# dependencies from vendor

# dependencies from system
cp /prepSYSTEM/system/lib64/libion.so /sbin/ # Needed by qseecomd
cp /prepSYSTEM/system/lib64/libxml2.so /sbin/ # Needed by qseecomd

# need to copy hw modules to /vendor/lib64/hw
# hw_get_module() does not look for them under /sbin
mkdir -p /vendor/lib64/hw
cp /prepOEM/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so /vendor/lib64/hw/ # Needed by android.hardware.gatekeeper@1.0-service
# Only copy 3.0 implementation when device declares support for it.
# Keymaster device enumeration would otherwise load both 3.0 and 4.0, with 3.0 crashing due to incompatible libs.
if [ "v3" = "$keymaster_version" ]; then
	cp /prepOEM/lib64/hw/android.hardware.keymaster@3.0-impl-qti.so /vendor/lib64/hw/ # Needed by android.hardware.keymaster@3.0-service
fi
cp /prepVENDOR/lib64/hw/bootctrl.sdm845.so /vendor/lib64/hw/ # Fixed "E:Error getting bootctrl module" on switching A/B slots.

#Relinking happens at last, because it needs already existing libraries.
relink /prepOEM/bin/qseecomd
if [ true = "$is_stock" ]; then
	cp /prepVENDOR/lib64/librecovery_updater_msm.so /sbin/ # Fixed "E:Error getting bootctrl module" on switching A/B slots in stock TWRP.
	relink /prepVENDOR/bin/hw/android.hardware.gatekeeper@1.0-service-qti
	if [ "v3" = "$keymaster_version" ]; then
		relink /prepVENDOR/bin/hw/android.hardware.keymaster@3.0-service-qti
	fi
else
	relink /prepVENDOR/bin/hw/android.hardware.gatekeeper@1.0-service
	if [ "v3" = "$keymaster_version" ]; then
		relink /prepVENDOR/bin/hw/android.hardware.keymaster@3.0-service
	fi
fi
if [ "v4" = "$keymaster_version" ]; then
	relink /prepOEM/bin/hw/android.hardware.keymaster@4.0-service-qti
fi

finish
