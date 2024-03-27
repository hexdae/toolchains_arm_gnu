"""Provides a simple way to test your rules as an external workspace.
Add a basic smoke-test target below.
"""

load("@bazel_skylib//rules:build_test.bzl", "build_test")

build_test(
    name = "arm_linux_test",
    targets = ["//arm-linux:hex"],
)

build_test(
    name = "arm_none_test",
    targets = ["//arm-none:hex"],
)
