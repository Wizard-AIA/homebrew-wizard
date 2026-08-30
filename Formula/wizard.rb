class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-arm64.zip"
      sha256 "787b3303ef5d5fb0b306eb1d2267caa96a6dabebf5adc01143a5ab27a0421695"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-amd64.zip"
      sha256 "d3b4ef78311b2581d00645ace97d0c8af6b80481456f068573b64bccd19c8be8"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-arm64.zip"
      sha256 "ee4577f9ce0285c961b0c72274b28ce8278db6de6e6eab139c1ce75cc3c6c712"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-amd64.zip"
      sha256 "235d1481199d174132f015f775b4785cb6515d8930761fb4a9b6a52ec2fa16e1"
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
