class Ply < Formula
  desc "Local-first package manager for coding-agent assets."
  homepage "https://plycli.dev"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.0/ply-aarch64-apple-darwin.tar.xz"
      sha256 "cb6375b969b2ea2b7352984de5f1381c3a63fb1ce375f4b764e4bcdb5abd90bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.0/ply-x86_64-apple-darwin.tar.xz"
      sha256 "c7814779f8e6830075c663bd7331fe58675fc329aeac7925254e0c4f0ef6b62c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.0/ply-aarch64-unknown-linux-musl.tar.xz"
      sha256 "28f72dcb531944111ecc5376c266e07fa1499d49ea3c4a7d66f05dc4a57b33ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.2.0/ply-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5c72bcf79ebba60cd3f68d806daba87871ce8fa3dbaae13e4f9f45ade7757ef6"
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
