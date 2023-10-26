# toolchain/BUILD

load("@arm_none_eabi//toolchain:toolchain.bzl", "arm_none_eabi_toolchain", "compatible_cpus")

[
    arm_none_eabi_toolchain(
        name = name,
        target_compatible_with = [
            "@platforms//os:none",
            platform,
        ],
    )
    for name, platform in compatible_cpus.items()
]
