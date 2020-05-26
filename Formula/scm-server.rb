class ScmServer < Formula
  desc "The easiest way to share and manage your Git, Mercurial and Subversion repositories"
  homepage "https://scm-manager.org"
  url "https://packages.scm-manager.org/repository/public/sonia/scm/scm-server/2.0.0-rc7/scm-server-2.0.0-rc7-app.tar.gz"
  sha256 "3f4b16b89b131c76a2bba9935490738b7c02c002dc446248cd388f7a8f086c94"

  depends_on "openjdk@11"
  conflicts_with "scm-manager", :because => "both install the same binaries"


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

  plist_options :manual => "scm-server"

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
