class McpDoze < Formula
  desc "Start stdio MCP servers on first use"
  homepage "https://github.com/mmng-a/mcp-doze"
  url "https://github.com/mmng-a/mcp-doze/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "081a1f0575f7318605331c4df18a40106a11e9fd238a0be6d3f508fb52eb59d8"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    require "json"

    assert_match version.to_s, shell_output("#{bin}/mcp-doze --version")

    manifest = testpath/"plugins/cache/example/plugin/1.0.0/.mcp.json"
    manifest.dirname.mkpath
    manifest.write JSON.generate({
      "mcpServers" => {
        "example" => { "command" => "/usr/bin/false", "args" => [], "env" => { "EXAMPLE" => "kept" } },
      },
    })
    system bin/"mcp-doze", "codex", "sync-plugins", "--codex-home", testpath

    server = JSON.parse(manifest.read).fetch("mcpServers").fetch("example")
    assert_equal File.realpath(bin/"mcp-doze"), server.fetch("command")
    assert_equal "/usr/bin/false", server.fetch("args").last
    assert_equal({ "EXAMPLE" => "kept" }, server.fetch("env"))
  end
end
