"""Version rules for toolchains"""

load("@bazel_skylib//lib:versions.bzl", compare = "versions")
load(
    "@toolchains_arm_gnu//toolchain/archives:aarch64_none_elf.bzl",
    "AARCH64_NONE_ELF",
)
load(
    "@toolchains_arm_gnu//toolchain/archives:aarch64_none_linux_gnu.bzl",
    "AARCH64_NONE_LINUX_GNU",
)
load(
    "@toolchains_arm_gnu//toolchain/archives:arm_none_eabi.bzl",
    "ARM_NONE_EABI",
)
load(
    "@toolchains_arm_gnu//toolchain/archives:arm_none_linux_gnueabihf.bzl",
    "ARM_NONE_LINUX_GNUEABIHF",
)

def max_version(versions):
    """Obtains the minimum version from the list of version strings."""
    if versions:
        maximum = versions.pop(0)
        for version in versions:
            if not compare.is_at_most(maximum, version):
                maximum = version
        return maximum
    return None

def min_version(versions):
    """Obtains the minimum version from the list of version strings."""
    if versions:
        minimum = versions.pop(0)
        for version in versions:
            if not compare.is_at_least(minimum, version):
                minimum = version
        return minimum
    return None

def latest_version(name):
    """Return the latest version of the toolchain."""
    latest = {
        "arm-none-eabi": max_version(ARM_NONE_EABI.keys()),
        "arm-none-linux-gnueabihf": max_version(ARM_NONE_LINUX_GNUEABIHF.keys()),
        "aarch64-none-elf": max_version(AARCH64_NONE_ELF.keys()),
        "aarch64-none-linux-gnu": max_version(AARCH64_NONE_LINUX_GNU.keys()),
    }
    return latest.get(name, None)
