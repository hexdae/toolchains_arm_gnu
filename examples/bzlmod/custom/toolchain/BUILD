load("@arm_none_eabi//toolchain:toolchain.bzl", "arm_none_eabi_toolchain")
load("@rules_cc//cc:defs.bzl", "cc_library")

# Cortex-M3 toolchain
arm_none_eabi_toolchain(
    name = "cortex_m3_toolchain",
    copts = [
        "-mcpu=cortex-m3",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
    ],
    linkopts = [
        "-mcpu=cortex-m3",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-nostartfiles",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "//custom/cpu:cortex_m3",
    ],
)

# Cortex-M4 toolchain, compiled using g++ instead of gcc
arm_none_eabi_toolchain(
    name = "cortex_m4_toolchain",
    copts = [
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
    ],
    gcc_tool = "g++",
    linkopts = [
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-nostartfiles",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "//custom/cpu:cortex_m4",
    ],
)

# always linked in with the toolchain below
cc_library(
    name = "start",
    srcs = ["start.c"],
    additional_linker_inputs = ["link.ld"],
    linkopts = ["-T $(location :link.ld)"],
)

# Cortex-M4 toolchain that always links `:start`
arm_none_eabi_toolchain(
    name = "cortex_m4_toolchain_with_start",
    copts = [
        "-Wall",
        "-Wextra",
        "-Werror",
        "-Wpedantic",
        "-ffreestanding",
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
    ],
    linkopts = [
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-nostartfiles",
    ],
    additional_link_libraries = [
        ":start",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "//custom/cpu:cortex_m4",
    ],
    visibility = ["//visibility:public"],
)
