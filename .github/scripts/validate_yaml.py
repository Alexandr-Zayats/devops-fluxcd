#!/usr/bin/env python3
from pathlib import Path
import sys

import yaml


def main() -> int:
    errors = []
    files = sorted([*Path(".").rglob("*.yaml"), *Path(".").rglob("*.yml")])
    for path in files:
        if ".git" in path.parts:
            continue
        try:
            with path.open(encoding="utf-8") as stream:
                list(yaml.safe_load_all(stream))
        except Exception as exc:  # report every malformed manifest in one run
            errors.append(f"{path}: {exc}")
    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1
    print(f"Validated {len(files)} YAML files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
