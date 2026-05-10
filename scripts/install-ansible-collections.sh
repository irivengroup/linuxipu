#!/usr/bin/env bash
set -euo pipefail

REQ_FILE="${1:-requirements.yml}"
MAX_ATTEMPTS="${UIP_GALAXY_INSTALL_ATTEMPTS:-5}"

if [ ! -f "${REQ_FILE}" ]; then
  echo "No ${REQ_FILE} found, skipping Ansible Galaxy collection installation."
  exit 0
fi

for attempt in $(seq 1 "${MAX_ATTEMPTS}"); do
  echo "Installing Ansible collections from ${REQ_FILE}, attempt ${attempt}/${MAX_ATTEMPTS}"
  if ansible-galaxy collection install -r "${REQ_FILE}" --force; then
    exit 0
  fi
  sleep $((attempt * 20))
done

ansible-galaxy collection install -r "${REQ_FILE}" --force -vvv
