load("@arm_none_eabi//toolchain:toolchain.bzl", "arm_none_eabi_toolchain")

arm_none_eabi_toolchain(
    name = "cortex_m3_toolchain",
    target_compatible_with = [
        "@platforms//os:none",
        "//examples/custom/cpu:cortex_m3"
    ],
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
)

arm_none_eabi_toolchain(
    name = "cortex_m4_toolchain",
    target_compatible_with = [
        "@platforms//os:none",
        "//examples/custom/cpu:cortex_m4"
    ],
    copts = [
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
    ],
    linkopts = [
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-nostartfiles",
    ],
)
