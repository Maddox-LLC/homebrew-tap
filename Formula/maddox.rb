# Issue #560 PR6 — Homebrew formula for the `maddox` CLI.
#
# Lives here as the canonical template; the release pipeline copies it to the
# `Maddox-LLC/homebrew-tap` tap and rewrites `version` + each `sha256` from
# the published SHA256SUMS. The placeholder shas below let `brew style` lint the
# structure without a real release.
class Maddox < Formula
  desc "Official Maddox API command-line interface"
  homepage "https://maddoxapi.dev"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-aarch64-apple-darwin"
      sha256 "97aaf31c43ec57eab2d68957e890957ac098bd58fd5982d9b89143cad25a44be"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-x86_64-apple-darwin"
      sha256 "7bf5d93d366de512f6927fb6fe2acc212b465396f95a94f7ff0d67e40516741a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-aarch64-unknown-linux-musl"
      sha256 "aaf4fba96890dc0e85141ef53996b09eca8631a14d1f445b64030ae61fb9c549"
    end
    on_intel do
      url "https://github.com/Maddox-LLC/Maddox-CLI/releases/download/cli-v#{version}/maddox-x86_64-unknown-linux-musl"
      sha256 "db6dac25a22cdb886fcf4dd65aa6fd24e3ae265f58a05f0833c75f328111a058"
    end
  end

  def install
    bin.install Dir["maddox-*"].first => "maddox"
  end

  test do
    assert_match "maddox #{version}", shell_output("#{bin}/maddox --version")
  end
end
