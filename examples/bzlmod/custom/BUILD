# project/BUILD.bazel

load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@toolchains_arm_gnu//toolchain:transitions.bzl", "toolchain_transition_filegroup")

cc_binary(
    name = "binary",
    srcs = ["main.c"],
    linkopts = [
        "-Wl,-entry=main",
    ],
    tags = ["manual"],
)

platform_transition_filegroup(
    name = "cortex_m3_elf",
    srcs = [":binary"],
    target_platform = "//custom/platform:cortex_m3",
    visibility = ["//visibility:public"],
)

platform_transition_filegroup(
    name = "cortex_m4_elf",
    srcs = [":binary"],
    target_platform = "//custom/platform:cortex_m4",
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "binary_that_needs_start",
    srcs = ["main.c"],
    linkopts = select({
        "//conditions:default": [],
        # require the toolchain to provide _start
        "@platforms//os:none": ["-Wl,--fatal-warnings"],
    }),
)

toolchain_transition_filegroup(
    name = "cortex_m4_elf_with_start",
    srcs = [":binary_that_needs_start"],
    platform = "//custom/platform:cortex_m4",
    toolchain = "//custom/toolchain:cortex_m4_toolchain_with_start",
    visibility = ["//visibility:public"],
)
