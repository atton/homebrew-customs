class Utf8proc < Formula
  desc "Clean C library for processing UTF-8 Unicode data"
  homepage "http://julialang.org/utf8proc/"
  url 'https://github.com/atton/utf8proc', using: :git, tag: 'ambiguous-2.2.0'
  version "2.2.0"

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <string.h>
      #include <utf8proc.h>

      int main() {
        const char *version = utf8proc_version();
        return strnlen(version, sizeof("1.3.1-dev")) > 0 ? 0 : -1;
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lutf8proc", "-o", "test"
    system "./test"
  end
end
