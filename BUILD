# BUILD

load("//toolchain:toolchain.bzl", "hosts", "tools")

package(default_visibility = ["//visibility:public"])

TOOLS = tools + ["bin"]

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
