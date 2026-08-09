# Contributing

1. Keep resources in the narrowest appropriate `common`, `operators`, `infra` or `services` layer.
2. Preserve dependency ordering and document any required CRDs or controllers.
3. Parse all YAML and build every affected Kustomization before opening a pull request.
4. Describe rollout, health verification and rollback in the pull request.
5. Never commit plaintext credentials, private keys, certificates or environment-specific secrets.
