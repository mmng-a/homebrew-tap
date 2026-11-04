# mmng-a Homebrew tap

Homebrew Formulae and Casks maintained by [mmng-a](https://github.com/mmng-a).

## Install

```sh
brew install mmng-a/tap/mcp-doze
brew install mmng-a/tap/doze-bworser-mcp
```

Homebrew adds the tap automatically. Both MCP Formulae build from source and declare Rust as a build dependency. `doze-bworser-mcp` also installs Node.js and downloads a dedicated Chrome for Testing on first browser use.

Times Shot installs a prebuilt app for Apple Silicon running macOS 27.0 or later. It is not signed with Developer ID or notarized by Apple. If macOS blocks the first launch, verify the download source and use System Settings > Privacy & Security > Open Anyway.

With Homebrew 7 or later, register the tap and trust the Times Shot cask before installing:

```sh
brew tap mmng-a/tap
brew trust --cask mmng-a/tap/times-shot
brew install --cask mmng-a/tap/times-shot
```

## Packages

| Package | Project |
| --- | --- |
| `doze-bworser-mcp` | [Share Chromium across concurrent MCP clients](https://github.com/mmng-a/doze-bworser-mcp) |
| `mcp-doze` | [Start local MCP servers on first use](https://github.com/mmng-a/mcp-doze) |
| `times-shot` (Cask) | [Post text and images to Slack from the menu bar](https://github.com/mmng-a/times-shot) |

## Update

```sh
brew update
brew upgrade mmng-a/tap/mcp-doze
brew upgrade mmng-a/tap/doze-bworser-mcp
brew upgrade --cask mmng-a/tap/times-shot
```

Installation does not change MCP client configuration. See the project's [English README](https://github.com/mmng-a/mcp-doze#readme) or [日本語README](https://github.com/mmng-a/mcp-doze/blob/main/README.ja.md) for setup and Xcode approval instructions.
