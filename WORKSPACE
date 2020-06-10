# WORKSPACE
workspace(name = "arm_none_eabi")

load(":deps.bzl", "arm_none_eabi_deps")

arm_none_eabi_deps()

register_toolchains(
    "@arm_none_eabi//toolchain:macos",
    "@arm_none_eabi//toolchain:linux",
    "@arm_none_eabi//toolchain:windows",
)
