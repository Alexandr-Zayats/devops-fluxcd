# FluxCD platform manifests

Reusable Kubernetes platform manifests organized into common resources, operators, infrastructure and services.

The manifests are designed to be composed with Kustomize and reconciled by FluxCD. Before use, replace example registries, domains, certificates and secret references with environment-specific values.

Sensitive manifests, certificates and private-cluster integrations are intentionally omitted from this public edition.
