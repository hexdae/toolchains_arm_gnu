# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain_suite")
load("@arm_none_eabi//toolchain:toolchain.bzl", "arm_none_eabi_toolchain")

# This is for legacy compatibility, it will disappear in the future
cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "darwin": ":cc_toolchain_darwin_x86_64_default",
        "k8": ":cc_toolchain_linux_x86_64_default",
        "x64_windows": ":cc_toolchain_windows_x86_32_default",
    },
)

arm_none_eabi_toolchain(name = "default")
