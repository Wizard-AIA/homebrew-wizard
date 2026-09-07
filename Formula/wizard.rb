class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-darwin-arm64.zip"
      sha256 "02bfc8d745ea87d6604c7b816d5291d6538264cc16466094b4a56ccea9da5aa9"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-darwin-amd64.zip"
      sha256 "1c797937ffd1998c89ee991da804836a6d4e4555322b79accebf512f4ba66a33"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-linux-arm64.zip"
      sha256 "4836e544dc3c7ac47527d307f8b6c3f65661fd97437fdd060063a9931fef3935"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.9/Wizard-v1.0.9-linux-amd64.zip"
      sha256 "d7173501edf7d29b4b3b6fcdcb3ffeb7f58bb885640e7ca77c78c0497aea6640"
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
