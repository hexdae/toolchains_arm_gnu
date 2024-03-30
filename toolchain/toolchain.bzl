"""
This module provides functions to register an arm-none-eabi toolchain
"""

load("@toolchains_arm_gnu//toolchain:config.bzl", "cc_arm_gnu_toolchain_config")
load("@rules_cc//cc:defs.bzl", "cc_toolchain")

tools = [
    "as",
    "ar",
    "c++",
    "cpp",
    "g++",
    "gcc",
    "gdb",
    "ld",
    "nm",
    "objcopy",
    "objdump",
    "readelf",
    "strip",
    "size",
]

target_constraints = {
    "arm-none-eabi": {
        "arm": ["@platforms//os:none", "@platforms//cpu:arm"],
        "armv6-m": ["@platforms//os:none", "@platforms//cpu:armv6-m"],
        "armv7-m": ["@platforms//os:none", "@platforms//cpu:armv7-m"],
        "armv7e-m": ["@platforms//os:none", "@platforms//cpu:armv7e-m"],
        "armv7e-mf": ["@platforms//os:none", "@platforms//cpu:armv7e-mf"],
        "armv8-m": ["@platforms//os:none", "@platforms//cpu:armv8-m"],
    },
    "arm-none-linux-gnueabihf": {
        "arm": ["@platforms//os:linux", "@platforms//cpu:arm"],
        "armv7": ["@platforms//os:linux", "@platforms//cpu:armv7"],
    },
}

hosts = {
    "arm-none-eabi": {
        "darwin_x86_64": ["@platforms//os:macos", "@platforms//cpu:x86_64"],
        "darwin_arm64": ["@platforms//os:macos", "@platforms//cpu:arm64"],
        "linux_x86_64": ["@platforms//os:linux", "@platforms//cpu:x86_64"],
        "linux_aarch64": ["@platforms//os:linux", "@platforms//cpu:arm64"],
        "windows_x86_64": ["@platforms//os:windows", "@platforms//cpu:x86_64"],
    },
    "arm-none-linux-gnueabihf": {
        # ARM has not provided an arm linux toolchain for darwin.
        "linux_x86_64": ["@platforms//os:linux", "@platforms//cpu:x86_64"],
        "linux_aarch64": ["@platforms//os:linux", "@platforms//cpu:arm64"],
        "windows_x86_64": ["@platforms//os:windows", "@platforms//cpu:x86_64"],
    },
}

def _arm_gnu_toolchain(
        name,
        toolchain = "",
        toolchain_prefix = "",
        gcc_tool = "gcc",
        abi_version = "",
        target_compatible_with = [],
        copts = [],
        linkopts = [],
        version = "",
        include_std = False):
    for host, exec_compatible_with in hosts[toolchain_prefix].items():
        fix_linkopts = []

        # macOS on apple rejects the relative path LTO plugin
        if version == "13.2.1" and "darwin" in host:
            fix_linkopts.append("-fno-lto")

        cc_arm_gnu_toolchain_config(
            name = "config_{}_{}".format(host, name),
            gcc_repo = "{}_{}".format(toolchain, host),
            gcc_version = version,
            gcc_tool = gcc_tool,
            abi_version = abi_version,
            host_system_name = host,
            toolchain_prefix = toolchain_prefix,
            toolchain_identifier = "{}_{}_{}".format(toolchain, host, name),
            toolchain_bins = "@{}_{}//:compiler_components".format(toolchain, host),
            include_path = ["@{}_{}//:include_path".format(toolchain, host)],
            library_path = ["@{}_{}//:library_path".format(toolchain, host)],
            copts = copts,
            linkopts = linkopts + fix_linkopts,
            include_std = include_std,
        )

        cc_toolchain(
            name = "cc_toolchain_{}_{}".format(host, name),
            all_files = "@{}_{}//:compiler_pieces".format(toolchain, host),
            ar_files = "@{}_{}//:ar_files".format(toolchain, host),
            compiler_files = "@{}_{}//:compiler_files".format(toolchain, host),
            dwp_files = ":empty",
            linker_files = "@{}_{}//:linker_files".format(toolchain, host),
            objcopy_files = "@{}_{}//:objcopy".format(toolchain, host),
            strip_files = "@{}_{}//:strip".format(toolchain, host),
            supports_param_files = 0,
            toolchain_config = ":config_{}_{}".format(host, name),
            toolchain_identifier = "{}_{}_{}".format(toolchain, host, name),
        )

        native.toolchain(
            name = "{}_{}".format(name, host),
            exec_compatible_with = exec_compatible_with,
            target_compatible_with = target_compatible_with,
            toolchain = ":cc_toolchain_{}_{}".format(host, name),
            toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        )

def arm_none_eabi_toolchain(name, version = "13.2.1", **kwargs):
    """
    Create an arm-none-eabi toolchain with the given configuration.

    Args:
        name: The name of the toolchain.
        version: The version of the gcc toolchain.
        **kwargs: same as toolchains_arm_gnu
    """
    _arm_gnu_toolchain(
        name,
        toolchain = "arm_none_eabi",
        toolchain_prefix = "arm-none-eabi",
        version = version,
        abi_version = "eabi",
        **kwargs
    )

def arm_none_linux_gnueabihf_toolchain(
        name,
        version = "13.2.1",
        linkopts = [],
        **kwargs):
    """
    Create an arm-none-linux-gnueabihf toolchain with the given configuration.

    Args:
        name: The name of the toolchain.
        version: The version of the gcc toolchain.
        linkopts: Additional linker options.
        **kwargs: Additional keyword arguments.
    """
    _arm_gnu_toolchain(
        name,
        toolchain = "arm_none_linux_gnueabihf",
        toolchain_prefix = "arm-none-linux-gnueabihf",
        version = version,
        abi_version = "gnueabihf",
        linkopts = ["-lc", "-lstdc++"] + linkopts,
        include_std = True,
        **kwargs
    )

def register_arm_gnu_toolchain(name, prefix):
    for host in hosts[prefix]:
        native.register_toolchains("{}_{}".format(name, host))
