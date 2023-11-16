load("@bazel_skylib//rules:native_binary.bzl", "native_binary")

native_binary(
    name = "gdb",
    src = "@arm_none_eabi//:gdb",
    out = "gdb",
    visibility = ["//visibility:public"],
)

native_binary(
    name = "readelf",
    src = "@arm_none_eabi//:readelf",
    out = "gdb",
    visibility = ["//visibility:public"],
)
