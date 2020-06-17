![Linux](https://github.com/d-asnaghi/bazel-arm-none-eabi/workflows/Linux/badge.svg)
![macOS](https://github.com/d-asnaghi/bazel-arm-none-eabi/workflows/macOS/badge.svg)
![Windows](https://github.com/d-asnaghi/bazel-arm-none-eabi/workflows/Windows/badge.svg)

# Bazel arm-none-eabi-gcc toolchain

<p align="center">
    <img src="https://asnaghi.me/images/bazel-arm.png" width="400px"/>
</p>

The goal of the project is to illustrate how to use a custom arm-none-eabi embedded toolchain with Bazel.

If this project was useful to you, give it a ⭐️ and I'll keep improving it!

You can follow the post [Bazel for ARM embedded toolchains](https://d-asnaghi.github.io/blog/post/embedded-bazel/) to get more details about this code.

## Use the toolchain from this repo

To get started with the arm none eabi embedded toolchain, copy the appropriate `WORKSPACE` setup
from the [releases](https://github.com/d-asnaghi/bazel-arm-none-eabi/releases) page. For example:

```python
# WORKSPACE

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "arm_none_eabi",
    url = "https://github.com/d-asnaghi/bazel-arm-none-eabi/archive/<VERSION>.tar.gz",
    sha256 = "<SHA256>",
    strip_prefix = "bazel-arm-none-eabi-1.0"
)

load("@arm_none_eabi//:deps.bzl", "arm_none_eabi_deps")
arm_none_eabi_deps()
```

And this to your `.bazelrc `
```bash
# .bazelrc

# Build using platforms by default
build --incompatible_enable_cc_toolchain_resolution
build --platforms=@arm_none_eabi//platforms:arm_none_generic
```

If for you are using Bazel rules that do not support platforms, you can also use this instead
```bash
# .bazelrc

# Use the legacy crosstool-top config
build:legacy --crosstool_top=@arm_none_eabi//toolchain
build:legacy --host_crosstool_top=@bazel_tools//tools/cpp:toolchain
```

Now Bazel will automatically use `arm-none-eabi-gcc` as a compiler

## Platforms

By default, this repo defines the `arm-none-eabi-generic` platform as:
```python
platform(
    name = "arm_none_generic",
    constraint_values = [
        "@platforms//os:none",
        "@platforms//cpu:arm",
    ],
)
```

If you want to further differentiate your project's platforms (for example to support a certain board/cpu) you can extend it using this template:

```python
platform(
    name = "your_custom_platform",
    constraint_values = [
        "<your additional constraints>",
    ],
    parents = [
        "@arm_none_eabi//platforms:arm_none_generic"
    ],
)
```

## Configurable build attributes

If you want to select some build attributes based on their compatibility with the arm-none-eabi-gcc toolchain, you can use the `config_settings` available at `@arm_none_eabi//config:arm_none_compatible`, defined as:

```python
config_setting(
    name = "arm_none_compatible",
    constraint_values = [
        "@platforms//cpu:arm",
        "@platforms//os:none",
    ],
)
```

You can always add onto this `config_setting` by creating your own `config_setting_group` that inherits from this one:

```python
load("@bazel_skylib//lib:selects.bzl", "selects")

config_setting()
    name = "your_config_setting",
    ...
)

selects.config_setting_group(
    name = "your_config_setting_group",
    match_all = [
        "@arm_none_eabi//config:arm_none_compatible",
        ":your_config_setting"
    ],
)
```

and then use these definitions to `select` in rules

```python
filegroup(
    name = "arm_none_srcs",
    srcs = [...],
)

cc_binary(
    name = "your_binary",
    srcs = select({
        "@arm_none_eabi//config:arm_none_compatible": [":arm_none_srcs"],
        ...
    })
)
```

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

## Integrate the toolchain into your project

Follow these steps if you want to test this repo before using it to integrate
the toolchain into your local project.

### Bazel

[Install Bazel](https://docs.bazel.build/versions/master/install.html) for your platform. Installing with a package manager is recommended, especially on windows where additional runtime components are needed.

- [Ubuntu Linux](https://docs.bazel.build/versions/master/install-ubuntu.html): `sudo apt install bazel`
- [macOS](https://docs.bazel.build/versions/master/install-os-x.html): `brew install bazel`
- [Windows](https://docs.bazel.build/versions/master/install-windows.html): `choco install bazel`

### Bazelisk

`bazelisk` is a user-friendly launcher for `bazel`. Follow the install instructions in the [Bazelisk repo](https://github.com/bazelbuild/bazelisk)

Use `bazelisk` as you would use `bazel`, this takes care of using the correct Bazel version for each project by using the [.bazelversion](./.bazelversion) file contained in each project.

### Clone the repo

```bash
git clone https://github.com/d-asnaghi/bazel-arm-none-eabi.git
```

### Build

Use this command to build any `project` target (a mock example is provided).

```bash
# build the project
bazelisk build project
```

This will take care of downloading the appropriate toolchain for your OS and compile all the source files specified by the target.

## Folder structure

```bash
├── WORKSPACE
│
├── project
│   ├── BUILD.bazel
│   └── /* SOURCE CODE */
│
└── toolchain
    ├── BUILD.bazel
    ├── compiler.BUILD
    ├── config.bzl
    └── arm-none-eabi
        ├── darwin
        │   └── /* DARWIN TOOLCHAIN   */
        ├── linux
        │   └── /* LINUX TOOLCHAIN    */
        ├── windows
        │   └── /* WINDOWS TOOLCHAIN  */
        └── ...
            └── /* OTHER TOOLCHAIN    */

```
