# homebrew-maddox

Homebrew tap for the official **Maddox API CLI** (`maddox`).

```sh
brew install maddox-llc/maddox/maddox
maddox --version
```

## What's here

- `Formula/maddox.rb` — the formula. Its `url`s point at the release assets in
  the distribution repo, [`Maddox-LLC/maddox`](https://github.com/Maddox-LLC/maddox/releases).

The formula is **generated**, not hand-edited: on each release,
`scripts/bump-homebrew-formula.sh` in the source repo rewrites the `version` and
each `sha256` from the release's `SHA256SUMS` and pushes the result here. The
canonical template lives at `packaging/Formula/maddox.rb` in the source repo.

## Without Homebrew

```sh
curl -fsSL https://raw.githubusercontent.com/Maddox-LLC/maddox/main/install.sh | sh
```
