load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "action_config", "feature", "flag_group", "flag_set")

def _tool_path(bins, tool_name):
    for file in bins:
        if file.basename.startswith("arm-none-eabi-{}".format(tool_name)):
            return file

    return None

def _action_configs(ctx, action_names, tool_name, implies = []):
    return [
        action_config(
            action_name = action_name,
            tools = [
                struct(
                    type_name = "tool",
                    tool = _tool_path(ctx.files.toolchain_bins, tool_name),
                ),
            ],
            implies = implies,
        )
        for action_name in action_names
    ]

def _impl(ctx):
    action_configs = []

    # Action -> binary mappings from Pigweed:
    # https://github.com/google/pigweed/blob/aac7fab/pw_toolchain_bazel/cc_toolchain/private/cc_toolchain.bzl#L19

    action_configs += _action_configs(
        ctx,
        [
            ACTION_NAMES.assemble,
            ACTION_NAMES.preprocess_assemble,
            ACTION_NAMES.c_compile,
            ACTION_NAMES.cc_flags_make_variable,
            ACTION_NAMES.cpp_link_executable,
            ACTION_NAMES.cpp_link_dynamic_library,
            ACTION_NAMES.cpp_link_nodeps_dynamic_library,
        ],
        "gcc",
    )

    action_configs += _action_configs(
        ctx,
        [
            ACTION_NAMES.cpp_compile,
            ACTION_NAMES.cpp_header_parsing,
        ],
        "cpp",
    )

    action_configs += _action_configs(
        ctx,
        [ACTION_NAMES.cpp_link_static_library],
        "ar",
        implies = ["archiver_flags", "linker_param_file"],
    )

    action_configs += _action_configs(
        ctx,
        [ACTION_NAMES.llvm_cov],
        "gcov",
    )

    action_configs += _action_configs(
        ctx,
        [ACTION_NAMES.strip],
        "strip",
    )

    include_flags = [
        "-I",
        "external/{}/arm-none-eabi/include".format(ctx.attr.gcc_repo),
        "-I",
        "external/{}/lib/gcc/arm-none-eabi/{}/include".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-I",
        "external/{}/lib/gcc/arm-none-eabi/{}/include-fixed".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-I",
        "external/{}/arm-none-eabi/include/c++/{}/".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-I",
        "external/{}/arm-none-eabi/include/c++/{}/arm-none-eabi/".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
    ]

    linker_flags = [
        "-L",
        "external/{}/arm-none-eabi/lib".format(ctx.attr.gcc_repo),
        "-L",
        "external/{}/lib/gcc/arm-none-eabi/{}".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "-llibc.a",
        "-llibgcc.a",
    ]

    toolchain_compiler_flags = feature(
        name = "compiler_flags",
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
                    flag_group(flags = include_flags + ctx.attr.copts),
                ],
            ),
        ],
    )

    toolchain_linker_flags = feature(
        name = "linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.linkstamp_compile,
                ],
                flag_groups = [
                    flag_group(flags = linker_flags),
                ],
            ),
        ],
    )

    features = [toolchain_compiler_flags, toolchain_linker_flags]

    if (len(ctx.attr.linkopts)):
        custom_linkopts = feature(
            name = "custom_linkopts",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.cpp_link_executable,
                    ],
                    flag_groups = [
                        flag_group(flags = ctx.attr.linkopts),
                    ],
                ),
            ],
        )

        features.append(custom_linkopts)

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = ctx.attr.toolchain_identifier,
        host_system_name = ctx.attr.host_system_name,
        target_system_name = "arm-none-eabi",
        target_cpu = "arm-none-eabi",
        target_libc = "gcc",
        compiler = ctx.attr.gcc_repo,
        abi_version = "eabi",
        abi_libc_version = ctx.attr.gcc_version,
        action_configs = action_configs,
        features = features,
    )

cc_arm_none_eabi_config = rule(
    implementation = _impl,
    attrs = {
        "toolchain_identifier": attr.string(default = ""),
        "host_system_name": attr.string(default = ""),
        "toolchain_bins": attr.label(mandatory = True, allow_files = True),
        "gcc_repo": attr.string(default = ""),
        "gcc_version": attr.string(default = ""),
        "copts": attr.string_list(default = []),
        "linkopts": attr.string_list(default = []),
    },
    provides = [CcToolchainConfigInfo],
)
