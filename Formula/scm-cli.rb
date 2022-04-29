# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class ScmCli < Formula
  desc "SCM-Manager CLI Client"
  homepage "https://scm-manager.org/cli"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://packages.scm-manager.org/repository/scm-cli-releases/1.0.0/scm-cli_1.0.0_Darwin_arm64.tar.gz"
      sha256 "6b34076f66411896d254bb8eb0359427d94368b50322d050cf7f0b37cb008747"

      def install
        bin.install "scm"
      end
    end
    if Hardware::CPU.intel?
      url "https://packages.scm-manager.org/repository/scm-cli-releases/1.0.0/scm-cli_1.0.0_Darwin_x86_64.tar.gz"
      sha256 "d3cde36c28c22a23ea2f7f2356ac8b493ddca2ed4437303adf45480a6a7f7c4e"

      def install
        bin.install "scm"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://packages.scm-manager.org/repository/scm-cli-releases/1.0.0/scm-cli_1.0.0_Linux_arm64.tar.gz"
      sha256 "ea637f9076eac1ab7e1aabce854c5554f8ba8ac2742e918194ec3f4425226d75"

      def install
        bin.install "scm"
      end
    end
    if Hardware::CPU.intel?
      url "https://packages.scm-manager.org/repository/scm-cli-releases/1.0.0/scm-cli_1.0.0_Linux_x86_64.tar.gz"
      sha256 "360a9a848e435b0c7638978c8334a7b14e1f58926d85bee78d97b510cce06563"

      def install
        bin.install "scm"
      end
    end
  end
end
