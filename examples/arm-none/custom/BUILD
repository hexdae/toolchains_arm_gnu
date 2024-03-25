# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")

cc_binary(
    name = "binary",
    srcs = ["main.c"],
    linkopts = [
        "-Wl,-entry=main",
    ],
    target_compatible_with = [
        "@platforms//os:none",
    ],
)

platform_transition_filegroup(
    name = "cortex_m3_elf",
    srcs = [":binary"],
    target_platform = "//examples/arm-none/custom/platform:cortex_m3",
)

platform_transition_filegroup(
    name = "cortex_m4_elf",
    srcs = [":binary"],
    target_platform = "//examples/arm-none/custom/platform:cortex_m4",
)
