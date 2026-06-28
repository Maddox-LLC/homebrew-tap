# homebrew-maddox

Homebrew tap for the official **Maddox API CLI** (`maddox`).

```sh
brew install maddox-llc/maddox/maddox
maddox --version
```

## What's here

- `Formula/maddox.rb` — the formula. It pins a `version` and a `sha256` per
  platform, pointing at the `cli-v<version>` release assets in
  [`Maddox-LLC/MaddoxAPI`](https://github.com/Maddox-LLC/MaddoxAPI/releases).

## How it's updated

This formula is **generated**, not hand-edited. On each CLI release,
`scripts/bump-homebrew-formula.sh` in the main repo rewrites the `version` and
each `sha256` from the release's `SHA256SUMS` and pushes the result here. The
canonical template lives at `packaging/Formula/maddox.rb` in the main repo.

> Until the first `cli-v*` release is published, the `sha256` values are
> all-zero placeholders and `brew install` will fail checksum verification —
> that's expected. See `docs/runbooks/cli-release.md` in the main repo.

## Alternative install

Without Homebrew:

```sh
curl -fsSL https://maddoxapi.dev/install.sh | sh
```
