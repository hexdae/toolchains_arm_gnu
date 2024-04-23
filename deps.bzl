"""deps.bzl"""

load("@toolchains_arm_gnu//:version.bzl", "latest_version")
load("@toolchains_arm_gnu//toolchain:toolchain.bzl", "tools")
load("@toolchains_arm_gnu//toolchain/archives:aarch64_none_elf.bzl", "AARCH64_NONE_ELF")
load("@toolchains_arm_gnu//toolchain/archives:aarch64_none_linux_gnu.bzl", "AARCH64_NONE_LINUX_GNU")
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
            "%bin_extension%": ".exe" if "windows" in repository_ctx.name else "",
            "%tools%": "{}".format(repository_ctx.attr.tools),
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
        "tools": attr.string_list(default = tools),
        "exec_compatible_with": attr.string_list(),
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

    repository_ctx.template(
        "toolchain/toolchain.bzl",
        Label("@toolchains_arm_gnu//toolchain:templates/toolchain.bazel"),
        substitutions = {
            "%toolchain_name%": repository_ctx.attr.toolchain_name,
            "%version%": repository_ctx.attr.version,
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
            "%hosts%": "{}".format(repository_ctx.attr.hosts),
        },
    )

    for repo in repository_ctx.attr.hosts.keys():
        repository_ctx.template(
            "toolchain/{}/BUILD".format(repo),
            Label("@toolchains_arm_gnu//toolchain:templates/alias.BUILD"),
            substitutions = {
                "%repo%": repo,
                "%tools%": "{}".format(repository_ctx.attr.tools),
            },
        )

toolchains_arm_gnu_repo = repository_rule(
    implementation = _arm_gnu_toolchain_repo_impl,
    attrs = {
        "toolchain_name": attr.string(mandatory = True),
        "toolchain_prefix": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
        "hosts": attr.string_list_dict(mandatory = True),
        "tools": attr.string_list(default = tools),
    },
)

def toolchains_arm_gnu_deps(toolchain, toolchain_prefix, version, archives):
    archive = archives.get(version)

    if not archive:
        fail("Version {} not available in {}".format(version, archives.keys()))

    toolchains_arm_gnu_repo(
        name = toolchain,
        toolchain_name = toolchain,
        toolchain_prefix = toolchain_prefix,
        version = version,
        hosts = {
            repo["name"]: repo["exec_compatible_with"]
            for repo in archive
        },
    )

    for attrs in archive:
        arm_gnu_cross_hosted_platform_specific_repo(
            toolchain_prefix = toolchain_prefix,
            version = version,
            **attrs
        )

def arm_none_eabi_deps(version = latest_version("arm-none-eabi"), archives = ARM_NONE_EABI):
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

def arm_none_linux_gnueabihf_deps(version = latest_version("arm-none-linux-gnueabihf"), archives = ARM_NONE_LINUX_GNUEABIHF):
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

def aarch64_none_elf_deps(version = latest_version("aarch64-none-elf"), archives = AARCH64_NONE_ELF):
    """Workspace dependencies for the arm gcc toolchain

    Args:
        version: The version of the toolchain to use. If None, the latest version is used.
        archives: A dictionary of the version to archive attributes.
    """
    toolchains_arm_gnu_deps(
        "aarch64_none_elf",
        "aarch64-none-elf",
        version,
        archives,
    )

def aarch64_none_linux_gnu_deps(version = latest_version("aarch64-none-linux-gnu"), archives = AARCH64_NONE_LINUX_GNU):
    """Workspace dependencies for the arm linux gcc toolchain

    Args:
        version: The version of the toolchain to use. If None, the latest version is used.
        archives: A dictionary of the version to archive attributes.
    """
    toolchains_arm_gnu_deps(
        "aarch64_none_linux_gnu",
        "aarch64-none-linux-gnu",
        version,
        archives,
    )
