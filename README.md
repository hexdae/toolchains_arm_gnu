<p align="center">

<a href="https://github.com/d-asnaghi/bazel-arm-none-eabi/blob/master/LICENSE">
    <img alt="GitHub license" src="https://img.shields.io/github/license/d-asnaghi/bazel-arm-none-eabi?color=success">
</a>

<a href="https://github.com/d-asnaghi/bazel-arm-none-eabi/stargazers">
    <img alt="GitHub stars" src="https://img.shields.io/github/stars/d-asnaghi/bazel-arm-none-eabi?color=success">
</a>

<a href="https://github.com/d-asnaghi/bazel-arm-none-eabi/issues">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/d-asnaghi/bazel-arm-none-eabi">
</a>

<a href="https://github.com/d-asnaghi/bazel-arm-none-eabi/actions">
    <img alt="CI" src="https://github.com/hexdae/bazel-arm-none-eabi/actions/workflows/ci.yml/badge.svg">
</a>

</p>

<p align="center">

<img src="https://asnaghi.me/images/bazel-arm.png" width="400px"/>

</p>

The goal of the project is to make arm cross compilation toolchains readily
available (and customizable) for bazel developers.

If this project was useful to you, give it a ⭐️ and I'll keep improving it!

You might also like another, similar, toolchain project for `bazel`
[RISCV toolchains](https://github.com/hexdae/bazel-riscv-none-elf)

## Features

- [MODULE support](#bzlmod)
- [WORKSPACE support](#workspace)
- [Direct access to gcc tools](#direct-access-to-gcc-tools)
- [Custom toolchain support](#custom-toolchain)
- [Use a specific GCC version](./examples/gcc_version)
- [Examples](./examples)
- Remote execution support
- Linux, MacOS, Windows

## Use the toolchain from this repo

## .bazelrc

And this to your `.bazelrc`

```bash
# .bazelrc

# Build using platforms by default
build --incompatible_enable_cc_toolchain_resolution
```

## Bzlmod

```python
bazel_dep(name = "toolchains_arm_gnu", version = "<version>")

arm_toolchain = use_extension("@toolchains_arm_gnu//:extensions.bzl", "arm_toolchain")

arm_toolchain.arm_none_eabi()
use_repo(arm_toolchain, "arm_none_eabi")
register_toolchains("@arm_none_eabi//toolchain:all")

arm_toolchain.arm_none_linux_gnueabihf()
use_repo(arm_toolchain)
register_toolchains("@arm_none_linux_gnueabihf//toolchain:all")
```

## WORKSPACE

Add this git repository to your WORKSPACE to use the compiler (NOTE: WORSKPACE
setups will become obsolete soon, do not use for new projects)

<details>

<summary>
WORKSPACE
</summary>

```python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_cc",
    remote = "https://github.com/bazelbuild/rules_cc",
    branch = "main",
)

git_repository(
    name = "arm_none_eabi",
    remote = "https://github.com/hexdae/bazel-arm-none-eabi",
    branch = "master",
)

load("@toolchains_arm_gnu//:deps.bzl", "arm_none_eabi_deps", "arm_none_linux_gnueabihf_deps")

arm_none_eabi_deps()
register_toolchains("@arm_none_eabi//toolchain:all")

arm_none_linux_gnueabihf_deps()
register_toolchains("@arm_none_linux_gnueabihf//toolchain:all")
```

</details>

## Custom toolchain

If you want to bake certain compiler flags in to your toolchain, you can define a custom toolchain in your repo.

In a BUILD file:

```python
# path/to/toolchains/BUILD

load("@arm_none_eabi//toolchain:toolchain.bzl", "arm_none_eabi_toolchain")
arm_none_eabi_toolchain(
    name = "custom_toolchain",
    target_compatible_with = [
        "<your additional constraints>",
    ],
    copts = [
        "<your additional copts>",
    ],
    linkopts = [
        "<your additional linkopts>",
    ],
)
```

And in your WORKSPACE / MODULE file:

```python
register_toolchains("@//path/to/toolchains:all")
```

Be careful about registering the default toolchains when using a custom one

## Direct access to gcc tools

If you need direct access to `gcc` tools, they are available as `@arm_none_eabi//:<tool>`. For example, the following `genrules` could be used to produce `.bin` and `.hex` artifacts from a generic `.out` target.

```python

cc_binary(
    name = "target.out"
    srcs = [...],
    deps = [...],
    copts = [...],
    ...
)

genrule(
    name = "bin",
    srcs = [":target.out"],
    outs = ["target.bin"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O binary $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
)

genrule(
    name = "hex",
    srcs = [":target.out"],
    outs = ["target.hex"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
)
```

## Remote execution

This toolchain is compatible with remote execution

## Building with the ARM Linux toolchain on Windows

The Windows maximum path length limitation may cause build failures with the
`arm-none-linux-gnueabihf` toolchain. In some cases, it's enough to avoid this
by setting a shorter output directory. Add this to your `.bazelrc` file:

```
startup --output_user_root=C:/tmp
```

See [avoid long path issues][1] for more information.

[1]: https://bazel.build/configure/windows#long-path-issues
