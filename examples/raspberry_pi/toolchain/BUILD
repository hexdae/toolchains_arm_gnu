load("@aarch64_none_elf//toolchain:toolchain.bzl", "aarch64_none_elf_toolchain")

aarch64_none_elf_toolchain(
    name = "toolchain_pi3",
    copts = [
        "-mcpu=cortex-a53",
        "-Wall",
        "-O2",
        "-ffreestanding",
        "-nostdinc",
        "-nostdlib",
        "-nostartfiles",
    ],
    linkopts = [
        "-mcpu=cortex-a53",
        "-nostartfiles",
        "-nostdlib",
    ],
    target_compatible_with = [
        "//cpu:a53",
        "@platforms//os:none",
    ],
)

aarch64_none_elf_toolchain(
    name = "toolchain_pi4",
    copts = [
        "-mcpu=cortex-a72",
        "-Wall",
        "-O2",
        "-ffreestanding",
    ],
    linkopts = [
        "-mcpu=cortex-a72",
        "-nostartfiles",
        "-nostdlib",
    ],
    target_compatible_with = [
        "//cpu:a72",
        "@platforms//os:none",
    ],
)

aarch64_none_elf_toolchain(
    name = "toolchain_pi5",
    copts = [
        "-mcpu=cortex-a76",
        "-Wall",
        "-O2",
        "-ffreestanding",
    ],
    linkopts = [
        "-mcpu=cortex-a76",
        "-nostartfiles",
        "-nostdlib",
    ],
    target_compatible_with = [
        "//cpu:a76",
        "@platforms//os:none",
    ],
)
