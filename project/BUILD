# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "project",
    srcs = glob([
        "source/*.c",
        "source/*.cpp",
    ]),
    hdrs = glob(["includes/*.h"]),
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
        "-ffreestanding",
    ],
    includes = ["includes"],
)
