"""aarch64-none-linux-gnu toolchiain archives"""

AARCH64_NONE_LINUX_GNU = {
    "13.2.1": [
        {
            "name": "aarch64_none_linux_gnu_linux_x86_64",
            "sha256": "12fcdf13a7430655229b20438a49e8566e26551ba08759922cdaf4695b0d4e23",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-linux-gnu",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz?rev=22c39fc25e5541818967b4ff5a09ef3e&hash=B9FEDC2947EB21151985C2DC534ECCEC",
            "patches": ["@toolchains_arm_gnu//toolchain:patches/0001-Resolve-libc-relative-to-sysroot-aarch64_none_linux_gnu.patch"],
            "exec_compatible_with": [
                "@platforms//os:linux",
                "@platforms//cpu:x86_64",
            ],
        },
        {
            "name": "aarch64_none_linux_gnu_windows_x86_64",
            "sha256": "ccca7e520adbc5deb36d53a2b373e28a0c7e21107c487d4f5fd9cc8e0dbf6a11",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-aarch64-none-linux-gnu",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-aarch64-none-linux-gnu.zip?rev=861fed530201460f8f58b10dca7bd431&hash=A040842727683903E8646B42A96A8B98",
            "patches": ["@toolchains_arm_gnu//toolchain:patches/0001-Resolve-libc-relative-to-sysroot-aarch64_none_linux_gnu.patch"],
            "exec_compatible_with": [
                "@platforms//os:windows",
                "@platforms//cpu:x86_64",
            ],
        },
    ],
}
