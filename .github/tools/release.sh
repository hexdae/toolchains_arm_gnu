#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}
# The prefix is chosen to match what GitHub generates for source archives
# This guarantees that users can easily switch from a released artifact to a source archive
# with minimal differences in their code (e.g. strip_prefix remains the same)
PREFIX="toolchains_arm_gnu-${TAG:1}"
ARCHIVE="toolchains_arm_gnu-$TAG.tar.gz"

# NB: configuration for 'git archive' is in /.gitattributes
git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip > $ARCHIVE
SHA=$(shasum -a 256 $ARCHIVE | awk '{print $1}')

cat << EOF
## MODULE.bazel

Feel free to pick only the toolchains you need. Default toolchains are provided, but registering them is optional (especially when using custom toolchains)

\`\`\`starlark
bazel_dep(name = "toolchains_arm_gnu", version = "${TAG:1}")

arm_toolchain = use_extension("@toolchains_arm_gnu//:extensions.bzl", "arm_toolchain")

arm_toolchain.arm_none_eabi()
use_repo(arm_toolchain, "arm_none_eabi")
register_toolchains("@arm_none_eabi//toolchain:all")

arm_toolchain.arm_none_linux_gnueabihf()
use_repo(arm_toolchain, "arm_none_linux_gnueabihf")
register_toolchains("@arm_none_linux_gnueabihf//toolchain:all")

arm_toolchain.aarch64_none_elf()
use_repo(arm_toolchain, "aarch64_none_elf")
register_toolchains("@aarch64_none_elf//toolchain:all")

arm_toolchain.aarch64_none_linux_gnu()
use_repo(arm_toolchain, "aarch64_none_linux_gnu")
register_toolchains("@aarch64_none_linux_gnu//toolchain:all")
\`\`\`


## WORKSPACE

<details>

<summary> WORKSPACE contents </summary>

\`\`\`starlark
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_cc",
    remote = "https://github.com/bazelbuild/rules_cc",
    branch = "main",
)

git_repository(
    name = "arm_none_eabi",
    remote = "https://github.com/hexdae/toolchains_arm_gnu",
    branch = "master",
)

# Toolchain: arm-none-eabi
load("@toolchains_arm_gnu//:deps.bzl", "arm_none_eabi_deps")
arm_none_eabi_deps()
register_toolchains("@arm_none_eabi//toolchain:all")

# Toolchain arm-none-linux-gnueabihf
load("@toolchains_arm_gnu//:deps.bzl", "arm_none_linux_gnueabihf_deps")
arm_none_linux_gnueabihf_deps()
register_toolchains("@arm_none_linux_gnueabihf//toolchain:all")

# Toolchain aarch64-none-elf
load("@toolchains_arm_gnu//:deps.bzl", "aarch64_none_elf_deps")
aarch64_none_elf_deps()
register_toolchains("@aarch64_none_elf//toolchain:all")

# Toolchain aarch64-none-linux-gnu
load("@toolchains_arm_gnu//:deps.bzl", "aarch64_none_linux_gnu_deps")
aarch64_none_linux_gnu_deps()
register_toolchains("@aarch64_none_linux_gnu//toolchain:all")
\`\`\`

</details>

EOF
