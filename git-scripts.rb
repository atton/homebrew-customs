class GitScripts < Formula
  desc 'My Git Scripts'
  homepage 'https://github.com/atton/git-scripts'
  head 'https://github.com/atton/git-scripts', using: :git

  bottle :unneeded

  def install
    bin.install Dir["git-*"]
  end
end

