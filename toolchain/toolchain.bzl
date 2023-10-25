"""
This module provides functions to register an arm-none-eabi toolchain
"""

load("@arm_none_eabi//toolchain:config.bzl", "cc_arm_none_eabi_config")

compatible_cpus = {
    "arm": "@platforms//cpu:arm",
    "armv6-m": "@platforms//cpu:armv6-m",
    "armv7-m": "@platforms//cpu:armv7-m",
    "armv7e-m": "@platforms//cpu:armv7e-m",
    "armv7e-mf": "@platforms//cpu:armv7e-mf",
    "armv8-m": "@platforms//cpu:armv8-m",
}

hosts = ["darwin_x86_64", "linux_x86_64", "linux_aarch64", "windows_x86_32"]

def register_arm_none_eabi_toolchain(name):
    for cpu in compatible_cpus.keys():
        native.register_toolchains(
            "{}_macos_{}".format(name, cpu),
            "{}_linux_x86_64_{}".format(name, cpu),
            "{}_linux_aarch64_{}".format(name, cpu),
            "{}_windows_x86_32_{}".format(name, cpu),
            "{}_windows_x86_64_{}".format(name, cpu),
        )

def arm_none_eabi_toolchain(name, constraint_values = [], copts = [], linkopts = []):
    """
    Create an arm-none-eabi toolchain with the given configuration.

    Args:
        name: The name of the toolchain.
        constraint_values: A list of constraint values to apply to the toolchain.
        copts: A list of compiler options to apply to the toolchain.
        linkopts: A list of linker options to apply to the toolchain.
    """
    for host in hosts:
        cc_arm_none_eabi_config(
            name = "config_{}_{}".format(host, name),
            gcc_repo = "arm_none_eabi_{}".format(host),
            gcc_version = "9.2.1",
            host_system_name = host,
            toolchain_identifier = "arm_none_eabi_{}_{}".format(host, name),
            toolchain_bins = "@arm_none_eabi_{}//:compiler_components".format(host),
            copts = copts,
            linkopts = linkopts,
        )

        native.cc_toolchain(
            name = "cc_toolchain_{}_{}".format(host, name),
            all_files = "@arm_none_eabi_{}//:compiler_pieces".format(host),
            ar_files = "@arm_none_eabi_{}//:ar".format(host),
            compiler_files = "@arm_none_eabi_{}//:compiler_files".format(host),
            dwp_files = ":empty",
            linker_files = "@arm_none_eabi_{}//:linker_files".format(host),
            objcopy_files = "@arm_none_eabi_{}//:objcopy".format(host),
            strip_files = "@arm_none_eabi_{}//:strip".format(host),
            supports_param_files = 0,
            toolchain_config = ":config_{}_{}".format(host, name),
            toolchain_identifier = "arm_none_eabi_{}_{}".format(host, name),
        )

    for cpu, cpu_constraint in compatible_cpus.items():
        native.toolchain(
            name = "{}_macos_{}".format(name, cpu),
            exec_compatible_with = ["@platforms//os:macos"],
            target_compatible_with = [
                "@platforms//os:none",
                cpu_constraint,
            ] + constraint_values,
            toolchain = ":cc_toolchain_darwin_x86_64_{}".format(name),
            toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        )

        native.toolchain(
            name = "{}_linux_x86_64_{}".format(name, cpu),
            exec_compatible_with = [
                "@platforms//os:linux",
                "@platforms//cpu:x86_64",
            ],
            target_compatible_with = [
                "@platforms//os:none",
                cpu_constraint,
            ] + constraint_values,
            toolchain = ":cc_toolchain_linux_x86_64_{}".format(name),
            toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        )

        native.toolchain(
            name = "{}_linux_aarch64_{}".format(name, cpu),
            exec_compatible_with = [
                "@platforms//os:linux",
                "@platforms//cpu:aarch64",
            ],
            target_compatible_with = [
                "@platforms//os:none",
                cpu_constraint,
            ] + constraint_values,
            toolchain = ":cc_toolchain_linux_aarch64_{}".format(name),
            toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        )

        native.toolchain(
            name = "{}_windows_x86_32_{}".format(name, cpu),
            exec_compatible_with = [
                "@platforms//os:windows",
                "@platforms//cpu:x86_32",
            ],
            target_compatible_with = [
                "@platforms//os:none",
                cpu_constraint,
            ] + constraint_values,
            toolchain = ":cc_toolchain_windows_x86_32_{}".format(name),
            toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        )

        native.toolchain(
            name = "{}_windows_x86_64_{}".format(name, cpu),
            exec_compatible_with = [
                "@platforms//os:windows",
                "@platforms//cpu:x86_64",
            ],
            target_compatible_with = [
                "@platforms//os:none",
                cpu_constraint,
            ] + constraint_values,
            # No 64bit source is available, so we reuse the 32bit one.
            toolchain = ":cc_toolchain_windows_x86_32_{}".format(name),
            toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        )
