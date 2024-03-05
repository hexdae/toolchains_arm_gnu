"""
This BUILD file defines the toolchain targets for bzlmod consumers. It is
rendered into the //toolchain package of the generated toolchain repository.
For example, "@arm_none_eabi//toolchain:*"
"""

package(default_visibility = ["//visibility:public"])

load(
    "@arm_gnu_toolchain//toolchain:toolchain.bzl",
    "%toolchain_name%_toolchain",
    "target_constraints",
)

[
    %toolchain_name%_toolchain(
        name = name,
        target_compatible_with = constraints,
    )
    for name, constraints in target_constraints['%toolchain_prefix%'].items()
]
