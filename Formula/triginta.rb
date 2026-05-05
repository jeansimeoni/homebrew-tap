class Triginta < Formula
  desc "A local-first TUI Pomodoro timer and task manager."
  homepage "https://triginta.app"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.5/triginta-aarch64-apple-darwin.tar.xz"
      sha256 "1c96e14a104a573a4c923c1ec761e03dca93117db1f104f7d872829ab19d9d73"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.5/triginta-x86_64-apple-darwin.tar.xz"
      sha256 "96047c8298f67177376cf83b52c98eaef32b3a9c43351aca9f7f4de2061e79c3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.5/triginta-aarch64-unknown-linux-musl.tar.xz"
      sha256 "73054ca085ba5ab789ba60293c166d5073e7e1c6c1ee02c7bd72b93c116e6367"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.5/triginta-x86_64-unknown-linux-musl.tar.xz"
      sha256 "22dc9dd74e36a414e0e2e6e0fa46c7413ee41ad01ab6051c4d90dbf1d9aaa79a"
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
