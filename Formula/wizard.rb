class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-darwin-arm64.zip"
      sha256 "c5345e1e6d180b0d41f11c0ae5538dfe346a539cf27e1658070be7ae3169ee24"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-darwin-amd64.zip"
      sha256 "4087d941deadcadfaafec05930fb9b591410867d24e2b91059e72df740a1de7b"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-linux-arm64.zip"
      sha256 "6199e900c8a771ff87af9be199a2c2d1ba730c06a506a79bf1c1eb986b93017f"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.5/Wizard-v1.0.5-linux-amd64.zip"
      sha256 "fb6fa8b7c4b5becc69b710684a24ad5cc60b8c4636203fa2a0cd1e451cb65787"
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
