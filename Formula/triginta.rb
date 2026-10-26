class Triginta < Formula
  desc "A local-first TUI Pomodoro timer and task manager."
  homepage "https://triginta.app"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.11/triginta-aarch64-apple-darwin.tar.xz"
      sha256 "2665bd09bc5cc7b616dd428b624de7181ecd5536317c8a38d969948259694f6d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.11/triginta-x86_64-apple-darwin.tar.xz"
      sha256 "3cf761c4862f801e519bf9b47baa703a3b393f5700addfaee967eae0f03bc1f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.11/triginta-aarch64-unknown-linux-musl.tar.xz"
      sha256 "42d1753ec1350b5ec80b6a805066f39553db38548ab27377a60276c63b6ff830"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.11/triginta-x86_64-unknown-linux-musl.tar.xz"
      sha256 "645d19e8433f99469f55a74a676d6e5e37d07be127cbbe45c788c7a943829422"
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
