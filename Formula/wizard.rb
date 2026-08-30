class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-arm64.zip"
      sha256 "bb6ab2af5bab3c7a9814f7e0f9557aff3daceb31d0a8d60becc9df760dae8705"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-amd64.zip"
      sha256 "9133e7240ae8247f55ad7ac4ecf78ee850574fbb75dcb7c47b6e8b425fa92a10"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-arm64.zip"
      sha256 "e03b81ae01db1958c9d30bda1f41ea75324d77099c875f54656559d139f4f061"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-amd64.zip"
      sha256 "add9c5f82e030860eb25958236b81f0378448429b183bd52bbaa582d0e7001c9"
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
