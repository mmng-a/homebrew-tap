cask "times-shot" do
  version "0.1.0"
  sha256 "84830f460e67a8877199d0f5fddb65861e7c2b4c04e14df0032782c89642083f"

  url "https://github.com/mmng-a/times-shot/releases/download/v#{version}/TimesShot-#{version}-macos-arm64.zip"
  name "Times Shot"
  desc "Post text and images to Slack from the menu bar"
  homepage "https://github.com/mmng-a/times-shot"

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "Times Shot.app"

  caveats <<~EOS
    Times Shot is not signed with Developer ID or notarized by Apple.
    If macOS blocks the first launch, verify the download source and use
    System Settings > Privacy & Security > Open Anyway.
    https://support.apple.com/102445
  EOS
end
