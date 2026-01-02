#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="${PROJECT_ROOT}/vendor-archives"

if [ ! -f "${SCRIPT_DIR}/vendor-config.sh" ]; then
  echo "Missing vendor config: ${SCRIPT_DIR}/vendor-config.sh" >&2
  exit 1
fi

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/vendor-config.sh"

require_dir() {
  local path=$1
  if [ ! -d "$path" ]; then
    echo "Missing directory: $path" >&2
    exit 1
  fi
}

require_tool() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required tool: $1" >&2
    exit 1
  fi
}

create_archive() {
  local archive_name=$1
  local target_dir=$2
  local extract_subdir=$3

  local source_root="${PROJECT_ROOT}/${target_dir}"
  local source_path="${source_root}/${extract_subdir}"
  local archive_path="${OUTPUT_DIR}/${archive_name}"

  require_dir "$source_path"

  tar -czf "$archive_path" -C "$source_root" "$extract_subdir"

  local checksum
  checksum=$(shasum -a 256 "$archive_path" | awk '{print $1}')

  echo "${archive_name}|${target_dir}|${extract_subdir}|${checksum}"
}

main() {
  require_tool tar
  require_tool shasum

  mkdir -p "$OUTPUT_DIR"

  echo "Creating vendor archives in ${OUTPUT_DIR}"
  echo ""
  echo "Copy the lines below into scripts/vendor-config.sh (replace CHANGE_ME):"

  for entry in "${VENDOR_ARCHIVES[@]}"; do
    IFS='|' read -r archive_name target_dir extract_subdir _checksum <<< "$entry"
    create_archive "$archive_name" "$target_dir" "$extract_subdir"
  done

  echo ""
  echo "Archives created:"
  ls -lh "$OUTPUT_DIR"
}

main "$@"
