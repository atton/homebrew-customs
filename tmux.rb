class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://tmux.github.io"
  head "https://github.com/atton/tmux", using: :git, branch: '3.1b-border-ascii'
  version '3.1b'

  depends_on "autoconf"
  depends_on "automake"
  depends_on "libevent"
  depends_on "libtool"
  depends_on "ncurses"
  depends_on "pkg-config"

  resource "completion" do
    url "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/homebrew_1.0.0/completions/tmux"
    sha256 "05e79fc1ecb27637dc9d6a52c315b8f207cf010cdcee9928805525076c9020ae"
  end

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
    bash_completion.install resource("completion")
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end
