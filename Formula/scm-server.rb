class ScmServer < Formula
  desc "Share and manage your Git, Mercurial and Subversion repositories"
  homepage "https://scm-manager.org"
  url "https://packages.scm-manager.org/repository/releases/sonia/scm/packaging/unix/2.46.4/unix-2.46.4.tar.gz"
  sha256 "f6eb478d888847ea338e611400629ba1230e0ea9becda40120de12f50b9b5ce5"

  depends_on "openjdk@17"
  conflicts_with "scm-manager", because: "both install the same binaries"

  def install
    libexec.install Dir["*"]

    (bin/"scm-server").write <<~EOS
      #!/bin/bash
      BASEDIR="#{libexec}"
      REPO="#{libexec}/lib"
      export JAVA_HOME=#{Formula["openjdk@17"].opt_prefix}/libexec/openjdk.jdk/Contents/Home
      "#{libexec}/bin/scm-server" "$@"
    EOS
    chmod 0755, bin/"scm-server"
  end

  service do
    run opt_bin/"scm-server"
  end
end
