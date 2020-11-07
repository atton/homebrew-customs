class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://tmux.github.io"
  head "https://github.com/atton/tmux", using: :git, branch: '3.1c-border-ascii'
  version '3.1c'

  depends_on "autoconf"
  depends_on "automake"
  depends_on "libevent"
  depends_on "libtool"
  depends_on "ncurses"
  depends_on "pkg-config"

  def install
    system "sh", "autogen.sh"

    args = %W[
      --disable-dependency-tracking
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
