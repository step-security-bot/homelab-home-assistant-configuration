#!/bin/bash
set -euo pipefail

DATA_PATH=${1}

#region custom components
echo "[custom_components] wiping all existing components..."
rm -rf ${DATA_PATH}/custom_components
mkdir -p ${DATA_PATH}/custom_components

components=$(cat configuration/custom_components.txt)
for component in ${components}; do
  IFS='@' read -ra data <<< "${component}"
  echo "[custom_components] processing ${data[0]} at version ${data[1]}"
  git clone --quiet --depth 1 --branch ${data[1]} ${data[0]} /tmp/component &> /dev/null
  cp -rf /tmp/component/custom_components/* ${DATA_PATH}/custom_components/
  rm -rf /tmp/component
done

rm ${DATA_PATH}/custom_components/__init__.py
#endregion

echo ""

#region www components
echo "[www_components] wiping all existing components..."
rm -rf ${DATA_PATH}/www
mkdir -p ${DATA_PATH}/www

components=$(cat configuration/www_components.txt)
for component in ${components}; do
  IFS='@' read -ra data <<< "${component}"
  echo "[www_components] processing ${data[0]} to ${data[1]}"
  mkdir -p ${DATA_PATH}/www/${data[1]}
  wget -P ${DATA_PATH}/www/${data[1]} ${data[0]} &> /dev/null
done
#endregion
