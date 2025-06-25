def _toolchain_transition_impl(settings, attr):
    return {
        "//command_line_option:extra_toolchains": [attr.toolchain],
        "//command_line_option:platforms": [attr.platform],
    }

toolchain_transition = transition(
    implementation = _toolchain_transition_impl,
    inputs = [],
    outputs = [
        "//command_line_option:extra_toolchains",
        "//command_line_option:platforms",
    ],
)

def _toolchain_transition_library_impl(ctx):
    return [
        ctx.attr.src[0][DefaultInfo],
        ctx.attr.src[0][CcInfo],
    ]

toolchain_transition_library = rule(
    implementation = _toolchain_transition_library_impl,
    attrs = {
        "src": attr.label(
            mandatory = True,
            cfg = toolchain_transition,
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
