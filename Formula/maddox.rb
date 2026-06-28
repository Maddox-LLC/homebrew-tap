# Issue #560 PR6 — Homebrew formula for the `maddox` CLI.
#
# Lives here as the canonical template; the release pipeline copies it to the
# `Maddox-LLC/homebrew-maddox` tap and rewrites `version` + each `sha256` from
# the published SHA256SUMS. The placeholder shas below let `brew style` lint the
# structure without a real release.
class Maddox < Formula
  desc "Official Maddox API command-line interface"
  homepage "https://maddoxapi.dev"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Maddox-LLC/maddox/releases/download/cli-v#{version}/maddox-aarch64-apple-darwin"
      sha256 "d8fd149b276080618b5cc05c2f52a4d85626413f796fb951c43adf7d3348d1ee"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/maddox/releases/download/cli-v#{version}/maddox-x86_64-apple-darwin"
      sha256 "5cd1681e71a8164562e2839a4c7329dac7a44baef3132f25a4b7cf312e42733c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Maddox-LLC/maddox/releases/download/cli-v#{version}/maddox-aarch64-unknown-linux-musl"
      sha256 "77f34aad17aff5aa3af4556a29e3533e2f07deddf8c58a9ec54c13eb243c4d3b"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/maddox/releases/download/cli-v#{version}/maddox-x86_64-unknown-linux-musl"
      sha256 "1e80618bb8efdfc07420f95e3a9942596d0968c43e9baeea5d1c20de045e398c"
    end
  end

  def install
    bin.install Dir["maddox-*"].first => "maddox"
  end

  test do
    assert_match "maddox #{version}", shell_output("#{bin}/maddox --version")
  end
end
