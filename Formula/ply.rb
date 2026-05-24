class Ply < Formula
  desc "Local-first package manager for coding-agent assets."
  homepage "https://plycli.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.0/ply-aarch64-apple-darwin.tar.xz"
      sha256 "95057af29bd92fb8200efbbae473aff8ad97d845f5d9d0919ef8ba3e0e3ed280"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.0/ply-x86_64-apple-darwin.tar.xz"
      sha256 "2daaca7afa793d27107d689ac6a22a520ddfdc6a90c460a1509e69aaa4bdfaad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.0/ply-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3dc8ef27221230c2175edb8fed5ff92c3dd4597a38a82ba3a27fab00c295cf69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.0/ply-x86_64-unknown-linux-musl.tar.xz"
      sha256 "78b8ad4e01e60af912afe35d55d057d5b766ffd4ca0b5cdc56c311b01a2da8c9"
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
