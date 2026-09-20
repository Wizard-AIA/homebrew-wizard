#!/usr/bin/env python3
"""Check that a Wizard Homebrew formula matches the release it points at.

    verify_formula.py Formula/wizard.rb                 # fetches the release's SHA256SUMS
    verify_formula.py wizard.rb --sums SHA256SUMS       # offline

The v1.0.12 formula pinned SHA-256 values copied from a maintainer's local build,
so `brew install` failed on every Mac with "Formula reports different checksum".
This is the guard: every url in the formula must sit on one release, and every
sha256 must equal the digest that release published for that file.

Exit 0 when consistent, 1 when not, 2 on usage or fetch errors.
"""
from __future__ import annotations

import argparse
import re
import sys
import urllib.request

REPO = "Wizard-AIA/Wizard-w2"
URL_RE = re.compile(
    r'url\s+"https://github\.com/' + re.escape(REPO) + r'/releases/download/(v[0-9]+\.[0-9]+\.[0-9]+)/([^"/]+)"\s*\n\s*sha256\s+"([0-9a-f]{64})"'
)
EXPECTED_ARTIFACTS = 4  # darwin arm64/amd64, linux arm64/amd64


def parse_formula(text: str) -> list[tuple[str, str, str]]:
    """(tag, file name, sha256) for every url/sha256 pair, in file order."""
    return URL_RE.findall(text)


def parse_sums(text: str) -> dict[str, str]:
    """SHA256SUMS -> {name: digest}. Accepts `digest  name`, `digest *name`, `digest  ./name`."""
    sums: dict[str, str] = {}
    for line in text.splitlines():
        match = re.fullmatch(r"([0-9a-fA-F]{64})\s+\*?(?:\./)?(\S+)", line.strip())
        if match:
            sums[match.group(2)] = match.group(1).lower()
    return sums


def check(formula: str, sums_for) -> list[str]:
    """Problems found in `formula`; `sums_for(tag)` returns that release's SHA256SUMS text."""
    pairs = parse_formula(formula)
    problems: list[str] = []
    if len(pairs) < EXPECTED_ARTIFACTS:
        problems.append(f"expected {EXPECTED_ARTIFACTS} url/sha256 pairs on {REPO} releases, found {len(pairs)}")
    tags = {tag for tag, _, _ in pairs}
    if len(tags) > 1:
        problems.append(f"the formula mixes releases: {', '.join(sorted(tags))}")
    for tag in sorted(tags):
        sums = parse_sums(sums_for(tag))
        for pair_tag, name, digest in pairs:
            if pair_tag != tag:
                continue
            published = sums.get(name)
            if published is None:
                problems.append(f"{name} is not listed in {tag}'s SHA256SUMS")
            elif published != digest:
                problems.append(f"{name}: formula says {digest}, the release published {published}")
    return problems


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("formula")
    parser.add_argument("--sums", help="a local SHA256SUMS file instead of downloading the release's")
    args = parser.parse_args(argv)

    try:
        with open(args.formula, encoding="utf-8") as handle:
            formula = handle.read()
    except OSError as error:
        print(f"verify_formula: {error}", file=sys.stderr)
        return 2

    def sums_for(tag: str) -> str:
        if args.sums:
            with open(args.sums, encoding="utf-8") as handle:
                return handle.read()
        url = f"https://github.com/{REPO}/releases/download/{tag}/SHA256SUMS"
        with urllib.request.urlopen(url, timeout=30) as response:  # noqa: S310 - fixed https URL
            return response.read().decode("utf-8")

    try:
        problems = check(formula, sums_for)
    except OSError as error:
        print(f"verify_formula: could not read the release checksums: {error}", file=sys.stderr)
        return 2
    if problems:
        print("verify_formula: the formula does not match its release:", file=sys.stderr)
        for problem in problems:
            print(f"  - {problem}", file=sys.stderr)
        return 1
    tag = parse_formula(formula)[0][0]
    print(f"verify_formula: {args.formula} matches {tag} ({len(parse_formula(formula))} artifacts)")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
