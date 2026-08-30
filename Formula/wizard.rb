class Wizard < Formula
  desc "Local-first autonomous data analysis agent"
  homepage "https://wizardw2.vercel.app/"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-arm64.zip"
      sha256 "89f1cc063ffa820fc59cdeb3ea1674bb60628ac46b9dfb95981ee674bc723056"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-darwin-amd64.zip"
      sha256 "2bfdf4bc6245421b806953c99fcd86e038549331c77476f5d35907c713dc30d0"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-arm64.zip"
      sha256 "c5915d8a468aa177b3456bf00dcae994dbf87019a5063dbf7c9a51cd9e412eee"
    else
      url "https://github.com/Wizard-AIA/Wizard-w2/releases/download/v1.0.7/Wizard-v1.0.7-linux-amd64.zip"
      sha256 "01830a2d658392207bb83666b50c244ee004d89be3e4ee53981d96fa9cc9c3ac"
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
