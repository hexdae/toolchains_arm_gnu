def _toolchain_transition_impl(settings, attr):
    return {
        "//command_line_option:extra_toolchains": [attr.toolchain],
        "//command_line_option:platforms": [attr.platform],
    }

_toolchain_transition = transition(
    implementation = _toolchain_transition_impl,
    inputs = [],
    outputs = [
        "//command_line_option:extra_toolchains",
        "//command_line_option:platforms",
    ],
)

def _toolchain_transition_library_impl(ctx):
    to_list = lambda x: [x] if x else []

    default_info = ctx.attr.src[DefaultInfo]
    cc_info =  ctx.attr.src[CcInfo]

    linker_input_files = []

    # We need to recreate default_info since not all files are propagated with
    # the transition. Specifically, the following are known to not propagate:
    # * additional_linker_inputs (e.g. linker scripts)
    # * deps (i.e. other libraries this one depends on)
    for linker_input in cc_info.linking_context.linker_inputs.to_list():
        linker_input_files.extend(linker_input.additional_inputs)

        for lib in linker_input.libraries:
            linker_input_files.extend(to_list(lib.static_library))
            # I'm not sure if these below are needed
            linker_input_files.extend(to_list(lib.pic_static_library))
            linker_input_files.extend(to_list(lib.dynamic_library))

    return [
        DefaultInfo(
            files = depset(
                transitive = [
                    default_info.files,
                    depset(linker_input_files),
                ],
            ),
        ),
        cc_info,
    ]

toolchain_transition_library = rule(
    implementation = _toolchain_transition_library_impl,
    cfg = _toolchain_transition,
    attrs = {
        "src": attr.label(
            mandatory = True,
            providers = [CcInfo],
            doc = "Library built by the bootstrap toolchain",
        ),
        "toolchain": attr.label(
            mandatory = True,
            doc = "The toolchain to transition to",
        ),
        "platform": attr.label(
            mandatory = True,
            doc = "The platform to transition to",
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
)

def _toolchain_transition_filegroup_impl(ctx):
    files = []
    runfiles = ctx.runfiles()
    for src in ctx.attr.srcs:
        files.append(src[DefaultInfo].files)

    runfiles = runfiles.merge_all([
        src[DefaultInfo].default_runfiles
        for src in ctx.attr.srcs
    ])
    return [DefaultInfo(
        files = depset(transitive = files),
        runfiles = runfiles,
    )]

toolchain_transition_filegroup = rule(
    implementation = _toolchain_transition_filegroup_impl,
    cfg = _toolchain_transition,
    attrs = {
        "srcs": attr.label_list(
            allow_empty = False,
            mandatory = True,
            providers = [DefaultInfo],
            doc = "The input to be transitioned to the target platform with the specified toolchain.",
        ),
        "toolchain": attr.label(
            mandatory = True,
            doc = "The toolchain to transition to",
        ),
        "platform": attr.label(
            mandatory = True,
            doc = "The platform to transition to",
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
)
