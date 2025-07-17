"""
This BUILD file marks the top-level package of the generated toolchain
repository, i.e., the targets defined here appear in the workspace as
"@arm_none_eabi//:*" for arm-none-eabi toolchains.
"""

load("@bazel_skylib//rules:native_binary.bzl", "native_binary")
load("@local_config_platform//:constraints.bzl", "HOST_CONSTRAINTS")
load(
    "@toolchains_arm_gnu//toolchain:toolchain.bzl",
    "host_from",
    "hosts",
    "tools",
)

package(default_visibility = ["//visibility:public"])

TOOLS = tools
host = host_from(HOST_CONSTRAINTS)

[
    native_binary(
        name = tool,
        src = "@%toolchain_name%_{}//:{}".format(host, tool),
        out = tool,
        target_compatible_with = (
            []
            if host in hosts["%toolchain_prefix%"].keys() else
            ["@platforms//:incompatible"]
        ),
    )
    for tool in TOOLS
]
