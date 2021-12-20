#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from mainline-common
include device/linux/mainline-common/BoardConfigCommon.mk

DEVICE_PATH := device/msft/vela

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a7

TARGET_USES_64_BIT_BINDER := true

# Display
TARGET_SCREEN_DENSITY := 240

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := video=efifb
BOARD_KERNEL_CMDLINE += clk_ignore_unused pd_ignore_unused
BOARD_KERNEL_CMDLINE += fbcon=map:2
BOARD_KERNEL_CMDLINE += androidboot.hardware=mainline
BOARD_KERNEL_CMDLINE += loop.max_part=7
# eMMC
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/f9824900.sdhci
# SDCard
#BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/f98a4900.sdhci
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_KERNEL_SOURCE := kernel/msft/vela
TARGET_KERNEL_CONFIG := gki_defconfig vendor/msft/vela_gki.config

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_CACHEIMAGE_PARTITION_SIZE := 314572800
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5209325568

SSI_PARTITIONS := system
TREBLE_PARTITIONS := vendor
ALL_PARTITIONS := $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Partitions - legacy
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1363148800
BOARD_VENDORIMAGE_PARTITION_SIZE := 734003200

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mainline
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
