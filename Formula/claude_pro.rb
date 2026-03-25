# frozen_string_literal: true

class ClaudePro < Formula
  desc "Run Claude Code in a non-interactive loop"
  homepage "https://github.com/ilya-savinkov/ClaudePro"
  url "https://rubygems.org/downloads/claude_pro-0.1.0.gem"
  sha256 "9aab564f2fe1c7133525982d61e9c101ea95faa3a0d56d95ca1b5f974b69913d"
  license "MIT"

  depends_on "ruby" => ">= 4.0"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "install", "--no-document", cached_download
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec / "bin", GEM_HOME: ENV["GEM_HOME"])
  end

  def caveats
    <<~CAVEATS
      claude_pro requires Claude Code CLI (>= 2.1.76) to be installed separately.

      Install it via npm:
        npm install -g @anthropic-ai/claude-code

      Verify the installation:
        claude --version

      For more information, visit:
        https://docs.anthropic.com/en/docs/claude-code
    CAVEATS
  end

  test do
    # Verify version output contains the formula version
    assert_match version.to_s, shell_output("#{bin}/claude-pro --version")

    # Verify help lists the expected subcommands
    help_output = shell_output("#{bin}/claude-pro help")
    assert_match "bug-hunter", help_output
    assert_match "architector", help_output
    assert_match "doctor", help_output
  end
end
