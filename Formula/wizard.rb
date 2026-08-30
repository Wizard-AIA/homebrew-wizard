class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.6/Wizard-v1.0.6-darwin-arm64.zip"
      sha256 "15fadc2f3127841c0a6a0082a4294b3d67e59d4de280490e6e6212d7c2683723"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.6/Wizard-v1.0.6-darwin-amd64.zip"
      sha256 "61ca09e4221a78c2b10d391aeef5d1b4b711d94a261a3cc7f588ce6943010c3c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.6/Wizard-v1.0.6-linux-arm64.zip"
      sha256 "5ad3772d7c03c382388394bd7044efb23831901d623477793fd7f9c846d84cc9"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.6/Wizard-v1.0.6-linux-amd64.zip"
      sha256 "974622c0987c781dc5b9155b13fb736c7755fcc24158a9adeaa5a363662e0b89"
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
    assert_match "wizard CLI", shell_output("#{bin}/wizard version 2>&1")
  end
end
