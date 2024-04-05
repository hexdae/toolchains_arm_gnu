"""
This BUILD file is used to alias host toolchains in the generated repo, allowing
users to register a custom toolchain without having to import the host repo
"""

HOST = "%repo%"
TOOLS = %tools%

[
    alias(
        name = name,
        actual = "@{repo}//:{name}".format(repo=HOST, name=name),
        visibility = ["//visibility:public"],
    )
    for name in TOOLS + [
        "include_path",
        "library_path",
        "compiler_pieces",
        "compiler_files",
        "ar_files",
        "linker_files",
        "compiler_components",
    ]
]
