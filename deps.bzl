"""deps.bzl"""

load("@toolchains_arm_gnu//toolchain/archives:arm_none_eabi.bzl", "ARM_NONE_EABI")
load("@toolchains_arm_gnu//toolchain/archives:arm_none_linux_gnueabihf.bzl", "ARM_NONE_LINUX_GNUEABIHF")

def _arm_gnu_cross_hosted_platform_specific_repo_impl(repository_ctx):
    """Defines a host-specific repository for the ARM GNU toolchain."""
    repository_ctx.download_and_extract(
        sha256 = repository_ctx.attr.sha256,
        url = repository_ctx.attr.url,
        stripPrefix = repository_ctx.attr.strip_prefix,
    )
    repository_ctx.template(
        "BUILD.bazel",
        Label("@toolchains_arm_gnu//toolchain:templates/compiler.BUILD"),
        substitutions = {
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
            "%version%": repository_ctx.attr.version.split("-")[0],
            "%bin_extension%": repository_ctx.attr.bin_extension,
        },
    )
    for patch in repository_ctx.attr.patches:
        repository_ctx.patch(patch, strip = 1)

arm_gnu_cross_hosted_platform_specific_repo = repository_rule(
    implementation = _arm_gnu_cross_hosted_platform_specific_repo_impl,
    attrs = {
        "sha256": attr.string(mandatory = True),
        "url": attr.string(mandatory = True),
        "toolchain_prefix": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
        "strip_prefix": attr.string(),
        "patches": attr.label_list(),
        "bin_extension": attr.string(default = ""),
    },
)

def _arm_gnu_toolchain_repo_impl(repository_ctx):
    """Defines the top-level toolchain repository."""
    repository_ctx.template(
        "BUILD",
        Label("@toolchains_arm_gnu//toolchain:templates/top.BUILD"),
        substitutions = {
            "%toolchain_name%": repository_ctx.attr.toolchain_name,
            "%version%": repository_ctx.attr.version,
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
        },
    )

    repository_ctx.template(
        "toolchain/BUILD",
        Label("@toolchains_arm_gnu//toolchain:templates/toolchain.BUILD"),
        substitutions = {
            "%toolchain_name%": repository_ctx.attr.toolchain_name,
            "%version%": repository_ctx.attr.version,
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
        },
    )

toolchains_arm_gnu_repo = repository_rule(
    implementation = _arm_gnu_toolchain_repo_impl,
    attrs = {
        "toolchain_name": attr.string(mandatory = True),
        "toolchain_prefix": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
    },
)

def toolchains_arm_gnu_deps(toolchain, toolchain_prefix, version, archives):
    toolchains_arm_gnu_repo(
        name = toolchain,
        toolchain_name = toolchain,
        toolchain_prefix = toolchain_prefix,
        version = version,
    )

    for attrs in archives[version]:
        arm_gnu_cross_hosted_platform_specific_repo(
            toolchain_prefix = toolchain_prefix,
            version = version,
            **attrs
        )

def arm_none_eabi_deps(version = "13.2.1", archives = ARM_NONE_EABI):
    """Workspace dependencies for the arm none eabi gcc toolchain

    Args:
        version: The version of the toolchain to use. If None, the latest version is used.
        archives: A dictionary of version to archive attributes.
    """
    toolchains_arm_gnu_deps(
        "arm_none_eabi",
        "arm-none-eabi",
        version,
        archives,
    )

def arm_none_linux_gnueabihf_deps(version = "13.2.1", archives = ARM_NONE_LINUX_GNUEABIHF):
    """Workspace dependencies for the arm linux gcc toolchain

    Args:
        version: The version of the toolchain to use. If None, the latest version is used.
        archives: A dictionary of the version to archive attributes.
    """
    toolchains_arm_gnu_deps(
        "arm_none_linux_gnueabihf",
        "arm-none-linux-gnueabihf",
        version,
        archives,
    )
