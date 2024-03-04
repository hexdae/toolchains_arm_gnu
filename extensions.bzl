load(
    "@arm_gnu_toolchain//:deps.bzl",
    "arm_none_eabi_deps",
)

def _arm_toolchain_impl(ctx):
    for mod in ctx.modules:
        if mod.name == "arm_gnu_toolchain":
            for attr in mod.tags.arm_none_eabi:
                arm_none_eabi_deps(attr.version)

_toolchain = tag_class(attrs = {
    "version": attr.string(),
})

arm_toolchain = module_extension(
    implementation = _arm_toolchain_impl,
    tag_classes = {
        "arm_none_eabi": _toolchain,
    },
)
