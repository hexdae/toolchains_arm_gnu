# project/BUILD.bazel

load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "startup",
    srcs = ["start.S"],
    linkopts = ["-T $(location :link.ld)"],
    target_compatible_with = ["@platforms//os:none"],
    deps = ["link.ld"],
    alwayslink = True,
)

cc_library(
    name = "gpio",
    hdrs = ["gpio.h"],
    alwayslink = True,
)

cc_library(
    name = "uart",
    srcs = ["uart.c"],
    hdrs = ["uart.h"],
    deps = [":gpio"],
    alwayslink = True,
)

cc_binary(
    name = "binary",
    srcs = ["main.c"],
    deps = [
        ":startup",
        ":uart",
    ],
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":binary"],
    target_platform = "//platform:raspberry_pi_3",
)

genrule(
    name = "kernel",
    srcs = [":elf"],
    outs = ["kernel8.img"],
    cmd = "$(execpath @aarch64_none_elf//:objcopy) -O binary $< $@",
    executable = True,
    tools = ["@aarch64_none_elf//:objcopy"],
    visibility = ["//visibility:public"],
)
