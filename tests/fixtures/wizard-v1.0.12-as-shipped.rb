class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.12/Wizard-v1.0.12-darwin-arm64.zip"
      sha256 "00c9c873a4b2be401dd70d8549bd809b53384e74ae6feb4660e4734c75ef8491"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.12/Wizard-v1.0.12-darwin-amd64.zip"
      sha256 "801d5d4ef6183a0855b08a2bd0d93928c1ff3b8cf370d9fb98ec9a115120201e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.12/Wizard-v1.0.12-linux-arm64.zip"
      sha256 "74dc7b070073ed645d6be79becbb8706118b8af25d894d32459dea8fcb0c9773"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.12/Wizard-v1.0.12-linux-amd64.zip"
      sha256 "f56a08f5acca224e8a30b81451275ad6ae0b3d883afe936a7dab5f83f4ce2c8d"
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
