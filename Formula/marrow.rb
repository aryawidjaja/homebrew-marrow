class Marrow < Formula
  desc "Persistent, shared memory for AI agents - so they stop forgetting and stop colliding"
  homepage "https://github.com/aryawidjaja/marrow"
  url "https://github.com/aryawidjaja/marrow/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "80a846505cc7bbd72f239d5f86b7ae11f48dfb7c44f3f8de49909672af53638e"
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
    assert_match "marrow 0.1.4", shell_output("#{bin}/marrow --version")
  end
end
