<h1 align="center">
  <br>
  <img src="https://framerusercontent.com/images/RFK4vs0kn8pRMuOO58JeyoemXA.png?scale-down-to=256" alt="boring.notch (meloer fork)" width="120">
  <br>
  boring.notch · meloer fork
  <br>
</h1>

<p align="center">
  <b>把 MacBook 的刘海变成你的效率工具箱</b><br>
  音乐控制 · 日历 · 文件架 · AI 用量追踪 · 速记板
</p>

<p align="center">
  <a href="https://github.com/meloer101/boring.notch/releases/latest">
    <img src="https://img.shields.io/github/v/release/meloer101/boring.notch?style=flat-square&color=blue" alt="Latest Release" />
  </a>
  <img src="https://img.shields.io/badge/platform-macOS%2014%2B-lightgrey?style=flat-square" alt="macOS 14+" />
  <img src="https://img.shields.io/badge/swift-5.9-orange?style=flat-square" alt="Swift 5.9" />
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/license-GPLv3-green?style=flat-square" alt="GPLv3" />
  </a>
</p>

---

## About This Fork

This is a personal fork of [**boring.notch**](https://github.com/TheBoredTeam/boring.notch) by [The Bored Team](https://github.com/TheBoredTeam). The original project is an amazing open-source macOS app that transforms the MacBook notch into a dynamic control center — all credit for the core idea and the vast majority of the codebase goes to them.

This fork adds a few features I wanted for my own workflow that didn't fit the upstream project's direction. If you're looking for the main, community-supported version, head to the [original repo](https://github.com/TheBoredTeam/boring.notch).

## What's Different Here

### 🤖 AI Quota Tab
Track your Claude and Codex API usage directly in the notch — see remaining quota, usage breakdown, and refresh status at a glance. No need to open a browser to check if you've hit your limits.

### 📝 Scratchpad
A quick-access scratchpad that lives in your notch. Paste, type, copy, and clear temporary text without switching apps. Text persists across restarts.

### Everything Else
All the great features from the upstream project are included:

- 🎧 **Music Control** — playback controls with live visualizer
- 📆 **Calendar** — upcoming events at a glance
- 📚 **File Shelf** — drag-and-drop staging area with AirDrop
- 🔋 **Battery** — charging indicator and percentage
- 🎚️ **System HUD** — volume, brightness, and backlight replacements
- 📷 **Mirror** — quick camera preview
- 👆🏻 **Gestures** — customizable gesture controls

## Install

**Requirements:** macOS 14 Sonoma or later · Apple Silicon or Intel

### Download

Grab the latest `.zip` from [**Releases**](https://github.com/meloer101/boring.notch/releases/latest), unzip, and move `boringNotch.app` to `/Applications`.

Since the app isn't signed with an Apple Developer certificate, you'll need to remove the quarantine flag on first launch:

```bash
xattr -dr com.apple.quarantine /Applications/boringNotch.app
```

### Build from Source

```bash
git clone https://github.com/meloer101/boring.notch.git
cd boring.notch
open boringNotch.xcodeproj
# Hit Cmd+R in Xcode to build and run
```

Requires Xcode 16+ and macOS 14+.

## License

This project is licensed under the [GNU General Public License v3.0](./LICENSE), same as the original.

## Acknowledgments

- [**The Bored Team**](https://github.com/TheBoredTeam) — created and maintains the original [boring.notch](https://github.com/TheBoredTeam/boring.notch), which this fork is based on. They did the heavy lifting.
- [**NotchDrop**](https://github.com/Lakr233/NotchDrop) — inspired the Shelf feature
- [**MediaRemoteAdapter**](https://github.com/ungive/mediaremote-adapter) — enabled Now Playing support on macOS 15.4+

For a full list of third-party licenses, see [THIRD_PARTY_LICENSES.md](./THIRD_PARTY_LICENSES.md).
