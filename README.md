# mmng-a Homebrew tap

Homebrew Formulae and Casks maintained by [mmng-a](https://github.com/mmng-a).

## Install

```sh
brew install mmng-a/tap/mcp-doze
brew install --cask mmng-a/tap/times-shot
```

Homebrew adds the tap automatically. The Formula builds from source on macOS and declares Rust as a build dependency.

Times Shot installs a prebuilt app for Apple Silicon running macOS 27.0 or later. It is not signed with Developer ID or notarized by Apple. If macOS blocks the first launch, verify the download source and use System Settings > Privacy & Security > Open Anyway.

## Packages

| Package | Project |
| --- | --- |
| `mcp-doze` | [Start local MCP servers on first use](https://github.com/mmng-a/mcp-doze) |
| `times-shot` (Cask) | [Post text and images to Slack from the menu bar](https://github.com/mmng-a/times-shot) |

## Update

```sh
brew update
brew upgrade mmng-a/tap/mcp-doze
brew upgrade --cask mmng-a/tap/times-shot
```

Installation does not change MCP client configuration. See the project's [English README](https://github.com/mmng-a/mcp-doze#readme) or [日本語README](https://github.com/mmng-a/mcp-doze/blob/main/README.ja.md) for setup and Xcode approval instructions.
