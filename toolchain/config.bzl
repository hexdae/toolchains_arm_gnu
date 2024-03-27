load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@rules_cc//cc:cc_toolchain_config_lib.bzl", "action_config", "feature", "flag_group", "flag_set")

def _tool_path(bins, toolchain_prefix, tool_name):
    """Generate tool paths for GCC"""
    for file in bins:
        if file.basename.startswith("{}-{}".format(toolchain_prefix, tool_name)):
            return file
    return None

def _action_configs(ctx, action_names, tool_name, implies = []):
    """Generate action configs"""
    return [
        action_config(
            action_name = action_name,
            tools = [
                struct(
                    type_name = "tool",
                    tool = _tool_path(ctx.files.toolchain_bins, ctx.attr.toolchain_prefix, tool_name),
                ),
            ],
            implies = implies,
        )
        for action_name in action_names
    ]

def _default_compiler_flags(ctx):
    """Default compiler flags for GCC bazel toolchains"""
    compiler_flags = [
        "-fno-canonical-system-headers",
        "-no-canonical-prefixes",
    ]

    if not ctx.attr.include_std:
        compiler_flags.append("-nostdinc")
        if ctx.attr.gcc_tool == "g++":
            compiler_flags.append("-nostdinc++")

    return compiler_flags

def _default_linker_flags(_ctx):
    """Default linker flags for GCC bazel toolchains"""
    return [
        "-no-canonical-prefixes",
    ]

def _impl(ctx):
    default_compiler_flags = _default_compiler_flags(ctx)
    default_linker_flags = _default_linker_flags(ctx)
    action_configs = []

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
            ACTION_NAMES.cpp_compile,
            ACTION_NAMES.cpp_header_parsing,
        ],
        ctx.attr.gcc_tool,
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
                    flag_group(flags = ["-I" + include.path for include in ctx.files.include_path]),
                    flag_group(flags = ctx.attr.copts + default_compiler_flags),
                ],
            ),
        ],
    )

    toolchain_linker_flags = feature(
        name = "linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.linkstamp_compile],
                flag_groups = [
                    flag_group(flags = ["-L" + include.path for include in ctx.files.library_path]),
                ],
            ),
        ],
    )

    custom_linkopts = feature(
        name = "custom_linkopts",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.cpp_link_executable],
                flag_groups = [
                    flag_group(flags = ctx.attr.linkopts + default_linker_flags),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = ctx.attr.toolchain_identifier,
        host_system_name = ctx.attr.host_system_name,
        target_system_name = ctx.attr.toolchain_prefix,
        target_cpu = ctx.attr.toolchain_prefix,
        target_libc = "gcc",
        compiler = ctx.attr.gcc_repo,
        abi_version = ctx.attr.abi_version,
        abi_libc_version = ctx.attr.gcc_version,
        action_configs = action_configs,
        features = [
            toolchain_compiler_flags,
            toolchain_linker_flags,
            custom_linkopts,
        ],
    )

cc_arm_gnu_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "toolchain_identifier": attr.string(default = ""),
        "toolchain_prefix": attr.string(default = ""),
        "host_system_name": attr.string(default = ""),
        "toolchain_bins": attr.label(mandatory = True, allow_files = True),
        "gcc_repo": attr.string(default = ""),
        "gcc_version": attr.string(default = ""),
        "gcc_tool": attr.string(default = "gcc"),
        "abi_version": attr.string(default = ""),
        "copts": attr.string_list(default = []),
        "linkopts": attr.string_list(default = []),
        "include_path": attr.label_list(default = [], allow_files = True),
        "library_path": attr.label_list(default = [], allow_files = True),
        "include_std": attr.bool(default = False),
    },
    provides = [CcToolchainConfigInfo],
)
