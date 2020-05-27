# Bazel arm-none-eabi toolchain

This is an example project to illustrate the blog post [Bazel for ARM embedded toolchains](https://d-asnaghi.github.io/blog/post/embedded-bazel/).

The goal of the project is to illustrate how to use a custom ARM embedded toolchain with Bazel.

## Instruction

### Bazelisk

`bazelisk` is a user-friendly launcher for `bazel`. Follow the install instructions in the [Bazelisk repo](https://github.com/bazelbuild/bazelisk)

### Usage

Use `bazelisk` as you would use `bazel`, this takes care of using the correct Bazel version for each project by using the [.bazelversion](./.bazelversion) file contained in each project.

  
### Testing

Use the command:

```bash
# build the project
bazelisk build project
```

to download the custom compiler for your OS and build the `project` target.

## Folder structure

```bash
├── WORKSPACE
│
├── project
│   ├── BUILD.bazel
│   └── /* SOURCE CODE */
│
└── toolchains
    ├── BUILD.bazel
    └── arm-none-eabi
        ├── darwin
        │   └── /* DARWIN TOOLCHAIN */
        ├── linux
        │   └── /* LINUX TOOLCHAIN  */
        └── ...
            └── /* OTHER TOOLCHAIN  */

```