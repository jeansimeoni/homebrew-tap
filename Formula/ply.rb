class Ply < Formula
  desc "Local-first package manager for coding-agent assets."
  homepage "https://plycli.dev"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.2/ply-aarch64-apple-darwin.tar.xz"
      sha256 "19b79c036e3fd60bc173661dd914278d30c0e5bde5a2ebd351f48da96892174d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.2/ply-x86_64-apple-darwin.tar.xz"
      sha256 "f2069961e0ff3d8e84a815792124522b8a127787edbeccc8d1cebfa6aa818425"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.2/ply-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b1af88db716c106e52c27ee4f5172c3b90bfff2eb75a5af5fb98b9982d0bc9d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.2/ply-x86_64-unknown-linux-musl.tar.xz"
      sha256 "d2c7812e95936046d41bac6cade47b0d3196e82e3473dfb44d4b633d049babff"
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
