# project/BUILD.bazel

load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

platform(
    name = "arm_none_eabi",
    constraint_values = [
        "@platforms//cpu:arm",
        "@platforms//os:none",
    ],
)

cc_library(
    name = "arm_library",
    srcs = ["library.cpp"],
    hdrs = ["library.h"],
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
    srcs = ["main.cpp"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    linkopts = [
        "-nostartfiles",
        "-Wl,--entry,main",
    ],
    features = ["generate_linkmap"],
    deps = [":arm_library"],
)

filegroup(
    name = "arm_elf.map",
    srcs = [":arm_elf"],
    output_group = "linkmap",
)

platform_transition_filegroup(
    name = "linkmap",
    srcs = [":arm_elf.map"],
    target_platform = ":arm_none_eabi",
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":arm_elf"],
    target_platform = ":arm_none_eabi",
)

genrule(
    name = "map",
    srcs = [":linkmap"],
    outs = ["arm_elf.linkmap"],
    cmd = "cp $< $@",
    executable = True,
    visibility = ["//visibility:public"],
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["mock.hex"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
    visibility = ["//visibility:public"],
)
