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
## Using Bzlmod with Bazel 6 or greater

1. (Bazel 6 only) Enable with \`common --enable_bzlmod\` in \`.bazelrc\`.
2. Add to your \`MODULE.bazel\` file:

\`\`\`starlark
bazel_dep(name = "arm_gnu_toolchain", version = "${TAG:1}")

# Toolchains: arm-none-eabi
arm_toolchain = use_extension("@arm_gnu_toolchain//:extensions.bzl", "arm_toolchain")
arm_toolchain.arm_none_eabi(version = "13.2.1")
use_repo(
    arm_toolchain,
    "arm_none_eabi",
    "arm_none_eabi_darwin_arm64",
    "arm_none_eabi_darwin_x86_64",
    "arm_none_eabi_linux_aarch64",
    "arm_none_eabi_linux_x86_64",
    "arm_none_eabi_windows_x86_64",
)

register_toolchains("@arm_none_eabi//toolchain:all")

# Toolchains: arm-none-linux-gnueabihf
arm_toolchain.arm_none_linux_gnueabihf(version = "13.2.1")
use_repo(
    arm_toolchain,
    "arm_none_linux_gnueabihf",
    "arm_none_linux_gnueabihf_linux_aarch64",
    "arm_none_linux_gnueabihf_linux_x86_64",
    "arm_none_linux_gnueabihf_windows_x86_64",
)

register_toolchains("@arm_none_linux_gnueabihf//toolchain:all")
\`\`\`
EOF
