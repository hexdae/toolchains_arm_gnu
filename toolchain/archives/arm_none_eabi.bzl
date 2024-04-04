"""arm-none-eabi toolchiain archives"""

ARM_NONE_EABI = {
    "9.2.1": [
        {
            "name": "arm_none_eabi_darwin_x86_64",
            "sha256": "1249f860d4155d9c3ba8f30c19e7a88c5047923cea17e0d08e633f12408f01f0",
            "strip_prefix": "gcc-arm-none-eabi-9-2019-q4-major",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-mac.tar.bz2?revision=c2c4fe0e-c0b6-4162-97e6-7707e12f2b6e&la=en&hash=EC9D4B5F5B050267B924F876B306D72CDF3BDDC0",
        },
        {
            "name": "arm_none_eabi_darwin_arm64",
            "sha256": "1249f860d4155d9c3ba8f30c19e7a88c5047923cea17e0d08e633f12408f01f0",
            "strip_prefix": "gcc-arm-none-eabi-9-2019-q4-major",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-mac.tar.bz2?revision=c2c4fe0e-c0b6-4162-97e6-7707e12f2b6e&la=en&hash=EC9D4B5F5B050267B924F876B306D72CDF3BDDC0",
        },
        {
            "name": "arm_none_eabi_linux_x86_64",
            "sha256": "bcd840f839d5bf49279638e9f67890b2ef3a7c9c7a9b25271e83ec4ff41d177a",
            "strip_prefix": "gcc-arm-none-eabi-9-2019-q4-major",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2?revision=108bd959-44bd-4619-9c19-26187abf5225&la=en&hash=E788CE92E5DFD64B2A8C246BBA91A249CB8E2D2D",
        },
        {
            "name": "arm_none_eabi_linux_aarch64",
            "sha256": "1f5b9309006737950b2218250e6bb392e2d68d4f1a764fe66be96e2a78888d83",
            "strip_prefix": "gcc-arm-none-eabi-9-2019-q4-major",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-aarch64-linux.tar.bz2?revision=4583ce78-e7e7-459a-ad9f-bff8e94839f1&la=en&hash=550DB9C0184B7C70B6C020A5DCBB9D1E156264B7",
        },
        {
            "name": "arm_none_eabi_windows_x86_64",
            "sha256": "e4c964add8d0fdcc6b14f323e277a0946456082a84a1cc560da265b357762b62",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-win32.zip?revision=20c5df9c-9870-47e2-b994-2a652fb99075&la=en&hash=347C07EEEB848CC8944F943D8E1EAAB55A6CA0BC",
            "bin_extension": ".exe",
        },
    ],
    "13.2.1": [
        {
            "name": "arm_none_eabi_darwin_x86_64",
            "sha256": "075faa4f3e8eb45e59144858202351a28706f54a6ec17eedd88c9fb9412372cc",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-darwin-x86_64-arm-none-eabi",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz?rev=a3d8c87bb0af4c40b7d7e0e291f6541b&hash=10927356ACA904E1A0122794E036E8DDE7D8435D",
        },
        {
            "name": "arm_none_eabi_darwin_arm64",
            "sha256": "39c44f8af42695b7b871df42e346c09fee670ea8dfc11f17083e296ea2b0d279",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-darwin-arm64-arm-none-eabi",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-darwin-arm64-arm-none-eabi.tar.xz?rev=73e10891de3d41e29e95ac2878742b74&hash=6036196A3358CB5AD85FC01DFD0FEC02A",
        },
        {
            "name": "arm_none_eabi_linux_x86_64",
            "sha256": "6cd1bbc1d9ae57312bcd169ae283153a9572bd6a8e4eeae2fedfbc33b115fdbb",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=688C370BF08399033CA9DE3C1CC8CF8E31D8C441",
        },
        {
            "name": "arm_none_eabi_linux_aarch64",
            "sha256": "8fd8b4a0a8d44ab2e195ccfbeef42223dfb3ede29d80f14dcf2183c34b8d199a",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-aarch64-arm-none-eabi",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-eabi.tar.xz?rev=17baf091942042768d55c9a304610954&hash=7F32B9E3ADFAFC4F8F74C30EBBBFECEB1AC96B60",
        },
        {
            "name": "arm_none_eabi_windows_x86_64",
            "sha256": "51d933f00578aa28016c5e3c84f94403274ea7915539f8e56c13e2196437d18f",
            "strip_prefix": "arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip?rev=93fda279901c4c0299e03e5c4899b51f&hash=A3C5FF788BE90810E121091C873E3532336C8D46",
            "bin_extension": ".exe",
        },
    ],
    "13.2.1-1.1": [
        {
            "name": "arm_none_eabi_darwin_arm64",
            "url": "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v13.2.1-1.1/xpack-arm-none-eabi-gcc-13.2.1-1.1-darwin-arm64.tar.gz",
            "sha256": "d4ce0de062420daab140161086ba017642365977e148d20f55a8807b1eacd703",
            "strip_prefix": "xpack-arm-none-eabi-gcc-13.2.1-1.1",
            "bin_extension": "",
        },
        {
            "name": "arm_none_eabi_darwin_x86_64",
            "url": "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v13.2.1-1.1/xpack-arm-none-eabi-gcc-13.2.1-1.1-darwin-x64.tar.gz",
            "sha256": "1ecc0fd6c31020aff702204f51459b4b00ff0d12b9cd95e832399881d819aa57",
            "strip_prefix": "xpack-arm-none-eabi-gcc-13.2.1-1.1",
            "bin_extension": "",
        },
        {
            "name": "arm_none_eabi_linux_aarch64",
            "url": "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v13.2.1-1.1/xpack-arm-none-eabi-gcc-13.2.1-1.1-linux-arm64.tar.gz",
            "sha256": "ab7f75d95ead0b1efb7432e7f034f9575cc3d23dc1b03d41af1ec253486d19de",
            "strip_prefix": "xpack-arm-none-eabi-gcc-13.2.1-1.1",
            "bin_extension": "",
        },
        {
            "name": "arm_none_eabi_linux_x86_64",
            "url": "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v13.2.1-1.1/xpack-arm-none-eabi-gcc-13.2.1-1.1-linux-x64.tar.gz",
            "sha256": "1252a8cafe9237de27a765376697230368eec21db44dc3f1edeb8d838dabd530",
            "strip_prefix": "xpack-arm-none-eabi-gcc-13.2.1-1.1",
            "bin_extension": "",
        },
        {
            "name": "arm_none_eabi_windows_x86_64",
            "url": "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v13.2.1-1.1/xpack-arm-none-eabi-gcc-13.2.1-1.1-win32-x64.zip",
            "sha256": "56b18ccb0a50f536332ec5de57799342ff0cd005ca2c54288c74759b51929e4f",
            "strip_prefix": "xpack-arm-none-eabi-gcc-13.2.1-1.1",
            "bin_extension": ".exe",
        },
    ],
}
