class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  version "1.0.2"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.2/Wizard-v1.0.2-darwin-arm64.zip"
      sha256 "cb254f5c6a3acdb34bee51b906d3f2144d26cd5fdc9658ce11586c065e5b8a04"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.2/Wizard-v1.0.2-darwin-amd64.zip"
      sha256 "c9bb20454e831cf579bf03b7508b676d1e8aa67f922cc4293a6828a22a608fb5"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.2/Wizard-v1.0.2-linux-arm64.zip"
      sha256 "089c486c92f8b938e3e12fb73a858b7947ab0b6dd80b604f3444913a0c8beb9f"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.2/Wizard-v1.0.2-linux-amd64.zip"
      sha256 "ab8ac2cb61e880a83b3d239a265a210eb60a090dd0192d85611fa47bb43543c3"
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
    assert_match "wizard version", shell_output("#{bin}/wizard version 2>&1", 0)
  end
end
