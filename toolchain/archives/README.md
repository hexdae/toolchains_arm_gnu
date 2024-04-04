# ARM GNU archives

Publicly hosted archives

## Automatic generation

The toolchains can be autogenerated from github for convenience

```bash
bazel run //toolchain/archives:generate --toolchain <prefix>
```

For example to generate `arm-none-eabi` releases

```bash
bazel run //toolchain/archives:generate -- --toolchain=arm-none-eabi --releases=3 >> toolchain/archives/arm_none_eabi.bzl
```