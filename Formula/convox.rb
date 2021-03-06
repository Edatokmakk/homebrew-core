class Convox < Formula
  desc "Command-line interface for the Rack PaaS on AWS"
  homepage "https://convox.com/"
  url "https://github.com/convox/rack/archive/20180406232320.tar.gz"
  sha256 "7aefc457cdfb28815f78ad65dc98e35ad250a56695a8bf968c1291d17fd2b8b7"

  bottle do
    cellar :any_skip_relocation
    sha256 "f79d8f9ca7cb9d3bcd44e09d188d5128806215015888cf12605eef2caefeb652" => :high_sierra
    sha256 "5cf6ca64741bf373ebcafcfcb7a746b4254a8782c18ad0eba144eb070e55014e" => :sierra
    sha256 "f58537ee0e484de1f72901325bad1d28d90ae071d71a8df74969ac5a5bc7b2fc" => :el_capitan
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/convox/rack").install Dir["*"]
    system "go", "build", "-ldflags=-X main.Version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
  end

  test do
    system bin/"convox"
  end
end
