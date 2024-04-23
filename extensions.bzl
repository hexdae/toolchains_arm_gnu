"""Module extension for toolchains"""

load(
    "@toolchains_arm_gnu//:deps.bzl",
    "aarch64_none_elf_deps",
    "aarch64_none_linux_gnu_deps",
    "arm_none_eabi_deps",
    "arm_none_linux_gnueabihf_deps",
)
load("@toolchains_arm_gnu//:version.bzl", "latest_version", "min_version")

def _module_toolchain(tag, deps):
    """Return a module toolchain."""
    return struct(
        tag = tag,
        deps = deps,
    )

def _arm_toolchain_impl(ctx):
    """Implement the module extension."""

    available_toolchains = [
        _module_toolchain(
            tag = lambda mod: mod.tags.arm_none_eabi,
            deps = arm_none_eabi_deps,
        ),
        _module_toolchain(
            tag = lambda mod: mod.tags.arm_none_linux_gnueabihf,
            deps = arm_none_linux_gnueabihf_deps,
        ),
        _module_toolchain(
            tag = lambda mod: mod.tags.aarch64_none_elf,
            deps = aarch64_none_elf_deps,
        ),
        _module_toolchain(
            tag = lambda mod: mod.tags.aarch64_none_linux_gnu,
            deps = aarch64_none_linux_gnu_deps,
        ),
    ]

    for toolchain in available_toolchains:
        versions = [attr.version for mod in ctx.modules for attr in toolchain.tag(mod)]
        selected = min_version(versions)
        if selected:
            toolchain.deps(version = selected)

arm_toolchain = module_extension(
    implementation = _arm_toolchain_impl,
    tag_classes = {
        "arm_none_eabi": tag_class(attrs = {
            "version": attr.string(default = latest_version("arm-none-eabi")),
        }),
        "arm_none_linux_gnueabihf": tag_class(attrs = {
            "version": attr.string(default = latest_version("arm-none-linux-gnueabihf")),
        }),
        "aarch64_none_elf": tag_class(attrs = {
            "version": attr.string(default = latest_version("aarch64-none-elf")),
        }),
        "aarch64_none_linux_gnu": tag_class(attrs = {
            "version": attr.string(default = latest_version("aarch64-none-linux-gnu")),
        }),
    },
)
