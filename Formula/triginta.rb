class Triginta < Formula
  desc "A local-first TUI Pomodoro timer and task manager."
  homepage "https://triginta.app"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.2.0/triginta-aarch64-apple-darwin.tar.xz"
      sha256 "804eb385719b920d1298b8a3132df39da350819290de8f65b2deefddfe98e69b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.2.0/triginta-x86_64-apple-darwin.tar.xz"
      sha256 "e8b7a29b4c29ff2abc481aa267b1f259200a59775573f7a264ee0d3eb8539c14"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.2.0/triginta-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a37251f0580327aea54efe4daded2bf0f29e08787fafdeedd4b17ab58d8a2fa5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jeansimeoni/triginta/releases/download/v0.2.0/triginta-x86_64-unknown-linux-musl.tar.xz"
      sha256 "70e05b6e070c641bb0cbf6f9c20838459d24bcda40f4c6fce5185499585a040c"
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
