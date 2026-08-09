# bradb345/homebrew-tap

Homebrew tap for my macOS apps.

## Casks

### SignalDeck

Menu bar app that captures one application's audio — Plex, or anything else you pick — runs it
through a chain of Audio Units you assemble yourself, and plays the result out your default
output device. Built to solve the dialogue-vs-explosion problem when watching movies at night.

```sh
brew install --cask bradb345/tap/signaldeck
```

Source: [bradb345/SignalDeck](https://github.com/bradb345/SignalDeck)

## Notes

These apps are ad-hoc signed rather than notarized, so downloading them from a browser makes
macOS report them as damaged.

Homebrew 6 quarantines every cask unconditionally (the old `--no-quarantine` flag is gone), so
each cask here clears the attribute itself in a `postflight` stanza. That is the same
`xattr -dr com.apple.quarantine` step you would otherwise run by hand — `brew install --cask`
just does it for you.

## Updating

```sh
brew update && brew upgrade --cask signaldeck
```
