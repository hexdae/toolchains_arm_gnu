load("@arm_none_eabi//toolchain:toolchain.bzl", "arm_none_eabi_toolchain")

# Cortex-M3 toolchain
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
        "@platforms//os:none",
        "//custom/cpu:cortex_m3",
    ],
)

# Cortex-M4 toolchain, compiled using g++ instead of gcc
arm_none_eabi_toolchain(
    name = "cortex_m4_toolchain",
    copts = [
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
    ],
    gcc_tool = "g++",
    linkopts = [
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-nostartfiles",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "//custom/cpu:cortex_m4",
    ],
)
