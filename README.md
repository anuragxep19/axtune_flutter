# AxTune  

![Flutter](https://img.shields.io/badge/flutter-3.19.2-blue.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-blue.svg)](LICENSE)

AxTune is a Flutter-based music player crafted as part of a hands-on exploration into building rich, offline-first audio playback.
This project helped me dive deeper into MVVM architecture, responsive UI composition, local storage access, and seamless audio playback experiences on mobile.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Tech Stack](#tech-stack)
3. [Project Structure](#project-structure-simplified-overview)
4. [Features](#features)
   1. [Music Playback](#music-playback)
   2. [File Access \& Permissions](#file-access--permissions)
   3. [Architecture](#architecture)
   4. [UI \& Design](#ui--design)
5. [Screenshots](#screenshots)
6. [Credits](#credits)
7. [License](#license)
8. [Author](#author)

---

## Getting Started

1. **Clone the repository**:

   ```bash
   git clone https://github.com/anuragxep19/axtune_flutter.git
   cd axtune_flutter
   ```

1. **Install dependencies**:

   ```bash
   flutter pub get
    ```

1. **Run**:

    ```bash
    flutter run
    ```

---

## Tech Stack

- **Core Framework**: Flutter, Dart
- **Audio Playback**: `just_audio`
- **State Management**: `Provider`
- **Permission Handling**: `permission_handler`

---

## Project Structure (Simplified Overview)

```tree

axtune/
├── lib/                          # Main application source
│   ├── model/                    # Music data models
│   ├── utils/                    # Permission handling and utilities
│   ├── view/                     # UI screens and shared widgets
│   │   ├── home/                 # Music list screen and drawer
│   │   ├── player/               # Music player UI and about sheet
│   │   └── widget/               # Custom buttons, containers, painters
│   ├── view_models/              # ViewModel logic using MVVM pattern
│   └── main.dart                 # App entry point
│
├── assets/                       # App resources and media
│   ├── icons/                    # App logos and launcher assets
│   └── licenses/                 # Auto-generated OSS licenses
│   ├── musics/                   # Bundled audio files (MP3)
│   └── readme/                   # Screenshots for documentation
│
├── pubspec.yaml                  # Project dependencies and assets
├── README.md                     # Project documentation
├── LICENSE                       # License information (MIT)
└── .gitignore                    # Files and folders to exclude from version control
                

```

---

## Features

### Music Playback

- Plays audio from bundled assets and device storage
- Auto-scans local storage for .mp3 files
- Supports continuous playback (playlist-style)
- Play/Pause, Next/Previous, Seek ±10 seconds
- Slider with toggleable current/remaining duration

### File Access & Permissions

- Runtime permission handling using permission_handler
- Requests storage and "Manage All Files" access
- Handles permission prompts and fallback gracefully

### Architecture

- MVVM structure with provider for state management
- Clear separation between UI, logic, and data models

### UI & Design

- Splash screen with app icon
- Music list with gradient neumorphic styling and glassmorphism
- Custom drawer with transparent blur effect
- Player view with neumorphic controls and shaped buttons
- About section with music metadata in a bottom sheet
  
---

## Screenshots

<details>
  <summary>Click to expand screenshots</summary>

  <br/>

  | Splash | Home | Drawer |
  |:-----:|:----:|:----:|
  | <img src="assets/readme/splash.png" alt="Splash" width="200"/> |  <img src="assets/readme/home.png" alt="Home" width="200"/> |<img src="assets/readme/drawer.png" alt="Drawer" width="200"/> |

  | Play | About |
  |:---------------:|:----:|
  | <img src="assets/readme/player.png" alt="Play" width="200"/> | <img src="assets/readme/about.png" alt="About" width="200"/> |

</details>

---

## Credits

- [Shields.io](https://shields.io/) – Used for project badges  
- [IconKitchen](https://icon.kitchen) – Helped generate the app’s logo assets  
- [Flutter](https://flutter.dev/) – Core framework for building the UI  

- [The open-source community](https://pub.dev/) – For architectural inspiration and reusable packages
- Music credits are included within the app's About section.

---

## License

- **MIT License** – see [LICENSE](LICENSE)  
- **Third-Party Licenses** – see `assets/licenses/oss_licenses.json`

---

## Author

**Anurag E P**  
[GitHub: @anuragxep19](https://github.com/anuragxep19)  

---
