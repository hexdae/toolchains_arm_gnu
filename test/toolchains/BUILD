load("@arm_none_eabi//toolchain:toolchain.bzl", "arm_none_eabi_toolchain")

arm_none_eabi_toolchain(
    name = "cortex_m3_toolchain",
    copts = [
        "-mcpu=cortex-m3",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
    ],
    linkopts = [
        "-mcpu=cortex-m3",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-nostartfiles",
    ],
    target_compatible_with = [
        "@platforms//cpu:arm",
        "@platforms//os:none",
        "//test/constraints/mcpu:cortex_m3",
    ],
)
