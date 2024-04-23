# project/BUILD.bazel

load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

platform(
    name = "aarch64_none_linux_gnu",
    constraint_values = [
        "@platforms//cpu:aarch64",
        "@platforms//os:linux",
    ],
)

cc_library(
    name = "arm_library",
    srcs = ["library.cpp"],
    hdrs = ["library.h"],
    copts = [
        "-mcpu=cortex-a53",
    ],
    includes = ["includes"],
    target_compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:linux",
    ],
)

cc_binary(
    name = "arm_elf",
    srcs = ["main.cpp"],
    copts = [
        "-mcpu=cortex-a53",
    ],
    linkopts = [
        "-nostartfiles",
        "-Wl,--entry,main",
    ],
    deps = [":arm_library"],
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":arm_elf"],
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],  # linux x86 (no arm)
        "@platforms//os:windows": ["@platforms//cpu:x86_64"],  # windows
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    target_platform = ":aarch64_none_linux_gnu",
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["mock.hex"],
    cmd = "$(execpath @aarch64_none_linux_gnu//:objcopy) -O ihex $< $@",
    tools = ["@aarch64_none_linux_gnu//:objcopy"],
    visibility = ["//visibility:public"],
)
