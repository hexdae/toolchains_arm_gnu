load("@bazel_skylib//rules:build_test.bzl", "build_test")

build_test(
    name = "aarch64_none_elf",
    targets = ["//test/aarch64-none-elf:hex"],
)

build_test(
    name = "aarch64_none_linux_gnu",
    targets = ["//test/aarch64-none-linux-gnu:hex"],
)

build_test(
    name = "arm_none_eabi",
    targets = [
        "//test/arm-none-eabi:hex",
        "//test/arm-none-eabi:map",
        "//test/arm-none-eabi:builds_without_warnings_bin",
    ],
)

build_test(
    name = "arm_none_linux_gnueabihf",
    targets = ["//test/arm-none-linux-gnueabihf:hex"],
)
