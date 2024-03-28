load("@bazel_skylib//rules:build_test.bzl", "build_test")

platform(
    name = "worker",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
)

build_test(
    name = "arm_linux_test",
    targets = ["//bre/arm-linux:hex"],
)

build_test(
    name = "arm_none_test",
    targets = ["//bre/arm-none:hex"],
)
