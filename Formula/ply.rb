class Ply < Formula
  desc "Local-first package manager for coding-agent assets."
  homepage "https://plycli.dev"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.2/ply-aarch64-apple-darwin.tar.xz"
      sha256 "fead8fdbfcc34882d98f836a60a9a1dc57dd465e4eaaf147dd76a78d1b56120f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.2/ply-x86_64-apple-darwin.tar.xz"
      sha256 "c905d4bbf6bf8c6c3eac5d9e065c8365caded02cfd2fc60dfe2571dce2d55495"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.2/ply-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3a40339b1dc54841362d06bf1f4271fff2f8e2f0caa2c7a0a3d3b9ab772160fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.2/ply-x86_64-unknown-linux-musl.tar.xz"
      sha256 "6f35d5fcc1bdf87dcc6e9972960fd6babd1efeb1895c9a23eb17980edbe7ca7b"
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
      bin.install "ply"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ply"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ply"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ply"
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
