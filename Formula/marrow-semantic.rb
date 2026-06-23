class MarrowSemantic < Formula
  desc "Marrow with semantic search built in (local fastembed embeddings)"
  homepage "https://github.com/aryawidjaja/marrow"
  url "https://github.com/aryawidjaja/marrow/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "a9afa2f853f6d149e768cd4ec9df1aca7ccc8a4e175e1ee167148ae6e855e0d3"
  license "AGPL-3.0-only"
  head "https://github.com/aryawidjaja/marrow.git", branch: "main"

  depends_on "rust" => :build

  conflicts_with "marrow", because: "both install the marrow and marrow-mcp binaries"

  def install
    system "cargo", "install", "--locked", "--features", "embed-fastembed",
           "--root", prefix, "--path", "crates/marrow-cli"
    system "cargo", "install", "--locked", "--features", "embed-fastembed",
           "--root", prefix, "--path", "crates/marrow-mcp"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/marrow-web"
  end

  def caveats
    <<~EOS
      This build includes semantic search. Turn it on per project:
        cd your-project
        marrow embed fastembed     # first query downloads a small model, then fully offline

      Then `marrow setup` and restart Claude Code. Docs: https://github.com/aryawidjaja/marrow
    EOS
  end

  test do
    assert_match "marrow 0.1.7", shell_output("#{bin}/marrow --version")
  end
end
