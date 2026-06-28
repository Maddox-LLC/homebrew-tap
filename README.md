# homebrew-tap

The Homebrew tap for the official **Maddox API CLI** (`maddox`).

```sh
brew install maddox-llc/tap/maddox
maddox --version
```

## Contents

- `Formula/maddox.rb` — the formula. Its download URLs point at the release assets
  in the distribution repository,
  [`Maddox-LLC/maddox`](https://github.com/Maddox-LLC/maddox/releases).

The formula is generated rather than edited by hand: on each release,
`scripts/bump-homebrew-formula.sh` (in the source monorepo) rewrites the `version`
and each `sha256` from the release's `SHA256SUMS` and pushes the result here. The
canonical template lives at `packaging/Formula/maddox.rb` in the source repository.

## Installing without Homebrew

```sh
curl -fsSL https://raw.githubusercontent.com/Maddox-LLC/maddox/main/install.sh | sh
```
