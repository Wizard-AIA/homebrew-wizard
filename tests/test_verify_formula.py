"""Tests for scripts/verify_formula.py, run against the real v1.0.12 release data.

    python3 -m unittest discover -s tests -v
"""
import importlib.util
import pathlib
import unittest

HERE = pathlib.Path(__file__).resolve().parent
FIXTURES = HERE / "fixtures"
spec = importlib.util.spec_from_file_location("verify_formula", HERE.parent / "scripts" / "verify_formula.py")
verify_formula = importlib.util.module_from_spec(spec)
spec.loader.exec_module(verify_formula)

REAL_SUMS = (FIXTURES / "v1.0.12.SHA256SUMS").read_text()


def problems(formula_text: str, sums_text: str = REAL_SUMS) -> list[str]:
    return verify_formula.check(formula_text, lambda _tag: sums_text)


class VerifyFormula(unittest.TestCase):
    def test_a_formula_rendered_from_the_published_sums_passes(self):
        self.assertEqual(problems((FIXTURES / "wizard-v1.0.12-rendered.rb").read_text()), [])

    def test_the_formula_that_shipped_with_v1_0_12_is_rejected(self):
        # Its four sha256 values came from a local build, not from the release:
        # `brew install` failed on every Mac with "Formula reports different checksum".
        found = problems((FIXTURES / "wizard-v1.0.12-as-shipped.rb").read_text())
        self.assertEqual(len(found), 4, found)
        self.assertTrue(all("the release published" in line for line in found))

    def test_a_single_wrong_digest_is_named(self):
        text = (FIXTURES / "wizard-v1.0.12-rendered.rb").read_text()
        good = "3d1bee90b685e205476d515577fdb3d9b0a4fa0d5c6250223001f12d50678e47"
        found = problems(text.replace(good, "0" * 64))
        self.assertEqual(len(found), 1)
        self.assertIn("darwin-arm64", found[0])

    def test_an_artifact_missing_from_the_release_is_reported(self):
        without_linux_arm = "\n".join(line for line in REAL_SUMS.splitlines() if "linux-arm64" not in line)
        found = problems((FIXTURES / "wizard-v1.0.12-rendered.rb").read_text(), without_linux_arm)
        self.assertEqual(len(found), 1)
        self.assertIn("not listed", found[0])

    def test_two_releases_in_one_formula_are_rejected(self):
        text = (FIXTURES / "wizard-v1.0.12-rendered.rb").read_text().replace(
            "download/v1.0.12/Wizard-v1.0.12-linux-arm64.zip", "download/v1.0.11/Wizard-v1.0.11-linux-arm64.zip"
        )
        self.assertTrue(any("mixes releases" in line for line in problems(text)))

    def test_a_formula_pointing_somewhere_else_is_rejected(self):
        text = (FIXTURES / "wizard-v1.0.12-rendered.rb").read_text().replace("Wizard-AIA/Wizard-w2", "someone/else")
        self.assertTrue(any("found 0" in line for line in problems(text)))

    def test_sums_in_every_published_spelling_are_read(self):
        digest = "a" * 64
        self.assertEqual(
            verify_formula.parse_sums(f"{digest}  ./one.zip\n{digest} *two.zip\n{digest.upper()}  three.zip\n"),
            {"one.zip": digest, "two.zip": digest, "three.zip": digest},
        )


if __name__ == "__main__":
    unittest.main()
