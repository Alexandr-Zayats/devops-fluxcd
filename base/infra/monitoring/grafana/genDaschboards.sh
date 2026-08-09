#!/usr/bin/env bash

set -euo pipefail

DASHBOARDS_DIR="dashboards"
DASHBOARDS_YAML="dashboards.yaml"
KUSTOMIZATION_YAML="kustomization.yaml"
CONFIGMAP_NAME="grafana-dashboard"
NAMESPACE="monitoring"

# Очистим/создадим dashboards.yaml
echo "" > "$DASHBOARDS_YAML"

# Подготовим список файлов
mapfile -t JSON_FILES < <(find "$DASHBOARDS_DIR" -type f -name '*.json' | sort)

# Генерация dashboards.yaml
for json_path in "${JSON_FILES[@]}"; do
  filename="$(basename "$json_path")"
  name="${filename%.json}"
  name=$(basename "$name" .json | tr '[:upper:]' '[:lower:]' | tr '_' '-' | tr ' ' '-')

  folder="$(dirname "${json_path#$DASHBOARDS_DIR/}")"
  folder=$(echo "$folder" | cut -d '/' -f1)
  folder=$(echo "$folder" | tr '[:upper:]' '[:lower:]' | tr '_' '-' | tr ' ' '-')

  cat >> "$DASHBOARDS_YAML" <<EOF
---
apiVersion: grafana.integreatly.org/v1beta1
kind: GrafanaDashboard
metadata:
  name: ${name}
spec:
  instanceSelector:
    matchLabels:
      dashboards: grafana
  configMapRef:
    name: ${CONFIGMAP_NAME}
    key: ${filename}
  folder: ${folder}
EOF
done

# Генерация kustomization.yaml
{
  echo "---"
  echo "apiVersion: kustomize.config.k8s.io/v1beta1"
  echo "kind: Kustomization"
  echo "resources:"
  echo "  - release.yaml"
  echo "  - grafana.yaml"
  echo "  - dashboards.yaml"
  echo "  - datasource.yaml"
  echo ""
  echo "configMapGenerator:"
  echo "  - name: ${CONFIGMAP_NAME}"
  echo "    files:"
  for json_path in "${JSON_FILES[@]}"; do
    echo "      - ${json_path}"
  done
  echo ""
  echo "generatorOptions:"
  echo "  disableNameSuffixHash: true"
} > "$KUSTOMIZATION_YAML"

echo "✅ Generated $DASHBOARDS_YAML and updated $KUSTOMIZATION_YAML"

