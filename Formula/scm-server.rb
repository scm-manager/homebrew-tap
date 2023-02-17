class ScmServer < Formula
  desc "Share and manage your Git, Mercurial and Subversion repositories"
  homepage "https://scm-manager.org"
  url "https://packages.scm-manager.org/repository/releases/sonia/scm/packaging/unix/2.42.1/unix-2.42.1.tar.gz"
  sha256 "fd719a233ad43a89c871cee455ddf4181fb8e62605827add0f118daa3268d3d8"

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
