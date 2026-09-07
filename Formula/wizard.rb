class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-darwin-arm64.zip"
      sha256 "249bbee47e30de2bfa2a697fecfc1e3d07123b75e59bd189f1e3e7a532214664"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-darwin-amd64.zip"
      sha256 "46a4cad66d5e1c1ace734d0b8e215d8159f02e4659a042933affda2dc10ce5cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-linux-arm64.zip"
      sha256 "e21d54b32c6601e2d43f986849f65522f650557bb9da1decee6ef8598f9b4b1c"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-linux-amd64.zip"
      sha256 "81d6c6fcafb3a1c82cdc98074833df5438e58626c48492ccf8ba4f3590a2183f"
    end
  end

  def install
    bin.install "cli/wizard" => "wizard"
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
