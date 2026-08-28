class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.4/Wizard-v1.0.4-darwin-arm64.zip"
      sha256 "61799090cc854d6d66052c4403445ed46a3d5facbf434ae2f59c86ce5c1a93f3"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.4/Wizard-v1.0.4-darwin-amd64.zip"
      sha256 "ca9395d10b49f136df138dcf8a11f4f04641b57dd6e2c4a0ca139d211b1222b1"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.4/Wizard-v1.0.4-linux-arm64.zip"
      sha256 "356891ffe6c3ec9438f2ba8f23ffd1f1f33ee9053c4735517c68ea11439e74d1"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.4/Wizard-v1.0.4-linux-amd64.zip"
      sha256 "372e732f266ab052b238383b1f57b9fd8231b7c41e9f850e13c118df1b8175d8"
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
