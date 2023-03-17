# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain", "cc_toolchain_suite")
load("@arm_none_eabi//:deps.bzl", "compatible_cpus")

# This is for legacy compatibility, it will disappear in the future
cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "darwin": ":cc_toolchain_darwin",
        "k8": ":cc_toolchain_linux_x86_64",
        "x64_windows": ":cc_toolchain_windows_x86_32",
    },
)

cc_toolchain(
    name = "cc_toolchain_darwin",
    all_files = "//toolchain/arm-none-eabi/darwin_x86_64:all_files",
    ar_files = "//toolchain/arm-none-eabi/darwin_x86_64:ar_files",
    compiler_files = "//toolchain/arm-none-eabi/darwin_x86_64:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/arm-none-eabi/darwin_x86_64:linker_files",
    objcopy_files = "//toolchain/arm-none-eabi/darwin_x86_64:objcopy_files",
    strip_files = "//toolchain/arm-none-eabi/darwin_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/arm-none-eabi/darwin_x86_64:config",
    toolchain_identifier = "arm_none_eabi_darwin",
)

cc_toolchain(
    name = "cc_toolchain_linux_x86_64",
    all_files = "//toolchain/arm-none-eabi/linux_x86_64:all_files",
    ar_files = "//toolchain/arm-none-eabi/linux_x86_64:ar_files",
    compiler_files = "//toolchain/arm-none-eabi/linux_x86_64:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/arm-none-eabi/linux_x86_64:linker_files",
    objcopy_files = "//toolchain/arm-none-eabi/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/arm-none-eabi/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/arm-none-eabi/linux_x86_64:config",
    toolchain_identifier = "arm_none_eabi_linux_x86_64",
)

cc_toolchain(
    name = "cc_toolchain_linux_aarch64",
    all_files = "//toolchain/arm-none-eabi/linux_aarch64:all_files",
    ar_files = "//toolchain/arm-none-eabi/linux_aarch64:ar_files",
    compiler_files = "//toolchain/arm-none-eabi/linux_aarch64:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/arm-none-eabi/linux_aarch64:linker_files",
    objcopy_files = "//toolchain/arm-none-eabi/linux_aarch64:objcopy_files",
    strip_files = "//toolchain/arm-none-eabi/linux_aarch64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/arm-none-eabi/linux_aarch64:config",
    toolchain_identifier = "arm_none_eabi_linux_aarch64",
)

cc_toolchain(
    name = "cc_toolchain_windows_x86_32",
    all_files = "//toolchain/arm-none-eabi/windows_x86_32:all_files",
    ar_files = "//toolchain/arm-none-eabi/windows_x86_32:ar_files",
    compiler_files = "//toolchain/arm-none-eabi/windows_x86_32:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/arm-none-eabi/windows_x86_32:linker_files",
    objcopy_files = "//toolchain/arm-none-eabi/windows_x86_32:objcopy_files",
    strip_files = "//toolchain/arm-none-eabi/windows_x86_32:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/arm-none-eabi/windows_x86_32:config",
    toolchain_identifier = "arm_none_eabi_windows_x86_32",
)

[
    toolchain(
        name = "macos_{}".format(cpu),
        exec_compatible_with = ["@platforms//os:macos"],
        target_compatible_with = [
            "@platforms//os:none",
            cpu_constraint,
        ],
        toolchain = ":cc_toolchain_darwin",
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )
    for cpu, cpu_constraint in compatible_cpus.items()
]

[
    toolchain(
        name = "linux_x86_64_{}".format(cpu),
        exec_compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ],
        target_compatible_with = [
            "@platforms//os:none",
            cpu_constraint,
        ],
        toolchain = ":cc_toolchain_linux_x86_64",
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )
    for cpu, cpu_constraint in compatible_cpus.items()
]

[
    toolchain(
        name = "linux_aarch64_{}".format(cpu),
        exec_compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:aarch64",
        ],
        target_compatible_with = [
            "@platforms//os:none",
            cpu_constraint,
        ],
        toolchain = ":cc_toolchain_linux_aarch64",
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )
    for cpu, cpu_constraint in compatible_cpus.items()
]

[
    toolchain(
        name = "windows_x86_32_{}".format(cpu),
        exec_compatible_with = [
            "@platforms//os:windows",
            "@platforms//cpu:x86_32",
        ],
        target_compatible_with = [
            "@platforms//os:none",
            cpu_constraint,
        ],
        toolchain = ":cc_toolchain_windows_x86_32",
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )
    for cpu, cpu_constraint in compatible_cpus.items()
]

[
    toolchain(
        name = "windows_x86_64_{}".format(cpu),
        exec_compatible_with = [
            "@platforms//os:windows",
            "@platforms//cpu:x86_64",
        ],
        target_compatible_with = [
            "@platforms//os:none",
            cpu_constraint,
        ],
        # No 64bit source is available, so we reuse the 32bit one.
        toolchain = ":cc_toolchain_windows_x86_32",
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )
    for cpu, cpu_constraint in compatible_cpus.items()
]
