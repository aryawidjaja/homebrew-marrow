class Marrow < Formula
  desc "Persistent, shared memory for AI agents - so they stop forgetting and stop colliding"
  homepage "https://github.com/aryawidjaja/marrow"
  url "https://github.com/aryawidjaja/marrow/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "a5515fe6d020137b0f53e43cac25643dacf577f146a484a2dd9e3cd2c410cf42"
  license "AGPL-3.0-only"
  head "https://github.com/aryawidjaja/marrow.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/marrow-cli"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/marrow-mcp"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/marrow-web"
  end

  def caveats
    <<~EOS
      Next steps:
        cd your-project
        marrow setup            # wire this project into Claude Code (add --global for every project)
        # then restart Claude Code

      Onboard an existing repo with `marrow ingest`, and capture a session anytime with /marrow-save.

      Search is keyword by default. For smarter meaning-based recall, enable semantic search (opt-in):
        cargo install --git https://github.com/aryawidjaja/marrow marrow-cli marrow-mcp --features embed-fastembed
        marrow embed fastembed

      Docs: https://github.com/aryawidjaja/marrow
    EOS
  end

  test do
    assert_match "marrow 0.1.6", shell_output("#{bin}/marrow --version")
  end
end
