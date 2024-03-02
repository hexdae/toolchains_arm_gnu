load("@arm_gnu_toolchain//:deps.bzl", "arm_none_eabi_deps")

def _arm_gnu_impl(ctx):
    for mod in ctx.modules:
        if mod.name == "arm_gnu_toolchain":
            for attr in mod.tags.toolchain:
                arm_none_eabi_deps(attr.version)

_toolchain = tag_class(attrs = {
    "version": attr.string(),
})

arm_gnu = module_extension(
    implementation = _arm_gnu_impl,
    tag_classes = {
        "toolchain": _toolchain,
    },
)
