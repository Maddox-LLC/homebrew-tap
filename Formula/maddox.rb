# Issue #560 PR6 — Homebrew formula for the `maddox` CLI.
#
# Lives here as the canonical template; the release pipeline copies it to the
# `Maddox-LLC/homebrew-tap` tap and rewrites `version` + each `sha256` from
# the published SHA256SUMS. The placeholder shas below let `brew style` lint the
# structure without a real release.
class Maddox < Formula
  desc "Official Maddox API command-line interface"
  homepage "https://maddoxapi.dev"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-aarch64-apple-darwin"
      sha256 "5bef97f5cfe0b8fd8442c6d65a2f332a1603d09714a30c34012f29e5cf993710"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-x86_64-apple-darwin"
      sha256 "e9c0945bd0b8f30e82c59c2503c56d678527bc4789b88562c28c4ca254b9ddae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-aarch64-unknown-linux-musl"
      sha256 "3b209e834d5c6671c45b60de6ba0b9e952c7fd376502933200e63576edbbb5a5"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-x86_64-unknown-linux-musl"
      sha256 "fd4ba9ce7088a455ce82abe800831e6d1de5f9181142acb1b568c55376fd0747"
    end
  end

  def install
    bin.install Dir["maddox-*"].first => "maddox"
  end

  test do
    assert_match "maddox #{version}", shell_output("#{bin}/maddox --version")
  end
end
