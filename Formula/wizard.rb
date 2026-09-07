class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.10/Wizard-v1.0.10-darwin-arm64.zip"
      sha256 "b4660a67be562fdcc67d3113ab02be7d015afb801318b213704721b0caa94d1b"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.10/Wizard-v1.0.10-darwin-amd64.zip"
      sha256 "cd95a839cf8127f90052da8e1375f184c1be4dd01dfcbc1a9f5caf06195d9bed"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.10/Wizard-v1.0.10-linux-arm64.zip"
      sha256 "63ad503235023f49488d0a76cff53cab2daab8297ce360493e4c5a010d302c35"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.10/Wizard-v1.0.10-linux-amd64.zip"
      sha256 "5e93e68075571652f43fb06b61f2df643fbf9cfa7426666be0c52c2f2284446a"
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
