class MacScripts < Formula
  desc 'Scripts for macOS'
  homepage 'https://github.com/atton/mac-scripts'
  head 'https://github.com/atton/mac-scripts', using: :git

  bottle :unneeded

  def install
    bin.install Dir["*"].select{|file|File.executable?(file)}
  end
end
