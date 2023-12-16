# toolchains/compiler.BUILD

package(default_visibility = ["//visibility:public"])

# export the executable files to make them available for direct use.
exports_files(glob(["**"], exclude_directories=0))

# gcc executables.
filegroup(
    name = "gcc",
    srcs = ["bin/arm-none-eabi-gcc"],
)

# cpp executables.
filegroup(
    name = "cpp",
    srcs = ["bin/arm-none-eabi-cpp"],
)

# gcov executables.
filegroup(
    name = "gcov",
    srcs = ["bin/arm-none-eabi-gcov"],
)

# gdb executables.
filegroup(
    name = "gdb",
    srcs = ["bin/arm-none-eabi-gdb"],
)

# ar executables.
filegroup(
    name = "ar",
    srcs = ["bin/arm-none-eabi-ar"],
)

# ld executables.
filegroup(
    name = "ld",
    srcs = ["bin/arm-none-eabi-ld"],
)

# nm executables.
filegroup(
    name = "nm",
    srcs = ["bin/arm-none-eabi-nm"],
)

# objcopy executables.
filegroup(
    name = "objcopy",
    srcs = ["bin/arm-none-eabi-objcopy"],
)

# objdump executables.
filegroup(
    name = "objdump",
    srcs = ["bin/arm-none-eabi-objdump"],
)

# strip executables.
filegroup(
    name = "strip",
    srcs = ["bin/arm-none-eabi-strip"],
)

# as executables.
filegroup(
    name = "as",
    srcs = ["bin/arm-none-eabi-as"],
)

# readelf executables.
filegroup(
    name = "readelf",
    srcs = ["bin/arm-none-eabi-readelf"],
)

# size executables.
filegroup(
    name = "size",
    srcs = ["bin/arm-none-eabi-size"],
)

# libraries and headers.
filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "libexec/**",
        "arm-none-eabi/**",
        "lib/**",
        "lib/gcc/arm-none-eabi/**",
    ]),
)

filegroup(
    name = "ar_files",
    srcs = [
        ":ar",
        ":compiler_pieces",
        ":gcc",
    ],
)

# files for executing compiler.
filegroup(
    name = "compiler_files",
    srcs = [
        ":compiler_pieces",
        ":cpp",
        ":gcc",
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        ":ar",
        ":compiler_pieces",
        ":gcc",
        ":ld",
    ],
)

# collection of executables.
filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":compiler_pieces",
        ":cpp",
        ":gcc",
        ":gcov",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)
