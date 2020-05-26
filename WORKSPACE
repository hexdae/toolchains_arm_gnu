# WORKSPACE

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "arm-none-eabi-darwin",
    build_file = "//toolchains/arm-none-eabi/darwin:compiler.BUILD",
    sha256 = "1249f860d4155d9c3ba8f30c19e7a88c5047923cea17e0d08e633f12408f01f0",
    strip_prefix = "gcc-arm-none-eabi-9-2019-q4-major",
    url = "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-mac.tar.bz2?revision=c2c4fe0e-c0b6-4162-97e6-7707e12f2b6e&la=en&hash=EC9D4B5F5B050267B924F876B306D72CDF3BDDC0",
)

http_archive(
    name = "arm-none-eabi-linux",
    build_file = "//toolchains/arm-none-eabi/linux:compiler.BUILD",
    sha256 = "bcd840f839d5bf49279638e9f67890b2ef3a7c9c7a9b25271e83ec4ff41d177a",
    strip_prefix = "gcc-arm-none-eabi-9-2019-q4-major",
    url = "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2?revision=108bd959-44bd-4619-9c19-26187abf5225&la=en&hash=E788CE92E5DFD64B2A8C246BBA91A249CB8E2D2D",
)
