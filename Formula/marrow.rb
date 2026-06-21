class Marrow < Formula
  desc "Persistent, shared memory for AI agents - so they stop forgetting and stop colliding"
  homepage "https://github.com/aryawidjaja/marrow"
  url "https://github.com/aryawidjaja/marrow/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "6d6a4986a0f8696cfee6c0bb23721392f8f39d4b5b14f1fa23aa86c4c04f3f2a"
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
    assert_match "marrow 0.1.2", shell_output("#{bin}/marrow --version")
  end
end
