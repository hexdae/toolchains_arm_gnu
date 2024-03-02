"""
This BUILD file defines the toolchain targets for bzlmod consumers.
"""

load("@arm_gnu_toolchain//toolchain:toolchain.bzl", "arm_none_eabi_toolchain", "target_constraints")

[
    arm_none_eabi_toolchain(
        name = name,
        target_compatible_with = constraints,
    )
    for name, constraints in target_constraints['arm-none-eabi'].items()
]
