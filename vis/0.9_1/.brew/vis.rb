class Vis < Formula
  desc "Vim-like text editor"
  homepage "https://github.com/martanne/vis"
  license "ISC"
  revision 1
  head "https://github.com/martanne/vis.git", branch: "master"

  stable do
    url "https://github.com/martanne/vis/archive/refs/tags/v0.9.tar.gz"
    sha256 "bd37ffba5535e665c1e883c25ba5f4e3307569b6d392c60f3c7d5dedd2efcfca"

    # Apply Fedora patch to support Lua 5.5 until upstream has new release with
    # https://github.com/martanne/vis/commit/b8fea9bcb14ea10e618c539c400139dd43d90e02
    patch do
      url "https://src.fedoraproject.org/rpms/vis/raw/bb0fc38581783fed74ead453dc216d17fbf551e4/f/vis-0.9-lua-5.5.patch"
      sha256 "300bbabe3c149e94c5e5c64622087d40d2ce8c2f4cf2146e8f3e5a6d672fdae2"
      type :unofficial
    end
  end

  depends_on "pkgconf" => :build
  depends_on "libtermkey"
  depends_on "lpeg"
  depends_on "lua"
  depends_on "tre"

  uses_from_macos "unzip" => :build
  uses_from_macos "ncurses"

  on_linux do
    depends_on "acl"
  end

  def install
    system "./configure", "--enable-lua", "--disable-lpeg-static", *std_configure_args
    system "make", "install"

    return unless OS.mac?

    # Rename vis & the matching manpage to avoid clashing with the system.
    mv bin/"vis", bin/"vise"
    mv man1/"vis.1", man1/"vise.1"
  end

  def caveats
    on_macos do
      <<~EOS
        To avoid a name conflict with the macOS system utility /usr/bin/vis,
        this text editor must be invoked by calling `vise` ("vis-editor").
      EOS
    end
  end

  test do
    binary = if OS.mac?
      bin/"vise"
    else
      bin/"vis"
    end

    assert_match "vis #{version} +curses +lua", shell_output("#{binary} -v 2>&1")
  end
end
