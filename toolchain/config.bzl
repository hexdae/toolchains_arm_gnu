# toolchains/arm-none-eabi/darwin/config.bzl

load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "action_config", "feature", "flag_group", "flag_set", "tool_path")

def _tool_path(files, tool_name):
    for file in files:
        if file.basename.startswith("arm-none-eabi-{}".format(tool_name)):
            return file

    return None

def _action_configs(tools):
    compile = action_config(
        action_name = ACTION_NAMES.c_compile,
        tools = [
            struct(
                type_name = "tool",
                tool = tools["gcc"],
            ),
        ],
    )

    link = action_config(
        action_name = ACTION_NAMES.cpp_link_executable,
        tools = [
            struct(
                type_name = "tool",
                tool = tools["ld"],
            ),
        ],
    )

    ar = action_config(
        action_name = ACTION_NAMES.cpp_link_static_library,
        tools = [
            struct(
                type_name = "tool",
                tool = tools["ar"],
            ),
        ],
        implies = [
            "archiver_flags",
        ],
    )

    strip = action_config(
        action_name = ACTION_NAMES.strip,
        tools = [
            struct(
                type_name = "tool",
                tool = tools["strip"],
            ),
        ],
    )

    return [compile, link, ar, strip]

def _impl(ctx):
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

    toolchain_compile_flag_set = flag_set(
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
    )

    toolchain_compiler_flags = feature(
        name = "compiler_flags",
        enabled = True,
        flag_sets = [
            toolchain_compile_flag_set,
        ],
    )

    toolchain_linker_flag_set = flag_set(
        actions = [
            ACTION_NAMES.linkstamp_compile,
            # ACTION_NAMES.cpp_link_static_library,
        ],
        flag_groups = [
            flag_group(flags = linker_flags + ctx.attr.linkopts),
        ],
    )

    toolchain_linker_flags = feature(
        name = "linker_flags",
        enabled = True,
        flag_sets = [
            toolchain_linker_flag_set,
        ],
    )

    tools = {
        x: _tool_path(ctx.files.toolchain_bin, x)
        for x in ["ar", "gcc", "ld", "strip"]
    }

    print(tools)
    print(_action_configs(tools))

    return [
        cc_common.create_cc_toolchain_config_info(
            ctx = ctx,
            toolchain_identifier = ctx.attr.toolchain_identifier,
            host_system_name = ctx.attr.host_system_name,
            target_system_name = "arm-none-eabi",
            target_cpu = "arm-none-eabi",
            target_libc = "gcc",
            compiler = ctx.attr.gcc_repo,
            abi_version = "eabi",
            abi_libc_version = ctx.attr.gcc_version,
            # tool_paths = tool_paths,
            action_configs = _action_configs(tools),
            features = [
                toolchain_compiler_flags,
                toolchain_linker_flags,
            ],
        ),
        DefaultInfo(files = depset([ctx.file.wrappers])),
    ]

cc_arm_none_eabi_config = rule(
    implementation = _impl,
    attrs = {
        "toolchain_identifier": attr.string(default = ""),
        "host_system_name": attr.string(default = ""),
        "wrapper_path": attr.string(default = ""),
        "wrapper_ext": attr.string(default = ""),
        "gcc_repo": attr.string(default = ""),
        "gcc_version": attr.string(default = ""),
        "copts": attr.string_list(default = []),
        "linkopts": attr.string_list(default = []),
        "wrappers": attr.label(mandatory = True, allow_single_file = True),
        "gcc": attr.label(mandatory = True, allow_single_file = True),
        "ar": attr.label(mandatory = True, allow_single_file = True),
        "toolchain_bin": attr.label(mandatory = True, allow_files = True),
    },
    provides = [CcToolchainConfigInfo],
)
