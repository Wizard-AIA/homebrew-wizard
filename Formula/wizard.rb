class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-darwin-arm64.zip"
      sha256 "8217340b4188b60c457c2877c17fbafd670879b02c938e10e4e86fc9d5b1c50b"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-darwin-amd64.zip"
      sha256 "5beb1792162498c1619e8f2d7875b3b4fdf94409af937bbc4850a3ed99ec6512"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-linux-arm64.zip"
      sha256 "79e00d176618a0cfb3d47c31f7ae57b1eb2c8fa675626293ca005b1558e62e6a"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-linux-amd64.zip"
      sha256 "1574ea7f51b42a45542633c67e3a79716b716b634d7f286565d44bb3111f5949"
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
