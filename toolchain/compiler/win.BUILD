load("@arm_none_eabi//toolchain:toolchain.bzl", "tools")

package(default_visibility = ["//visibility:public"])

# export the executable files to make them available for direct use.
exports_files(glob(["**"], exclude_directories = 0))

# executables.
[
    filegroup(
        name = tool,
        srcs = ["bin/arm-none-eabi-{}.exe".format(tool)],
    )
    for tool in tools
]

# libraries and headers.
filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "bin/**",
        "libexec/**",
        "arm-none-eabi/**",
        "lib/**",
        "lib/gcc/arm-none-eabi/**",
    ]),
)

# files for executing compiler.
filegroup(
    name = "compiler_files",
    srcs =  [":compiler_pieces"],
)

filegroup(
    name = "ar_files",
    srcs = [":compiler_pieces"],
)

filegroup(
    name = "linker_files",
    srcs = [":compiler_pieces"],
)

# collection of executables.
filegroup(
    name = "compiler_components",
    srcs =  [":compiler_pieces"],
)
