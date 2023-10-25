# WORKSPACE
workspace(name = "arm_none_eabi")

load(":deps.bzl", "arm_none_eabi_deps")
load("//toolchain:toolchains.bzl", "register_arm_none_eabi_toolchain")

arm_none_eabi_deps()

register_arm_none_eabi_toolchain("//toolchain:default")
