class ScmServer < Formula
  desc "Share and manage your Git, Mercurial and Subversion repositories"
  homepage "https://scm-manager.org"
  url "https://packages.scm-manager.org/repository/releases/sonia/scm/packaging/unix/3.9.0/unix-3.9.0.tar.gz"
  sha256 "701cc8979232e26170978ec0c90ac31796b68a4393f3d9baa2f27ea2c657342d"

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
