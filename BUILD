# BUILD

package(default_visibility = ["//visibility:public"])

config_setting(
    name = "darwin",
    values = {"host_cpu": "darwin"},
)

config_setting(
    name = "linux",
    values = {"host_cpu": "k8"},
)

config_setting(
    name = "windows",
    values = {"host_cpu": "x64_windows"},
)

filegroup(
    name = "gcc",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-gcc"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-gcc"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-gcc.exe"],
    }),
)

filegroup(
    name = "ar",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-ar"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-ar"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-ar.exe"],
    }),
)

filegroup(
    name = "ld",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-ld"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-ld"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-ld.exe"],
    }),
)

filegroup(
    name = "nm",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-nm"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-nm"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-nm.exe"],
    }),
)

filegroup(
    name = "objcopy",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-objcopy"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-objcopy"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-objcopy.exe"],
    }),
)

filegroup(
    name = "objdump",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-objdump"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-objdump"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-objdump.exe"],
    }),
)

filegroup(
    name = "strip",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-strip"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-strip"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-strip.exe"],
    }),
)

filegroup(
    name = "as",
    srcs = select({
        "darwin": ["@arm_none_eabi_darwin//:bin/arm-none-eabi-as"],
        "linux": ["@arm_none_eabi_linux//:bin/arm-none-eabi-as"],
        "windows": ["@arm_none_eabi_windows//:bin/arm-none-eabi-as.exe"],
    }),
)
