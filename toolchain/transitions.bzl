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
    return [
        ctx.attr.src[DefaultInfo],
        ctx.attr.src[CcInfo],
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
