"""Version rules for toolchains"""

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

def _semver(version):
    """Parse a semantic version string into a list of integers."""
    parts = [int(i.split("-")[0]) for i in version.split(".")]
    return struct(
        major = parts[0],
        minor = parts[1],
        patch = parts[2],
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

def max_version(versions):
    """Obtains the minimum version from the list of version strings."""
    if versions:
        maximum = versions.pop(0)
        for version in versions:
            if _compare_versions(maximum, version) < 0:
                maximum = version
        return maximum
    return None

def min_version(versions):
    """Obtains the minimum version from the list of version strings."""
    if versions:
        minimum = versions.pop(0)
        for version in versions:
            if _compare_versions(minimum, version) > 0:
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
