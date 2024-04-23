"""
This BUILD file marks the top-level package of the generated toolchain
repository, i.e., the targets defined here appear in the workspace as
"@arm_none_eabi//:*" for arm-none-eabi toolchains.
"""

load("@toolchains_arm_gnu//toolchain:toolchain.bzl", "hosts", "tools")
load("@bazel_skylib//rules:native_binary.bzl", "native_binary")

package(default_visibility = ["//visibility:public"])

TOOLS = tools + ["bin"]

[
    config_setting(
        name = host,
        constraint_values = constraint_values,
    )
    for host, constraint_values in hosts["%toolchain_prefix%"].items()
]

[
    native_binary(
        name = tool,
        src = select({
            host: "@%toolchain_name%_{}//:{}".format(host, tool)
            for host in hosts["%toolchain_prefix%"].keys()
        }),
        out = tool,
        target_compatible_with = select({
            host: constraint_values
            for host, constraint_values in hosts["%toolchain_prefix%"].items()
        } | {
            "//conditions:default": ["@platforms//:incompatible"],
        }),
    )
    for tool in TOOLS
]
