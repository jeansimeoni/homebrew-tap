class Triginta < Formula
  desc "A local-first TUI Pomodoro timer and task manager."
  homepage "https://triginta.app"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.10/triginta-aarch64-apple-darwin.tar.xz"
      sha256 "90a425139f01c7768287c597dbe9d7079c0e19dfcfcf1df651eb4effac355486"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.10/triginta-x86_64-apple-darwin.tar.xz"
      sha256 "b96ee5da6eef317f627bad8e9a8eb238340fbebf7c3b152ed23c94cbd5484509"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.10/triginta-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ba33badc6c2742b2b0c02f5cea58fd9ed822f02c121464a50f5db12553d32d60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.10/triginta-x86_64-unknown-linux-musl.tar.xz"
      sha256 "195278dd4fe64c884c70557c26fcabafcecf5ca6f3b6d094e036aef5d7c4a7c3"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "triginta"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "triginta"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "triginta"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "triginta"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
