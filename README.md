# Mood Share

**Stay connected to yourself and your loved ones.**

Mood Share is a simple, private iOS app for checking in on how you feel — sharing
that with the people close to you, and tracking your moods over time. There are no
accounts and no data collection: everything you record stays on your device.

📱 [Download on the App Store](https://apps.apple.com/gb/app/mood-share/id6502838346)
· 🌐 [moodshare.co.uk](https://waynegeorge.github.io/moodshare/)

## What it does

- **Share how you feel** — let your partner or family know your mood before you walk
  through the door, a quick and gentle way to stay in tune.
- **Track your moods** — log how you're feeling over time and spot patterns in your
  emotions and behaviour.
- **Reflect & share** — use your history as a tool for personal reflection, or share
  it with a therapist for deeper insight.
- **Private by design** — no accounts, no tracking. Your moods stay yours.

## How a check-in works

Each mood entry is captured as a **card**. A card records:

- a **score** for how you're feeling,
- the **words** that describe the mood,
- what's been **positive**, what you **liked**, and anything you want **to share**.

Cards are collected on the Home screen, summarised over time in **Analytics**, and
kept in the **Archive** so you can look back on them.

## Project layout

This repository contains the native SwiftUI app (built under the internal name
`FeelingCards`) and the marketing/landing site served via GitHub Pages.

```
FeelingCards/            The iOS app (SwiftUI + SwiftData)
├── Models/              Core data models (Card, Theme)
├── Views/               Screens and components (Cards, Analytics, History, Share, …)
└── Utilities/           Mood logging, colours, gradients, layout, helpers
FeelingCards.xcodeproj/  Xcode project
docs/                    Landing page + privacy policy (GitHub Pages, served from /docs)
images/                  Mood artwork
```

## Building

The app is built with **SwiftUI** and **SwiftData** and targets iPhone (including
iPhone SE).

1. Open `FeelingCards.xcodeproj` in Xcode.
2. Select an iPhone simulator or a connected device.
3. Build and run (`⌘R`).

## Privacy

Mood Share collects **no personal data**. All entries stay on your device. See the
full [Privacy Policy](https://waynegeorge.github.io/moodshare/privacy.html).

## Contact

Feedback and questions: [feedback@moodshare.co.uk](mailto:feedback@moodshare.co.uk)
