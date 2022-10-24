# toolchains/arm-none-eabi/darwin/config.bzl

load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")

def wrapper_path(ctx, tool):
    wrapped_path = "{}/arm-none-eabi-{}{}".format(ctx.attr.wrapper_path, tool, ctx.attr.wrapper_ext)
    return tool_path(name = tool, path = wrapped_path)

def _impl(ctx):
    tool_paths = [
        wrapper_path(ctx, "gcc"),
        wrapper_path(ctx, "ld"),
        wrapper_path(ctx, "ar"),
        wrapper_path(ctx, "cpp"),
        wrapper_path(ctx, "gcov"),
        wrapper_path(ctx, "nm"),
        wrapper_path(ctx, "objdump"),
        wrapper_path(ctx, "strip"),
    ]

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
                    flag_group(flags = include_flags),
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
        tool_paths = tool_paths,
        features = [
            toolchain_compiler_flags,
            toolchain_linker_flags,
        ],
    )

cc_arm_none_eabi_config = rule(
    implementation = _impl,
    attrs = {
        "toolchain_identifier": attr.string(default = ""),
        "host_system_name": attr.string(default = ""),
        "wrapper_path": attr.string(default = ""),
        "wrapper_ext": attr.string(default = ""),
        "gcc_repo": attr.string(default = ""),
        "gcc_version": attr.string(default = ""),
    },
    provides = [CcToolchainConfigInfo],
)
