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

  test do
    assert_match "marrow 0.1.1", shell_output("#{bin}/marrow --version")
  end
end
