class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-darwin-arm64.zip"
      sha256 "f51dd990acd96a07e4ee6c7b9ef5a76d224ffc3944ee5f03c651a25feef78690"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-darwin-amd64.zip"
      sha256 "1fac6adcd81be76921a1e0da24679ffb17d4408c14953abbee05708a5eb1fae1"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-linux-arm64.zip"
      sha256 "5a9c0471571309f8fb5ef821c822c2f75a6d977f33f59521e6bf337a21c68d70"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-linux-amd64.zip"
      sha256 "bcfa249e391320443e529593e9e387a814164afac79a5c234d38faa6e7bbc87b"
    end
  end

  def install
    bin.install "cli/wizard"
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      Wizard is installed! To initialize and launch Wizard:

        wizard init
        wizard start

      Then open http://localhost:3000 in your browser.
    EOS
  end

  test do
    assert_match "wizard CLI", shell_output("#{bin}/wizard version 2>&1")
  end
end
