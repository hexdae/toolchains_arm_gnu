# toolchains/arm-none-eabi/windows/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain")
load("@arm_none_eabi//toolchain:config.bzl", "cc_arm_none_eabi_config")

package(default_visibility = ["//visibility:public"])

compiler = "arm_none_eabi_windows_x86_32"

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
        "arm-none-eabi-gcc.bat",
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "arm-none-eabi-gcc.bat",
        "arm-none-eabi-ld.bat",
        "@{}//:ar".format(compiler),
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
        "@{}//:ld".format(compiler),
    ],
)

filegroup(
    name = "ar_files",
    srcs = [
        "arm-none-eabi-ar.bat",
        "@{}//:ar".format(compiler),
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "arm-none-eabi-objcopy.bat",
        "@{}//:objcopy".format(compiler),
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "arm-none-eabi-strip.bat",
        "@{}//:strip".format(compiler),
    ],
)

cc_arm_none_eabi_config(
    name = "config",
    gcc_repo = compiler,
    gcc_version = "9.2.1",
    host_system_name = "x86-windows",
    toolchain_identifier = "arm_none_eabi_windows_x86_32",
    wrapper_ext = ".bat",
    wrapper_path = "arm-none-eabi/windows",
)
