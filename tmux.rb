class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://tmux.github.io/"
  head "https://github.com/atton/tmux", using: :git, branch: '3.0a-border-ascii'
  version '3.0a'

  depends_on "autoconf"
  depends_on "automake"
  depends_on "libtool"
  depends_on "pkg-config"
  depends_on "libevent"
  depends_on "ncurses"

  def install
    system "sh", "autogen.sh"

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
    ]

    ENV.append "LDFLAGS", "-lresolv"
    system "./configure", *args

    system "make", "install"
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end
