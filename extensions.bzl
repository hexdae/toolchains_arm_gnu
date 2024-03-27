load(
    "@arm_gnu_toolchain//:deps.bzl",
    "arm_none_eabi_deps",
    "arm_none_linux_gnueabihf_deps",
)

def compare_versions(left, right):
    """
    Compare two version strings, assuming that they're both of the form
    major.minor.patch.

    Returns:
      -1 if left < right
      0 if left == right
      1 if left > right
    """
    left_parts = [int(i) for i in left.split(".")]
    right_parts = [int(i) for i in right.split(".")]
    for i in range(3):
        if left_parts[0] < right_parts[0]:
            return -1

        if left_parts[0] > right_parts[0]:
            return 1

    return 0

def minimum_supported_version(versions):
    """Obtains the minimum version from the list of version strings."""
    if not len(versions):
        return None

    if 1 == len(versions):
        return versions[0]

    minimum = versions[0]
    for version in versions[1:]:
        if compare_versions(minimum, version) > 0:
            minimum = version

    return minimum

def get_toolchain_versions(module_ctx, tag_class):
    """Extract toolchain versions from tag classes obtained by evaluating
    the lambda on each module."""
    versions = []
    for mod in module_ctx.modules:
        for attr in tag_class(mod):
            versions.append(attr.version)
    return versions

def _arm_toolchain_impl(ctx):
    selected_baremetal_version = minimum_supported_version(
        get_toolchain_versions(
            ctx,
            lambda mod: mod.tags.arm_none_eabi,
        ),
    )
    if selected_baremetal_version:
        arm_none_eabi_deps(version = selected_baremetal_version)

    selected_linux_version = minimum_supported_version(
        get_toolchain_versions(
            ctx,
            lambda mod: mod.tags.arm_none_linux_gnueabihf,
        ),
    )
    if selected_linux_version:
        arm_none_linux_gnueabihf_deps(version = selected_linux_version)

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
