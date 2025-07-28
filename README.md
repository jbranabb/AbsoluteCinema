# 🎬 Absolute Cinema

**Absolute Cinema** is a mobile app built with Flutter that lets users discover, search, and manage their favorite movies and TV shows. It leverages the power of **[The Movie Database (TMDB) API](https://www.themoviedb.org/documentation/api)** to deliver rich content and personalized user experiences.

---

## 🚀 Overview

This document provides a comprehensive overview of Absolute Cinema, a Flutter-based mobile application for discovering, searching, and managing movies and TV shows. The application integrates with The Movie Database (TMDB) API to provide rich content data and user personalization features.

This overview covers:
- High-level architecture
- Core functionality
- User journey

> 📌 For specific design details, see [Architecture](#-architecture).  
> 📌 For feature breakdowns, see [Core Features](#-core-features).

---

## 📱 Features

- 🔍 **Search Movies/TV Shows:** Search titles by keyword with live suggestions
- 🧠 **Smart Discovery:** Get movie recommendations based on popularity or genre
- ❤️ **Favorite List:** Save movies & shows to your personalized watchlist
- 🔐 **Authentication:** Login system for personalized experiences

---

## 🧩 Architecture

Absolute Cinema follows a scalable architecture pattern:

- **State Management:** `Bloc` or `Provider` (depending on use case)
- **Modular Design:** Organized by `features`, `services`, and `widgets`
- **API Integration:** Using `Dio` for asynchronous RESTful requests
- **Persistent Data:** Stored using `SharedPreferences` for lightweight user state

---

## ⚙️ Tech Stack

| Tech           | Use                                      |
|----------------|-------------------------------------------|
| Flutter        | Frontend UI                              |
| Dart           | Programming language                     |
| TMDB API       | Movie & TV data                          |
| Dio            | API Networking                           |
| Provider/Bloc  | State Management                         |
| SharedPreferences | Local data caching (e.g., username) |

---

## 🧑‍💻 Core Features

| Feature        | Description                                                   |
|----------------|---------------------------------------------------------------|
| Home Page      | Shows trending and recommended content                        |
| Search         | Keyword-based search with autocomplete suggestions            |
| Details Page   | Detailed view of movie/show with cast, rating, and summary    |
| Library        | Showing the Watchlist,Favortite And Rated Movies From Users   |
| Profile        | Displays user info & app theme toggle                         |

---

## 🗺️ User Journey

1. User lands on the onboarding or home screen
2. Explores trending or recommended titles
3. Uses search to find something specific
4. Opens detail page for full information
5. Saves title to favorites if desired

---

## 🛠️ How to Run

```bash
# Clone the repo
git clone https://github.com/your-username/AbsoluteCinema.git

# Get dependencies
flutter pub get

# Run the app
flutter run
---

## 📦 Download APK

You can download and install the latest release of Absolute Cinema below:

👉 [Download AbsoluteCinema.apk](https://github.com/jbranabb/AbsoluteCinema/releases/download/v1.0.0/app-release.apk)

> 🛠️ If you experience any issues, feel free to contact me at [zibranaby069@gmail.com](mailto:zibranaby069@gmail.com)
