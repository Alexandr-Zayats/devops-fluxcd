#!/usr/bin/env python3
from pathlib import Path
import sys

import yaml

SENSITIVE_KEYS = {
    "access_key",
    "client_secret",
    "password",
    "private_key",
    "secret_key",
}


def find_plaintext_secrets(value, path=""):
    findings = []
    if isinstance(value, dict):
        for key, child in value.items():
            child_path = f"{path}.{key}" if path else str(key)
            if (
                str(key).lower() in SENSITIVE_KEYS
                and child is not None
                and not isinstance(child, (dict, list))
            ):
                rendered = str(child).strip()
                lowered = rendered.lower()
                is_placeholder = rendered.startswith(("$", "{{", "<"))
                if rendered and lowered not in {"none", "null"} and not is_placeholder:
                    findings.append(f"{child_path}: plaintext sensitive value")
            findings.extend(find_plaintext_secrets(child, child_path))
    elif isinstance(value, list):
        for index, child in enumerate(value):
            findings.extend(find_plaintext_secrets(child, f"{path}[{index}]"))
    return findings


def main() -> int:
    errors = []
    files = sorted([*Path(".").rglob("*.yaml"), *Path(".").rglob("*.yml")])
    for path in files:
        if ".git" in path.parts:
            continue
        try:
            with path.open(encoding="utf-8") as stream:
                documents = list(yaml.safe_load_all(stream))
            for index, document in enumerate(documents):
                for finding in find_plaintext_secrets(document):
                    errors.append(f"{path} document {index + 1}: {finding}")
        except Exception as exc:  # report every malformed manifest in one run
            errors.append(f"{path}: {exc}")
    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1
    print(f"Validated {len(files)} YAML files and sensitive fields")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
