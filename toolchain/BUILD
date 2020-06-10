# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain_suite")

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "darwin": "//toolchain/arm-none-eabi/darwin",
        "k8": "//toolchain/arm-none-eabi/linux",
        "x64_windows": "//toolchain/arm-none-eabi/windows",
    },
)
