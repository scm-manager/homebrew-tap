class ScmServer < Formula
  desc "Share and manage your Git, Mercurial and Subversion repositories"
  homepage "https://scm-manager.org"
  url "https://packages.scm-manager.org/repository/releases/sonia/scm/packaging/unix/2.45.1/unix-2.45.1.tar.gz"
  sha256 "b091b8ce3f3054b690d636bc3d95d29bc45885ff96b498448951ba55c90b8342"

  depends_on "openjdk@11"
  conflicts_with "scm-manager", because: "both install the same binaries"

  def install
    libexec.install Dir["*"]

    (bin/"scm-server").write <<~EOS
      #!/bin/bash
      BASEDIR="#{libexec}"
      REPO="#{libexec}/lib"
      export JAVA_HOME=#{Formula["openjdk@11"].opt_prefix}/libexec/openjdk.jdk/Contents/Home
      "#{libexec}/bin/scm-server" "$@"
    EOS
    chmod 0755, bin/"scm-server"
  end

  plist_options manual: "scm-server"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/scm-server</string>
            <string>start</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
        </dict>
      </plist>
    EOS
  end
end
