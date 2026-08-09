cask "signaldeck" do
  version "0.1.0"
  sha256 "2d1b0ea736baafe2eb3cb2932e40159ee5cd936b56f2929951d68c133c72f7d8"

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
  depends_on macos: ">= :sequoia"

  app "SignalDeck.app"

  uninstall quit: "com.bradbernard.SignalDeck"

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
