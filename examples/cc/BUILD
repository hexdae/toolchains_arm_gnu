# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")

cc_library(
    name = "arm_library",
    srcs = ["source/library.cpp"],
    hdrs = ["includes/library.h"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    includes = ["includes"],
    target_compatible_with = [
        "@platforms//cpu:arm",
        "@platforms//os:none",
    ],
)

cc_binary(
    name = "arm_elf",
    srcs = ["source/main.cpp"],
    deps = [":arm_library"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    linkopts = [
        "-nostartfiles",
        "-Wl,--entry,main",
    ],
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":arm_elf"],
    target_platform = "//platforms:arm_none_eabi",
)

genrule(
    name = "bin",
    srcs = [":elf"],
    outs = ["mock.bin"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O binary $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["mock.hex"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
)
