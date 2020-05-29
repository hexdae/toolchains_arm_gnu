# toolchains/arm-none-eabi/windows/compiler.BUILD

package(default_visibility = ['//visibility:public'])

filegroup(
    name = "gcc",
    srcs = [
        "bin/arm-none-eabi-gcc.exe",
    ],
)

filegroup(
    name = "ar",
    srcs = [
        "bin/arm-none-eabi-ar.exe",
    ],
)

filegroup(
    name = "ld",
    srcs = [
        "bin/arm-none-eabi-ld.exe",
    ],
)

filegroup(
    name = "nm",
    srcs = [
        "bin/arm-none-eabi-nm.exe",
    ],
)

filegroup(
    name = "objcopy",
    srcs = [
        "bin/arm-none-eabi-objcopy.exe",
    ],
)

filegroup(
    name = "objdump",
    srcs = [
        "bin/arm-none-eabi-objdump.exe",
    ],
)

filegroup(
    name = "strip",
    srcs = [
        "bin/arm-none-eabi-strip",
    ],
)

filegroup(
    name = "as",
    srcs = [
        "bin/arm-none-eabi-as",
    ],
)

filegroup(
    name = "size",
    srcs = [
        "bin/arm-none-eabi-size",
    ],
)

filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "arm-none-eabi/**",
        "lib/gcc/arm-none-eabi/**",
    ]),
)

filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":gcc",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)