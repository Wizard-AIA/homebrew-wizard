class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-arm64.zip"
      sha256 "fe8060a99506811771a0fc6194a299c984f5207408da9fd7e76520474824c949"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-amd64.zip"
      sha256 "aa4ee43fd0c5b973215145fcc3b8245192633e2e751c4360ea52e3dcf2c18473"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-arm64.zip"
      sha256 "51837164f3c217fec0eead10fcec82b0d06c15c4119e194d7782270e66880d20"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-amd64.zip"
      sha256 "734890bd5e1fbc7b442fce77040fb214aeb35773c2c24077a1a6fbeed9bf41f7"
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
