# toolchains/arm-none-eabi/darwin/BUILD.bazel

load("@arm_none_eabi//toolchain:config.bzl", "cc_arm_none_eabi_config")

package(default_visibility = ["//visibility:public"])

compiler = "arm_none_eabi_darwin_x86_64"

exports_files(["**"])

filegroup(
    name = "all_wrappers",
    srcs = [
        "arm-none-eabi-ar",
        "arm-none-eabi-cpp",
        "arm-none-eabi-gcc",
        "arm-none-eabi-gcov",
        "arm-none-eabi-ld",
        "arm-none-eabi-nm",
        "arm-none-eabi-objcopy",
        "arm-none-eabi-objdump",
        "arm-none-eabi-strip",
    ],
)

filegroup(
    name = "all_files",
    srcs = [
        ":ar_files",
        ":compiler_files",
        ":linker_files",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

filegroup(
    name = "compiler_files",
    srcs = [
        "arm-none-eabi-gcc",
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "arm-none-eabi-gcc",
        "arm-none-eabi-ld",
        "@{}//:ar".format(compiler),
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
        "@{}//:ld".format(compiler),
    ],
)

filegroup(
    name = "ar_files",
    srcs = [
        "arm-none-eabi-ar",
        "@{}//:ar".format(compiler),
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "arm-none-eabi-objcopy",
        "@{}//:objcopy".format(compiler),
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "arm-none-eabi-strip",
        "@{}//:strip".format(compiler),
    ],
)
