"""Download the lastes github release for a given toolchain"""

import argparse
import urllib.request
import json


XPACK = {
    "owner": "xpack-dev-tools",
    "repo": "{prefix}-gcc-xpack",
    "url": "https://github.com/xpack-dev-tools/{prefix}-gcc-xpack/releases/download/v{version}/xpack-{prefix}-gcc-{version}-{os}.{ext}",
    "sha_url": "https://github.com/xpack-dev-tools/{prefix}-gcc-xpack/releases/download/v{version}/xpack-{prefix}-gcc-{version}-{os}.{ext}.sha",
    "strip": "xpack-{prefix}-gcc-{version}",
}

ARM_NONE_EABI = {
    "template": XPACK,
    "name": "arm_none_eabi",
    "prefix": "arm-none-eabi",
    "hosts": {
        "darwin_arm64": "darwin-arm64",
        "darwin_x86_64": "darwin-x64",
        "linux_aarch64": "linux-arm64",
        "linux_x86_64": "linux-x64",
        "windows_x86_64": "win32-x64",
    },
}


def download_sha(url):
    try:
        with urllib.request.urlopen(url) as response:
            if response.getcode() == 200:
                return response.read().decode("utf-8").split()[0]
    except urllib.error.HTTPError as e:
        exit(f"{e}: {url}")


def github_release_tags(owner, repo, count=1):
    releases_url = f"https://api.github.com/repos/{owner}/{repo}/releases"
    response = urllib.request.urlopen(releases_url)
    releases = json.loads(response.read().decode())
    return [release["tag_name"][1:] for release in releases[:count]]


def generate_archive(name, prefix, version, os, template):
    info = {
        "prefix": prefix,
        "version": version,
        "os": os,
        "ext": "zip" if "win32" in os else "tar.gz",
    }
    url = template["url"].format(**info)
    sha256 = download_sha(template["sha_url"].format(**info))
    return {
        "name": name,
        "url": url,
        "sha256": sha256,
        "strip_prefix": template["strip"].format(**info),
        "bin_extension": ".exe" if "win32" in os else "",
    }


def generate_release(name, prefix, hosts, template, releases):
    return {
        version: [
            generate_archive(
                name=f"{name}_{host}",
                prefix=prefix,
                version=version,
                os=os,
                template=template,
            )
            for host, os in hosts.items()
        ]
        for version in github_release_tags(
            owner=template["owner"],
            repo=template["repo"].format(prefix=prefix),
            count=releases,
        )
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--toolchain", choices=["arm-none-eabi"])
    parser.add_argument("--releases", default=1)
    args = parser.parse_args()

    if args.toolchain == "arm-none-eabi":
        release = generate_release(**ARM_NONE_EABI, releases=args.releases)
        print(json.dumps(release, indent=4))

if __name__ == "__main__":
    main()
