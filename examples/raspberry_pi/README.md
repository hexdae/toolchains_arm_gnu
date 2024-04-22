# Cross compile raspberry pi example

Bazel adaptation of [`raspi3-tutorial`](https://github.com/bztsrc/raspi3-tutorial)
as an example on how to cross compile for bare metal raspberry pi using bazel.

We will focus on compiling the [hello world](https://github.com/bztsrc/raspi3-tutorial/tree/master/03_uart1) example and running it on QEMU

## Running on QEMU

Install quemu on your system and run the following command:

```bash
bazel run src:kernel --run_under="qemu-system-aarch64 -m 1G -M raspi3b -serial null -serial mon:stdio -nographic -kernel"
```
