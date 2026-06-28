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
      url "https://github.com/Maddox-LLC/MaddoxAPI/releases/download/cli-v#{version}/maddox-aarch64-apple-darwin"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/MaddoxAPI/releases/download/cli-v#{version}/maddox-x86_64-apple-darwin"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Maddox-LLC/MaddoxAPI/releases/download/cli-v#{version}/maddox-aarch64-unknown-linux-musl"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/MaddoxAPI/releases/download/cli-v#{version}/maddox-x86_64-unknown-linux-musl"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install Dir["maddox-*"].first => "maddox"
  end

  test do
    assert_match "maddox #{version}", shell_output("#{bin}/maddox --version")
  end
end
