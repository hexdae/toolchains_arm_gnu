# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

filegroup(
    name = "examples",
    srcs = [
        ":mock_bin",
        ":mock_binary",
        ":mock_hex",
        ":mock_library",
    ],
)

cc_library(
    name = "mock_library",
    srcs = ["source/library.cpp"],
    hdrs = ["includes/library.h"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    includes = ["includes"],
)

cc_binary(
    name = "mock_binary",
    srcs = ["source/main.cpp"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    linkopts = [
        "-nostartfiles",
        "-Wl,--entry,main",
    ],
)

genrule(
    name = "mock_bin",
    srcs = [":mock_binary"],
    outs = ["mock.bin"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O binary $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
)

genrule(
    name = "mock_hex",
    srcs = [":mock_binary"],
    outs = ["mock.hex"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
)
