require 'formula'

class Simplelocalize < Formula
  desc "Command-line tool for SimpleLocalize"
  homepage "https://github.com/simplelocalize/simplelocalize-cli"

  url "https://github.com/simplelocalize/simplelocalize-cli/releases/download/2.5.1/simplelocalize-cli-2.5.1.jar"
  sha256 "0b4cdfe50272127a5be62f9e6dede13ca8e30605f3e2dd1aad7de76d12bfae58"
  license "MIT"

  depends_on "openjdk@21" => :build if Hardware::CPU.arm?
  depends_on "openjdk@21" => :build if Hardware::CPU.intel?
  
  def install
    libexec.install "simplelocalize-cli-2.5.1.jar"
    (bin/"simplelocalize").write <<~EOS
      #!/bin/bash
      exec java -jar "#{libexec}/simplelocalize-cli-2.5.1.jar" "$@"
    EOS
    chmod "+x", bin/"simplelocalize"
  end

  test do
    output = shell_output("#{bin}/simplelocalize --version 2>&1")
    assert_match "https://github.com/simplelocalize/simplelocalize-cli/releases", output
    assert_match "2.5.1", output
  end
end
