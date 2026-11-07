class DozeBworserMcp < Formula
  desc "Persistent project browsers for concurrent MCP clients"
  homepage "https://github.com/mmng-a/doze-bworser-mcp"
  url "https://github.com/mmng-a/doze-bworser-mcp/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "47fca27a5faa9f6a3e7a247b830d4ed68abc815135a741d00fae5f6c6655fc7f"
  license all_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build
  depends_on "node"

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
    cd "runtime" do
      system "npm", "ci", "--ignore-scripts", "--no-audit", "--no-fund",
             "--cache", HOMEBREW_CACHE/"doze-bworser-mcp-npm"
    end
  end

  def install
    ENV["DOZE_RUNTIME_DIR"] = opt_libexec/"runtime"
    ENV["DOZE_NODE_PATH"] = formula_opt_bin("node")/"node"
    system "cargo", "install", *std_cargo_args
    libexec.install "runtime"
    rm libexec.glob("runtime/*.test.mjs")
  end

  def caveats
    <<~EOS
      Add the MCP server:
        codex mcp add doze-bworser-mcp -- doze-bworser-mcp

      Chrome for Testing downloads on the first open_page call.
      Close all MCP connections before upgrading, then reconnect.
    EOS
  end

  test do
    require "json"

    assert_match version.to_s, shell_output("#{bin}/doze-bworser-mcp --version")
    config = testpath/"config.json"
    config.write JSON.generate({ token: "a" * 64, socket_path: (testpath/"ipc.sock").to_s,
                                 node_path: (formula_opt_bin("node")/"node").to_s,
                                 daemon_path: (libexec/"runtime/daemon.mjs").to_s, chrome_path: "unused",
                                 operation_timeout_seconds: 20 })
    request = { jsonrpc: "2.0", id: 1, method: "initialize",
                params: { protocolVersion: "2025-11-25", capabilities: {},
                          clientInfo: { name: "brew-test", version: "1" } } }
    IO.popen([bin/"doze-bworser-mcp", "--internal", "proxy", config], "r+") do |pipe|
      pipe.sync = true
      pipe.puts JSON.generate(request)
      pipe.flush
      response = JSON.parse(pipe.gets)
      info = response.fetch("result").fetch("serverInfo")
      assert_equal "doze-bworser-mcp", info.fetch("name")
      assert_equal version.to_s, info.fetch("version")
      pipe.puts JSON.generate({ jsonrpc: "2.0", method: "notifications/initialized" })
      pipe.puts JSON.generate({ jsonrpc: "2.0", id: 2, method: "tools/list", params: {} })
      tools = JSON.parse(pipe.gets).fetch("result").fetch("tools")
      assert_includes tools.map { |tool| tool.fetch("name") }, "show_page"
    end
  end
end
