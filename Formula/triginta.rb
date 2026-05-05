class Triginta < Formula
  desc "A local-first TUI Pomodoro timer and task manager."
  homepage "https://triginta.app"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.3/triginta-aarch64-apple-darwin.tar.xz"
      sha256 "24636236fd55e5f6c3bb7cf7eb600e23fa00fa520739bae28f33ffa1bb32124a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.3/triginta-x86_64-apple-darwin.tar.xz"
      sha256 "668a0004dde191a0bc0295e85871404a377f3982f3f5ba9dd0ca20e8901051ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.3/triginta-aarch64-unknown-linux-musl.tar.xz"
      sha256 "dd074e6b424dada133b73bffac26aaecb0b3c60977792f7bbcd9df62bfb1c749"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.1.3/triginta-x86_64-unknown-linux-musl.tar.xz"
      sha256 "097693eb4c1bb2774bca2cbf20c9fd310e8ddd20af7eaec7c716ba04c497f80a"
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
