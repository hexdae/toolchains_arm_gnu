# project/BUILD.bazel

load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

config_setting(
    name = "macos",  # no compiler on macos (yet)
    constraint_values = ["@platforms//os:macos"],
)

platform(
    name = "arm_linux_gnueabihf",
    constraint_values = [
        "@platforms//cpu:arm",
        "@platforms//os:linux",
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
   )

cc_library(
    name = "atomics",
    srcs = ["atomics.c"],
    copts = ["-std=c11"],
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "arm_elf",
    srcs = ["main.cpp"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    deps = [":arm_library"],
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":arm_elf"],
    target_compatible_with = select({
        ":macos": ["@platforms//:incompatible"],
        "//conditions:default": [],
    }),
    target_platform = ":arm_linux_gnueabihf",
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["mock.hex"],
    cmd = "$(execpath @arm_none_linux_gnueabihf//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_linux_gnueabihf//:objcopy"],
    visibility = ["//visibility:public"],
)
