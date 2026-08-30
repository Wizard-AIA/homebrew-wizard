class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-arm64.zip"
      sha256 "1b09a6adc366b1ceac120289ed3430cee155e2b23c88f10f157ac94e6d408cbc"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-amd64.zip"
      sha256 "0909ba281d29d839e61325f57cfe5c60caba3b84309e5a7f76f8ae6ab960c696"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-arm64.zip"
      sha256 "bda3fe69bbb51c0928e7bc5384255f108bfb1214f4c34a7c0a08590114b03e05"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-amd64.zip"
      sha256 "c322bae04dc06aa39c7b36cbc70da75f1c911108ab1f7277a0d8664e00d02a9c"
    end
  end

  def install
    bin.install "wizard"
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
