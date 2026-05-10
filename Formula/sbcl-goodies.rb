class SbclGoodies < Formula
  desc "Steel Bank Common Lisp system with Goodies (macOS only)"
  homepage "https://www.sbcl.org/"
  url "https://downloads.sourceforge.net/project/sbcl/sbcl/2.6.4/sbcl-2.6.4-source.tar.bz2"
  sha256 "3ba53e654b60feb7c4f50466199d6d5260f2661c711ba22d4b770b655400d57b"
  license all_of: [:public_domain,
                   "MIT", "Xerox", "BSD-3-Clause",
                   # libzstd license
                   { any_of: ["BSD-3-Clause", "GPL-2.0-only"] },
                   # programs/zstdgrep, lib/libzstd.pc.in
                   "BSD-2-Clause",
                   # lib/dictBuilder/divsufsort.c
                   "MIT"]
  compatibility_version 2
  head "https://git.code.sf.net/p/sbcl/sbcl.git", branch: "master"

  livecheck do
    url "https://sourceforge.net/projects/sbcl/rss?path=/sbcl"
  end

  bottle do
    root_url "https://github.com/li-yiyang/homebrew-sbcl-goodies/releases/download/sbcl-goodies-2.6.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5e4bb112a0873e8502a94936d65ec2bcf04f0ee9be5946f7ff7c64dbcf4852f8"
  end

  option "with-sb-ldb", "With SBCL ldb (useful for dev)"

  depends_on "sbcl" => :build
  depends_on "zstd" => :build
  depends_on :macos

  def install
    # Remove non-ASCII values from environment as they cause build failures
    # More information: https://bugs.gentoo.org/show_bug.cgi?id=174702
    ENV.delete_if do |_, value|
      ascii_val = value.dup
      ascii_val.force_encoding("ASCII-8BIT") if ascii_val.respond_to? :force_encoding
      ascii_val =~ /[\x80-\xff]/n
    end

    # Override SBCL lisp-implementation-version
    File.write("version.lisp-expr", "\"2.6.4-goodies\"")

    # Patch to use static linked libzstd
    inreplace "src/runtime/Config.arm64-darwin",  "-lzstd", "#{Formula["zstd"].opt_lib}/libzstd.a"
    inreplace "src/runtime/Config.x86-64-darwin", "-lzstd", "#{Formula["zstd"].opt_lib}/libzstd.a"

    # pull asdf
    chdir("contrib/asdf") do
      system "./pull-asdf.sh", "3.3.7" # ASDF version
    end

    xc_cmdline = "sbcl --noinform --no-userinit"

    # parallel building for faster make
    ENV["SBCL_MAKE_PARALLEL"] = "1"
    ENV["SBCL_MAKE_JOBS"] = "-j4"
    args = [
      "--prefix=#{prefix}",
      "--xc-host=#{xc_cmdline}",
      "--with-sb-core-compression",
      "--with-sb-linkable-runtime",
      "--without-gencgc", "--with-mark-region-gc",
      "--without-sb-eval", "--with-sb-fasteval",
      "--with-sb-thread",
      "--with-sb-xref-for-internals",
      "--with-sb-after-xc-core"
    ]
    args << "--with-sb-ldb" if build.with? "sb-ldb"
    system "./make.sh", *args

    ENV["INSTALL_ROOT"] = prefix
    system "sh", "install.sh"

    # resolve sbcl name conflicts
    chdir prefix do
      mv "lib/sbcl",              "lib/sbcl-goodies"
      mv "bin/sbcl",              "bin/sbcl-goodies"
      mv "share/doc/sbcl",        "share/doc/sbcl-goodies"
      mv "share/man/man1/sbcl.1", "share/man/man1/sbcl-goodies.1"
    end

    # Install sources
    bin.env_script_all_files libexec/"bin",
                             SBCL_SOURCE_ROOT: pkgshare/"src",
                             SBCL_HOME:        lib/"sbcl-goodies"
    pkgshare.install %w[contrib src]
    (lib/"sbcl-goodies/sbclrc").write <<~LISP
      (setf (logical-pathname-translations "SYS")
        '(("SYS:SRC;**;*.*.*"     #p"#{pkgshare}/src/**/*.*")
          ("SYS:CONTRIB;**;*.*.*" #p"#{pkgshare}/contrib/**/*.*")))
    LISP
  end

  test do
    (testpath/"simple.sbcl").write <<~LISP
      (write-line (write-to-string (+ 2 2)))
    LISP
    output = shell_output("#{bin}/sbcl-goodies --script #{testpath}/simple.sbcl")
    assert_equal "4", output.strip
  end
end
