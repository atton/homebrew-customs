require 'formula'

class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://tmux.github.io/"
  url "https://github.com/tmux/tmux/releases/download/2.1/tmux-2.1.tar.gz"
  sha256 "31564e7bf4bcef2defb3cb34b9e596bd43a3937cad9e5438701a81a5a9af6176"

  head do
    url "https://github.com/tmux/tmux.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool"  => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libevent"

  patch do
    url 'https://gist.githubusercontent.com/waltarix/1399751/raw/e60e879335bf3b91fef4592b194cc524bcb95388/tmux-ambiguous-width-cjk.patch'
    sha1 'cc138b1893b15c0bd57cf3956c6a3e8120abc7d0'
  end

  def install
    system "sh", "autogen.sh" if build.head?

    ENV.append "LDFLAGS", "-lresolv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"

    system "make", "install"

    bash_completion.install "examples/bash_completion_tmux.sh" => "tmux"
    pkgshare.install "examples"
  end

  def caveats; <<-EOS.undent
    Example configurations have been installed to:
      #{opt_pkgshare}/examples
    EOS
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end
