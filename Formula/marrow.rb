class Marrow < Formula
  desc "Persistent, shared memory for AI agents - so they stop forgetting and stop colliding"
  homepage "https://github.com/aryawidjaja/marrow"
  url "https://github.com/aryawidjaja/marrow/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "7bdb4dded7e2df4dccb6f26e39898b0b17268334129184fe62a38decc7b4a46a"
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
      Docs: https://github.com/aryawidjaja/marrow
    EOS
  end

  test do
    assert_match "marrow 0.1.1", shell_output("#{bin}/marrow --version")
  end
end
