"""
This BUILD file marks the top of the host-specific cross-toolchain repository.
If the host needs @arm_none_eabi_linux_x86_64, this is the build file at the
top of that repository.
"""
package(default_visibility = ["//visibility:public"])

# export the executable files to make them available for direct use.
exports_files(glob(["**"], exclude_directories = 0))

PREFIX = "%toolchain_prefix%"
VERSION = "%version%"
TOOLS = %tools%

# executables.
[
    filegroup(
        name = tool,
        srcs = ["bin/{}-{}%bin_extension%".format(PREFIX, tool)],
    )
    for tool in TOOLS
]

filegroup(
    name = "include_path",
    srcs = [
      "{}/include".format(PREFIX),
      "lib/gcc/{}/{}/include".format(PREFIX, VERSION),
      "lib/gcc/{}/{}/include-fixed".format(PREFIX, VERSION),
      "{}/include/c++/{}".format(PREFIX, VERSION),
      "{}/include/c++/{}/{}".format(PREFIX, VERSION, PREFIX),
    ],
)

# Just the components to add to the library path.
filegroup(
    name = "library_path",
    srcs = [
      PREFIX,
      "{}/lib".format(PREFIX),
    ] + glob(["lib/gcc/{}/*".format(PREFIX)]),
)

# libraries, headers and executables.
filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "bin/**",
        "libexec/**",
        "{}/**".format(PREFIX),
        "lib/**",
        "lib/gcc/{}/**".format(PREFIX),
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
