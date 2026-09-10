class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.11/Wizard-v1.0.11-darwin-arm64.zip"
      sha256 "464e1c28ee3a8cd4d620a77d1a60c69692175e37f2f8d181968ff4e5cef16c3a"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.11/Wizard-v1.0.11-darwin-amd64.zip"
      sha256 "84dfbaa80f002e4548bb5e862eda156b678794a986fe57b19892292f9451492b"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.11/Wizard-v1.0.11-linux-arm64.zip"
      sha256 "687c07a4a6bc7c01ed3c5bd32d74f8e82524a82aaa6c08c9d8dd989d95ae29b4"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.11/Wizard-v1.0.11-linux-amd64.zip"
      sha256 "4caf150b307a167c63709873775b8e8581e38c29883ca9278bb342c5767fcbc9"
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
