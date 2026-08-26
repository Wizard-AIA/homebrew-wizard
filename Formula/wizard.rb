class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizard-aia.github.io/docs/"
  version "1.0.1"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.1/Wizard-v1.0.1-darwin-arm64.zip"
      sha256 "2a205b76f815eeefa1aca7d23493b6ac913f5bc15cf883e1aba58ee6e2a5fb26"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.1/Wizard-v1.0.1-darwin-amd64.zip"
      sha256 "90c4598110a6cfdde5d4eb65fbbe065cc855f1d39b11c0b900acb4d87f3bd090"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.1/Wizard-v1.0.1-linux-arm64.zip"
      sha256 "8ff3be553eeef46809b6d520cab2fd3f8751dd2c0045db436a5c7322bd54ff59"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.1/Wizard-v1.0.1-linux-amd64.zip"
      sha256 "444a00f199733e488edf29d05bfbe2bda8376f8dc2eb42068ebacac430ebd57b"
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
