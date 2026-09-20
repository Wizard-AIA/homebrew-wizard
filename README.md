# Homebrew Tap for Wizard 🧙‍♂️

Official Homebrew tap for **[Wizard](https://github.com/Wizard-AIA/Wizard-w2)** — the local-first autonomous data analysis agent.

[![Release](https://img.shields.io/github/v/release/Wizard-AIA/Wizard-w2?label=Release&color=orange)](https://github.com/Wizard-AIA/Wizard-w2/releases/latest) [![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](LICENSE)

---

## ⚡ Installation

macOS (Apple Silicon or Intel) and Linux (x86-64 or ARM64), with [Homebrew](https://brew.sh):

```bash
brew install Wizard-AIA/wizard/wizard
```

Or add the tap first:

```bash
brew tap Wizard-AIA/wizard
brew install wizard
```

Nothing here needs `sudo`. No Homebrew? See the [other install methods](https://github.com/Wizard-AIA/Wizard-w2#-install) (a one-line script for Linux and macOS, PowerShell and Scoop for Windows).

---

## 🚀 Quick Start

```bash
wizard --version  # wizard CLI v<version>
wizard init       # choose a provider and models, install what is missing
wizard start      # launch the daemon and open the web workspace in your browser
```

`wizard init` asks for your provider and API key (shown as dots, never echoed), lists only the models that provider actually offers, and installs any missing prerequisite (Python 3.12+, Node.js 20+, uv, pnpm). Anything you already have at or above those versions is used as it is.

Open **http://localhost:3000** to begin analyzing your data.

If something looks wrong, run `wizard doctor`: it checks the installation and says how to fix each problem.

---

## 🔄 Upgrading

```bash
brew update
brew upgrade wizard
wizard init       # rebuilds dependencies for the new version; your settings are kept
```

`wizard update` does not manage a Homebrew install (Homebrew owns those files) and prints the command above instead.

---

## 🗑 Uninstalling

```bash
brew uninstall wizard
```

That removes the program and leaves your settings, API keys and logs in place. To delete those too, run this **before** uninstalling:

```bash
wizard uninstall --purge
```

---

## 🔧 How this tap is maintained

`Formula/wizard.rb` is **generated, not written by hand**. Each Wizard release renders it from the checksums it published (`SHA256SUMS`) and attaches it to the release as `wizard.rb`. The [Sync formula](.github/workflows/sync-formula.yml) workflow pulls it in, and refuses anything whose checksums differ from the release's. [Formula CI](.github/workflows/formula-ci.yml) audits it and runs a real `brew install` on macOS and Linux.

Do not edit the formula. If a release needs a formula change, change the template in the [Wizard repository](https://github.com/Wizard-AIA/Wizard-w2) (`packaging/homebrew/wizard.rb.tmpl`); a hand-edited checksum is how v1.0.12 shipped a formula that could not install.

Checking a formula yourself: `python3 scripts/verify_formula.py Formula/wizard.rb` (needs network), and `python3 -m unittest discover -s tests` for the verifier's own tests.

---

## 📄 License

BSD-3-Clause Licensed.
