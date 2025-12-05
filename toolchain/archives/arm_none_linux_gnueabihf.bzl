"""arm-none=linux-gnueabihf toolchiain archives"""

ARM_NONE_LINUX_GNUEABIHF = {
    "13.2.1": [
        {
            "name": "arm_none_linux_gnueabihf_linux_x86_64",
            "sha256": "df0f4927a67d1fd366ff81e40bd8c385a9324fbdde60437a512d106215f257b3",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-linux-gnueabihf",
            "url": "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz",
            "patches": ["@toolchains_arm_gnu//toolchain:patches/0001-Resolve-libc-relative-to-sysroot.patch"],
            "exec_compatible_with": [
                "@platforms//os:linux",
                "@platforms//cpu:x86_64",
            ],
        },
        {
            "name": "arm_none_linux_gnueabihf_linux_aarch64",
            "sha256": "8ad384bb328bccc44396d85c8f8113b7b8c5e11bcfef322e77cda3ebe7baadb5",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-aarch64-arm-none-linux-gnueabihf",
            "url": "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-linux-gnueabihf.tar.xz",
            "patches": ["@toolchains_arm_gnu//toolchain:patches/0001-Resolve-libc-relative-to-sysroot.patch"],
            "exec_compatible_with": [
                "@platforms//os:linux",
                "@platforms//cpu:aarch64",
            ],
        },
        {
            "name": "arm_none_linux_gnueabihf_windows_x86_64",
            "sha256": "047e72bcef8f7767691f36929a8c74ef66f717cf6264a31f48dd31bfb067f4c8",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-linux-gnueabihf",
            "url": "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-linux-gnueabihf.zip",
            "patches": ["@toolchains_arm_gnu//toolchain:patches/0001-Resolve-libc-relative-to-sysroot.patch"],
            "exec_compatible_with": [
                "@platforms//os:windows",
                "@platforms//cpu:x86_64",
            ],
        },
    ],
}
