"""
This module provides functions to register an arm-none-eabi toolchain
"""

load("@arm_gnu_toolchain//toolchain:config.bzl", "cc_arm_gnu_toolchain_config")

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
}

hosts = {
    "arm-none-eabi": {
        "darwin_x86_64": ["@platforms//os:macos"],  # Also runs on apple silicon
        "linux_x86_64": ["@platforms//os:linux", "@platforms//cpu:x86_64"],
        "linux_aarch64": ["@platforms//os:linux", "@platforms//cpu:arm64"],
        "windows_x86_64": ["@platforms//os:windows", "@platforms//cpu:x86_64"],
    },
}

def _arm_gnu_toolchain(name, toolchain = "", toolchain_prefix = "",
                       gcc_tool = "gcc", abi_version = "",
                       target_compatible_with = [], copts = [],
                       linkopts = [], version = "", include_std = False):
    for host, exec_compatible_with in hosts[toolchain_prefix].items():
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
            include_path = [
                "@{}_{}//:{}/include".format(toolchain, host, toolchain_prefix),
                "@{}_{}//:lib/gcc/{}/{}/include".format(toolchain, host, toolchain_prefix, version),
                "@{}_{}//:lib/gcc/{}/{}/include-fixed".format(toolchain, host, toolchain_prefix, version),
                "@{}_{}//:{}/include/c++/{}".format(toolchain, host, toolchain_prefix, version),
                "@{}_{}//:{}/include/c++/{}/{}".format(toolchain, host, toolchain_prefix, version, toolchain_prefix),
            ],
            library_path = [
                "@{}_{}//:{}".format(toolchain, host, toolchain_prefix),
                "@{}_{}//:{}/lib".format(toolchain, host, toolchain_prefix),
                "@{}_{}//:lib/gcc/{}/{}".format(toolchain, host, toolchain_prefix, version),
            ],
            copts = copts,
            linkopts = linkopts,
            include_std = include_std,
        )

        native.cc_toolchain(
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

def arm_none_eabi_toolchain(name, version = "9.2.1", **kwargs):
    """
    Create an arm-none-eabi toolchain with the given configuration.

    Args:
        name: The name of the toolchain.
        gcc_tool: The gcc tool to use. Defaults to "gcc". [gcc, c++, cpp]
        target_compatible_with: A list of constraint values to apply to the toolchain.
        copts: A list of compiler options to apply to the toolchain.
        linkopts: A list of linker options to apply to the toolchain.
        version: The version of the gcc toolchain.
        include_std: Whether to include the standard library in the include path.
    """
    _arm_gnu_toolchain(name, toolchain = "arm_none_eabi",
                       toolchain_prefix = "arm-none-eabi", version = version,
                       abi_version = "eabi", **kwargs)

def register_arm_gnu_toolchain(name):
    for host in hosts:
        native.register_toolchains("{}_{}".format(name, host))
