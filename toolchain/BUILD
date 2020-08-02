# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain_suite")

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "darwin": ":cc_toolchain_darwin",
        "k8": ":cc_toolchain_linux_x86_64",
        "x64_windows": ":cc_toolchain_windows",
    },
)

cc_toolchain(
    name = "cc_toolchain_darwin",
    all_files = "//toolchain/arm-none-eabi/darwin:all_files",
    ar_files = "//toolchain/arm-none-eabi/darwin:ar_files",
    compiler_files = "//toolchain/arm-none-eabi/darwin:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/arm-none-eabi/darwin:linker_files",
    objcopy_files = "//toolchain/arm-none-eabi/darwin:objcopy_files",
    strip_files = "//toolchain/arm-none-eabi/darwin:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/arm-none-eabi/darwin:config",
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
    name = "cc_toolchain_windows",
    all_files = "//toolchain/arm-none-eabi/windows:all_files",
    ar_files = "//toolchain/arm-none-eabi/windows:ar_files",
    compiler_files = "//toolchain/arm-none-eabi/windows:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/arm-none-eabi/windows:linker_files",
    objcopy_files = "//toolchain/arm-none-eabi/windows:objcopy_files",
    strip_files = "//toolchain/arm-none-eabi/windows:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/arm-none-eabi/windows:config",
    toolchain_identifier = "arm_none_eabi_windows_x86_32",
)

toolchain(
    name = "macos",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:x86_64"
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:arm",
    ],
    toolchain = ":cc_toolchain_darwin",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64"
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:arm",
    ],
    toolchain = ":cc_toolchain_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)


toolchain(
    name = "linux_aarch64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64"
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:arm",
    ],
    toolchain = ":cc_toolchain_linux_aarch64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)


toolchain(
    name = "windows",
    exec_compatible_with = [
        "@platforms//os:windows",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:arm",
    ],
    toolchain = ":cc_toolchain_windows",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
