# BUILD

load("//toolchain:toolchain.bzl", "hosts")

package(default_visibility = ["//visibility:public"])

TOOLS = [
    "bin",
    "gcc",
    "ar",
    "ld",
    "nm",
    "readelf",
    "objcopy",
    "objdump",
    "strip",
    "size",
    "gdb",
    "as",
]

[
    config_setting(
        name = host,
        constraint_values = constraint_values,
    )
    for host, constraint_values in hosts.items()
]

[
    filegroup(
        name = tool,
        srcs = select({
            host: ["@arm_none_eabi_{}//:{}".format(host, tool)]
            for host in hosts.keys()
        }),
    )
    for tool in TOOLS
]
