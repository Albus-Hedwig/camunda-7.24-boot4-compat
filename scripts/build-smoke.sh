#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

if ! command -v mvn >/dev/null 2>&1; then
  echo "Maven is required. Install Maven 3.9+ and retry." >&2
  exit 1
fi

mvn -f "$repo_root/smoke-app/pom.xml" -DskipTests package
echo
echo "Run with:"
echo "  java -jar \"$repo_root/smoke-app/target/camunda-boot4-smoke-0.0.1-SNAPSHOT.jar\""
