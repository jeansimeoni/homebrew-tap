class Ply < Formula
  desc "Local-first package manager for coding-agent assets."
  homepage "https://plycli.dev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.1/ply-aarch64-apple-darwin.tar.xz"
      sha256 "24072130e666ba5f06c54773c44dbfff2e31b8437a7b407c41fc3ec1e50745ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.1/ply-x86_64-apple-darwin.tar.xz"
      sha256 "09f93d429289f47a51b9ef831acab857e5652ae42a7ad134a78297f89422fd7a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.1/ply-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a25795ec12fc7328f50c75fb2c6dad7656198d68079537634502f1da5a0e6ec9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/ply/releases/download/v0.1.1/ply-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3d20d7c1e8fa2fe81ac2ebbe320cea463badf23c63c18d0bb37cd5aee526d892"
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
