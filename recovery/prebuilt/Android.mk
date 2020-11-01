# Just needed, because the build system doesn't search recursively into every folder before SOONG
LOCAL_PATH:= $(call my-dir)
include $(call all-subdir-makefiles)
