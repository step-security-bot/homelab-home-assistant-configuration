#!/bin/bash
set -euo pipefail

FILES=(
  "configuration/secrets.yaml"
)

COMMAND=${1}

#region encryption and decryption
for file in ${FILES[@]}; do
  IFS='.' read -ra data <<< "${file}"
  
  if [[ "${COMMAND}" == "d" ]]; then
    echo "[sops] decrypting file ${file}"
    sops -d ${data[0]}.enc.${data[1]:-} > ${file}
  else
    echo "[sops] encrypting file ${file}"
    sops -e ${file} > ${data[0]}.enc.${data[1]:-}
  fi
done
#endregion
