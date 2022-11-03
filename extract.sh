#!/usr/bin/env bash

VERSION=$1

echo "::group::Download version $VERSION"

if ! curl -o ghes.sh -vL "https://github-enterprise.s3.amazonaws.com/hyperv/updates/github-enterprise-hyperv-$VERSION.pkg"; then
  echo "::error title=Download Failed::Failed to download GitHub Enterprise Hyper-V image"
  exit 1
fi

sudo chmod +x ghes.sh

echo "::endgroup::"

echo "::group::Extract rootfs"

echo "RELEASE_VERSION=\"$VERSION\"" >/etc/github/enterprise-release
if ! SKIP_VERSION_CHECK=1 GHE_UPGRADE=1 ./ghes.sh -x; then
  echo "::error title=Execute Failed::Failed to execute update script"
  exit 1
fi
rm ghes.sh
result=$(tar -ta -f ./rootfs.payload --wildcards "\./data/github/[a-f0-9]*/**e?rb" | grep -E "\./data/github/[a-f0-9]{40}/(app|config|jobs|lib)/.+\.e?rb" | tar -vhax -f ./rootfs.payload --files-from -)
if [[ $result -ne 0 ]]; then
  echo "::error title=Extraction Failed::Failed to extract rootfs"
  exit 1
fi
rm rootfs.payload
sudo chmod -R 666 data

echo "::endgroup::"

echo "::group::Decode data"
if ! ruby decrypt_github_enterprise.rb data; then
  echo "::error title=Decode Failed::Failed to decode GitHub Enterprise data"
  exit 1
fi
echo "::endgroup::"

mv data/github/[a-f0-9]*/ github-v$VERSION
rm -r ./data

echo "Completed."
