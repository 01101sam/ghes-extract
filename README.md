# GitHub Enterprise Source Code Extractor

> **Warning**
> DO NOT USE THIS CODE[^1] FOR ANYTHING OTHER THAN EDUCATIONAL OR ANALYSE PURPOSES.
> I AM NOT RESPONSIBLE FOR ANYTHING YOU DO WITH THIS CODE.

This is a tool to extract source code from GitHub Enterprise.

This is made for an easier way to access source code for [GitHub Security Bug Bounty](https://bounty.github.com).
\
If you want to remove this repository, please private it and email me for removal notice.

## Requirements

- Ruby
- Disk (50G+) and RAM (8G+) to temporarily store the data

## Usage

### Normal Usage

```bash
./extract.sh <VERSION>
```

### GitHub Actions

> ***Note***
> To save up GitHub Actions resources, please change `Settings -> Actions General -> Artifact and log retention`
> to 7 days.

`REPO_PATH`: Your full repository path to commit source code (e.g. `octocat/ghes-source`)
`PAT_TOKEN`: Your (Fine-grained) personal access token with (target) `repo` scope

Enter your target `GHES Version` then click `Run workflow` button.

For version, check out [Release notes](https://docs.github.com/en/enterprise-server@3.3/admin/release-notes)

## License

GNU is applied to this project but not the enterprise source code. See [LICENSE](LICENSE) for more details.
\
Thus, `decrypt_github_enterprise.rb` is excluded from this license.

## Source

- [decrypt_github_enterprise.rb](https://gist.github.com/wchen-r7/003bef511074b8bc8432e82bfbe0dd42)

[^1]: `THIS CODE` includes:

- This repository
- GitHub Enterprise Source Code