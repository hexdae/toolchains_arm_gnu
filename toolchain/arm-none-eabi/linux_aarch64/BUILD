# toolchains/arm-none-eabi/linux/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain")
load("@arm_none_eabi//toolchain:config.bzl", "cc_arm_none_eabi_config")

package(default_visibility = ["//visibility:public"])

compiler = "arm_none_eabi_linux_aarch64"

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

cc_arm_none_eabi_config(
    name = "config",
    gcc_repo = compiler,
    gcc_version = "9.2.1",
    host_system_name = "x86-darwin",
    toolchain_identifier = "arm_none_eabi_linux_x86_64",
    wrapper_path = "arm-none-eabi/linux",
)
