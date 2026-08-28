class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.3/Wizard-v1.0.3-darwin-arm64.zip"
      sha256 "cf1889070646932e508d5f3822fd530486e147320b949752f84012bfdf3873de"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.3/Wizard-v1.0.3-darwin-amd64.zip"
      sha256 "7d801945b51774b074ccb81d76c430f2a5d30767ff9b518605a5b5cda57afd0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.3/Wizard-v1.0.3-linux-arm64.zip"
      sha256 "7be903c847687cc53b691c0d95b932bef5397f4263f295190ef554d95d24b59f"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.3/Wizard-v1.0.3-linux-amd64.zip"
      sha256 "41b257f1f2a24b20acd67cf4620807dfe0eefc825b964d974f6f705d62f44913"
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
