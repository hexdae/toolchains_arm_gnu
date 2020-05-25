# Bazel arm-none-eabi toolchain

This is an example project to illustrate the blog post [Bazel for ARM embedded toolchains](https://d-asnaghi.github.io/blog/post/embedded-bazel/).

## Goal

This repository can be used as a template to include a custom toolchain to use with Bazel.

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