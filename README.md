
# aiman-vendor

Release repository for Aiman’s vendored runtime assets (Ruby + Redmine).

This repo exists to keep large binary/vendor artifacts out of the main `aiman` git history. The main app downloads these archives at build/setup time.

## Contents

Each release includes the following assets:

- `app-ruby-resources.tar.gz`
  - Extracts to: `Aiman/Aiman/Resources/ruby`
- `app-redmine-resources.tar.gz`
  - Extracts to: `Aiman/Aiman/Resources/redmine`

## Checksums

The main repo validates SHA256 checksums on download. If the checksum does not match, setup fails.

## License

This repository’s metadata is MIT-licensed, but the archived vendor assets contain third-party software (Ruby and Redmine). Their contents are governed by their upstream licenses and must be used and redistributed accordingly.

Refer to:
  - Ruby license: https://www.ruby-lang.org/en/about/license.txt
  - Redmine license: https://www.redmine.org/projects/redmine/wiki/License