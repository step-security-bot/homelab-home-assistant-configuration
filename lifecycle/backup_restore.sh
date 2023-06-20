#!/bin/bash
set -euo pipefail

DATA_PATH=${1}

#region global configuration
S3_ASSETS_BUCKET_PATH="${S3_ASSETS_BUCKET}/home-assistant"
#endregion

#region functions
function check() {
  DATA_EXISTS="true"

  test_file='secrets.yaml'
  if ! test -f ${DATA_PATH}/${test_file}; then
    DATA_EXISTS="false"
  fi
}

function backup() {
  echo "backing up..."
  
  # uploading backup from S3
  echo "uploading storage..."
  s3cmd --access_key=${GCS_ACCESS_KEY_ID} --secret_key="${GCS_SECRET_ACCESS_KEY}" --host="https://storage.googleapis.com" --host-bucket="https://storage.googleapis.com" --recursive --force --delete-removed --exclude-from .s3ignore sync ${DATA_PATH}/.storage/ s3://${S3_ASSETS_BUCKET_PATH}/
}

function restore() {
  echo "restoring..."

  echo "wiping data..."
  rm -rf ${DATA_PATH}/
  mkdir -p ${DATA_PATH}/.storage

  # download backup from S3
  echo "downloading and restoring storage..."
  s3cmd --access_key=${GCS_ACCESS_KEY_ID} --secret_key="${GCS_SECRET_ACCESS_KEY}" --host="https://storage.googleapis.com" --host-bucket="https://storage.googleapis.com" --recursive --force sync s3://${S3_ASSETS_BUCKET_PATH}/ ${DATA_PATH}/.storage/

  # restore configuration
  echo "restoring configuration..."
  cp -rf configuration/* ${DATA_PATH}/
}
#endregion

#region log configuration
echo "using S3 bucket and path: ${S3_ASSETS_BUCKET_PATH}"
#endregion

#region data check
check
#endregion

#region backup or restore
# if check returns true, we need to perform a backup
# otherwise, we have a new (empty) setup and can restore
if [[ "${DATA_EXISTS}" == "true" ]]; then
  backup
else
  restore
fi
#endregion
