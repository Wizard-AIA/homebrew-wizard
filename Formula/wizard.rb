class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.8/Wizard-v1.0.8-darwin-arm64.zip"
      sha256 "853e2f2364b4c8e76898cb8fdf093598aa8b37d6e129be2831085f9366a7bdf7"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.8/Wizard-v1.0.8-darwin-amd64.zip"
      sha256 "c7af7b56729b1f463664c990e065cf88c0a4cb83c2a992767ec0cfb5039a649a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.8/Wizard-v1.0.8-linux-arm64.zip"
      sha256 "07079198d92fd4e3810e108410afa0e6021d656f651b55ddbfe4704381828303"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.8/Wizard-v1.0.8-linux-amd64.zip"
      sha256 "4d44d000c1b2b1530a140d1dadb48c5ecdb6572e72db7d48192a9a245cf3acce"
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
