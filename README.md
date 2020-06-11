![Linux](https://github.com/d-asnaghi/bazel-arm-none-eabi/workflows/Linux/badge.svg)
![macOS](https://github.com/d-asnaghi/bazel-arm-none-eabi/workflows/macOS/badge.svg)
![Windows](https://github.com/d-asnaghi/bazel-arm-none-eabi/workflows/Windows/badge.svg)

# Bazel arm-none-eabi-gcc toolchain

The goal of the project is to illustrate how to use a custom ARM embedded toolchain with Bazel.

If this project was useful to you, give it a ⭐️ and I'll keep improving it!

You can follow the post [Bazel for ARM embedded toolchains](https://d-asnaghi.github.io/blog/post/embedded-bazel/) to get more details about this code.

## Use the toolchain from this repo

To get started with the arm none eabi embedded toolchain,
just add the following to your `WORKSPACE` file

```python
# WORKSPACE

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
git_repository(
    name = "arm_none_eabi",
    remote = "https://github.com/d-asnaghi/bazel-arm-none-eabi.git",
    branch = "master",                  # For the latest version.
    # commit = "<choose a commit>",     # For canonical builds.
)

load("@arm_none_eabi//:deps.bzl", "arm_none_eabi_deps")
arm_none_eabi_deps()
```

And this to your `.bazelrc `
```bash
# .bazelrc

# Build using platforms by default
build --incompatible_enable_cc_toolchain_resolution
build --platforms=@arm_none_eabi//platforms:arm_none_eabi_generic
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
    name = "arm_none_eabi_generic",
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
        "@arm_none_eabi//platforms:arm_none_eabi_generic"
    ],
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
    └── arm-none-eabi
        ├── darwin
        │   └── /* DARWIN TOOLCHAIN */
        ├── linux
        │   └── /* LINUX TOOLCHAIN  */
        └── ...
            └── /* OTHER TOOLCHAIN  */

```