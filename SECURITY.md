# Security policy

Never commit Kubernetes Secret data, sealed-secret private keys, TLS material, registry credentials or kubeconfigs. Reference an external secret manager and keep decryption keys outside Git.
