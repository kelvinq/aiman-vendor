#!/usr/bin/env bash

# Vendor dependency configuration for Aiman.
# Update VENDOR_VERSION, GITHUB_REPO, and SHA256 values when publishing new archives.

GITHUB_REPO="kelvinq/aiman-vendor"
VENDOR_VERSION="v1.0.0-alpha"
BASE_URL="${VENDOR_BASE_URL:-https://github.com/${GITHUB_REPO}/releases/download/${VENDOR_VERSION}}"

# Format: archive_name|target_dir|extract_subdir|sha256
VENDOR_ARCHIVES=(
  "app-ruby-resources.tar.gz|Aiman/Aiman/Resources|ruby|CHANGE_ME"
  "app-redmine-resources.tar.gz|Aiman/Aiman/Resources|redmine|CHANGE_ME"
)
