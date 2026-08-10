cask "signaldeck" do
  version "0.1.6"
  sha256 "335fdcad0ab601fdc5ebf5003f8de1a438bf69655f52b5b221fbed56c0540d02"

  url "https://github.com/bradb345/SignalDeck/releases/download/v#{version}/SignalDeck-#{version}.zip",
      verified: "github.com/bradb345/SignalDeck/"
  name "SignalDeck"
  desc "Menu bar app that runs one application's audio through a rack of Audio Units"
  homepage "https://github.com/bradb345/SignalDeck"

  livecheck do
    url :url
    strategy :github_latest
  end

  # SignalDeck ships ad-hoc signed rather than notarized, so it never self-updates.
  auto_updates false
  # CATapDescription-based process taps require macOS 14.4+; the app targets 15.0.
  depends_on macos: :sequoia

  app "SignalDeck.app"

  uninstall quit: "com.bradbernard.SignalDeck"

  # SignalDeck is ad-hoc signed rather than notarized (no Apple Developer certificate),
  # so Gatekeeper blocks it outright once Homebrew's download carries the quarantine
  # attribute. Homebrew 6 quarantines every cask unconditionally -- the --no-quarantine
  # flag no longer exists -- so clear it here. This is exactly the `xattr -dr` step a
  # manual installer would run by hand, just automated.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SignalDeck.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/SignalDeck",
    "~/Library/Preferences/com.bradbernard.SignalDeck.plist",
    "~/Library/Saved Application State/com.bradbernard.SignalDeck.savedState",
  ]

  caveats <<~EOS
    SignalDeck needs permission to capture system audio. On first launch, approve the
    prompt, or enable SignalDeck under:

      System Settings -> Privacy & Security -> Screen & System Audio Recording

    It records no screen content -- that is simply the category macOS files
    system-audio capture under.

    SignalDeck has no Dock icon. Look for the waveform in the menu bar.
  EOS
end
