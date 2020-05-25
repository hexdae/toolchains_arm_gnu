# toolchains/arm-none-eabi/darwin/config.bzl

load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")

ARM_NONE_EABI_PATH = "external/arm-none-eabi-darwin"
ARM_NONE_EABI_VERSION = "9.2.1"

def wrapper_path(tool):
    return "arm-none-eabi/darwin/arm-none-eabi-{}".format(tool)

def _impl(ctx):
    tool_paths = [
        tool_path(name = "gcc", path = wrapper_path("gcc")),
        tool_path(name = "ld", path = wrapper_path("ld")),
        tool_path(name = "ar", path = wrapper_path("ar")),
        tool_path(name = "cpp", path = wrapper_path("cpp")),
        tool_path(name = "gcov", path = wrapper_path("gcov")),
        tool_path(name = "nm", path = wrapper_path("nm")),
        tool_path(name = "objdump", path = wrapper_path("objdump")),
        tool_path(name = "strip", path = wrapper_path("strip")),
    ]

    toolchain_include_directories_feature = feature(
        name = "toolchain_include_directories",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags =
                            [
                                "-isystem",
                                "{}/arm-none-eabi/include".format(ARM_NONE_EABI_PATH),
                                "-isystem",
                                "{}/lib/gcc/arm-none-eabi/{}/include".format(ARM_NONE_EABI_PATH, ARM_NONE_EABI_VERSION),
                            ],
                    ),
                ],
            ),
        ],
    )

    toolchain_linker_libraries_feature = feature(
        name = "toolchain_linker_libraries",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.linkstamp_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags =
                            [
                                "-L",
                                "{}/arm-none-eabi/lib".format(ARM_NONE_EABI_PATH),
                                "-llibc.a",
                                "-L",
                                "{}/lib/gcc/arm-none-eabi/{}".format(ARM_NONE_EABI_PATH, ARM_NONE_EABI_VERSION),
                                "-llibgcc.a",
                            ],
                    ),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "arm-none-eabi-darwin",
        host_system_name = "i686-unknown-linux-gnu",
        target_system_name = "arm-none-eabi",
        target_cpu = "arm-none-eabi",
        target_libc = "unknown",
        compiler = "arm-none-eabi",
        abi_version = "eabi",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        features = [
            toolchain_include_directories_feature,
            toolchain_linker_libraries_feature,
        ],
    )

cc_arm_none_eabi_darwin_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
