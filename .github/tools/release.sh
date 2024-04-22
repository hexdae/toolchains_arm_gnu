#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}
# The prefix is chosen to match what GitHub generates for source archives
# This guarantees that users can easily switch from a released artifact to a source archive
# with minimal differences in their code (e.g. strip_prefix remains the same)
PREFIX="bazel-arm-none-eabi-${TAG:1}"
ARCHIVE="bazel-arm-none-eabi-$TAG.tar.gz"

# NB: configuration for 'git archive' is in /.gitattributes
git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip > $ARCHIVE
SHA=$(shasum -a 256 $ARCHIVE | awk '{print $1}')

cat << EOF
## MODULE.bazel

\`\`\`starlark
bazel_dep(name = "toolchains_arm_gnu", version = "${TAG:1}")

arm_toolchain = use_extension("@toolchains_arm_gnu//:extensions.bzl", "arm_toolchain")

arm_toolchain.arm_none_eabi()
use_repo(arm_toolchain, "arm_none_eabi")
register_toolchains("@arm_none_eabi//toolchain:all")

arm_toolchain.arm_none_linux_gnueabihf()
use_repo(arm_toolchain, "arm_none_linux_gnueabihf")
register_toolchains("@arm_none_linux_gnueabihf//toolchain:all")
\`\`\`

## WORKSPACE

\`\`\`starlark
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_cc",
    remote = "https://github.com/bazelbuild/rules_cc",
    branch = "main",
)

git_repository(
    name = "arm_none_eabi",
    remote = "https://github.com/hexdae/bazel-arm-none-eabi",
    branch = "master",
)

# Toolchain: arm-none-eabi
load("@toolchains_arm_gnu//:deps.bzl", "arm_none_eabi_deps", "arm_none_linux_gnueabihf_deps")
arm_none_eabi_deps()
register_toolchains("@arm_none_eabi//toolchain:all")

# Toolchain arm-none-linux-gnueabihf
arm_none_linux_gnueabihf_deps()
register_toolchains("@arm_none_linux_gnueabihf//toolchain:all")
\`\`\`

EOF
