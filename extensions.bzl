"""Module extension for toolchains"""

load(
    "@toolchains_arm_gnu//:deps.bzl",
    "arm_none_eabi_deps",
    "arm_none_linux_gnueabihf_deps",
)

def _semver(version):
    """Parse a semantic version string into a list of integers."""
    parts = [int(i.split("-")[0]) for i in version.split(".")]
    return struct(
        major = parts[0],
        minor = parts[1],
        patch = parts[2],
    )

def _module_toolchain(tag, deps):
    """Return a module toolchain."""
    return struct(
        tag = tag,
        deps = deps,
    )

def _compare_versions(left, right):
    """Compare two semantic versions."""
    left = _semver(left)
    right = _semver(right)

    # (a < b): -1, (a > b): 1, (a == b): 0.
    compare = lambda a, b: int(a > b) - int(a < b)

    return compare(left.major, right.major) or \
           compare(left.minor, right.minor) or \
           compare(left.patch, right.patch) or \
           0

def _minimal_supported_version(versions):
    """Obtains the minimum version from the list of version strings."""
    minimum = versions.pop(0)
    for version in versions:
        if _compare_versions(minimum, version) > 0:
            minimum = version
    return minimum

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
    ]

    for toolchain in available_toolchains:
        versions = [attr.version for mod in ctx.modules for attr in toolchain.tag(mod)]
        selected = _minimal_supported_version(versions)
        if selected:
            toolchain.deps(version = selected)

_toolchain = tag_class(attrs = {
    "version": attr.string(),
})

arm_toolchain = module_extension(
    implementation = _arm_toolchain_impl,
    tag_classes = {
        "arm_none_eabi": _toolchain,
        "arm_none_linux_gnueabihf": _toolchain,
    },
)
