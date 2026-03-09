# Provider App — Flutter Mobile Application

A Flutter-based mobile application for service providers to manage orders, subscriptions, schedules, and customer communications.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Screens & Modules](#screens--modules)
- [Authentication Flow](#authentication-flow)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)

---

## Overview

The **Provider App** is a Flutter mobile application designed for service providers. It enables providers to register, complete their profile, manage their offered services, view and respond to orders, chat with customers, manage work schedules, and handle subscription plans.

---

## Features

- **Authentication** — Phone number-based login and registration with OTP verification
- **Profile Management** — Upload avatar, set hourly rate, select city, choose account type (Personal / Business), upload identity document
- **Service Selection** — Choose up to 5 service categories from a grid view
- **Order Management** — View current and previous orders, accept/reject/progress/complete orders, filter by date range
- **Real-time Chat** — Message customers with text and image support, emoji picker
- **Notifications** — Push notifications via Firebase, in-app notification list
- **Subscription Plans** — Browse, purchase, and manage subscription plans with credit card payment
- **Work Schedule** — Set availability and working hours per day of the week
- **Settings** — Dark mode toggle, language selection, privacy policy, about page, logout, account deletion
- **Map Integration** — Open order locations in installed map apps
- **Localization** — Multi-language support

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | GetX |
| Navigation | GetX Routing |
| HTTP / API | Custom API services (AuthApi, OrderApi, ChatApi, etc.) |
| Push Notifications | Firebase Messaging |
| Local Notifications | flutter_local_notifications |
| Maps | map_launcher |
| Image Handling | image_picker, image_cropper |
| Location | geolocator, location |
| UI Utilities | flutter_screenutil, flutter_svg, lottie, cached_network_image |
| Storage | SharedPreferences (via Common utility) |

---

## Project Structure

```
lib/
├── core/
│   ├── connection_service/
│   │   └── api/              # API service classes (AuthApi, OrderApi, ChatApi, MenuApi, etc.)
│   └── theme/                # Light and dark themes
├── models/                   # Data models (responses, entities)
├── screens/
│   ├── auth/
│   │   ├── login/            # Login screen + controller
│   │   ├── sign_up/          # Sign-up screen + controller
│   │   ├── complete_profile/ # Profile completion screen + controller
│   │   └── choose_service/   # Service selection screen + controller
│   ├── home/
│   │   ├── home_orders/      # Orders list screen + controller
│   │   ├── order_details/    # Order detail screen + controller
│   │   └── chat/             # Chat screen + controller
│   ├── menu_screens/
│   │   ├── menu/             # Main menu screen + controller
│   │   ├── setting/          # Settings screen + controller
│   │   ├── subscription/     # Subscription purchase screen + controller
│   │   ├── subscription_case/# Active subscription management
│   │   ├── work_times/       # Work schedule screen + controller
│   │   ├── language/         # Language selection screen + controller
│   │   ├── privacy/          # Privacy & terms pages + controller
│   │   ├── about_EU/         # About page
│   │   └── contact_us/       # Contact form screen + controller
│   ├── notifications/        # Notifications screen + controller
│   ├── pager/                # Bottom navigation host (Pager)
│   └── splash/               # Splash screen + controller
├── utils/                    # Helpers, Common, Loading, Config, etc.
└── widgets/                  # Shared reusable UI widgets
```

---

## Screens & Modules

### Splash Screen
Plays an intro video, fetches remote splash/config data, and routes the user based on their authentication and profile completion state.

### Authentication
- **Login** — Enter phone number with country code selector, receive OTP via SMS, verify with a 4-digit PIN code bottom sheet.
- **Sign Up** — Enter full name and phone number, agree to terms & privacy policy, verify OTP.

### Complete Profile
Providers fill in:
- Profile photo (cropped from gallery)
- Account type: Personal or Business
- Hourly rate
- City (dropdown)
- Identity document image
- Tax ID (optional)

### Choose Services
Grid of available service categories. Providers select up to 5 services they offer.

### Home — Orders
- Toggle between **Current** and **Previous** orders
- Filter by date range
- Location permission handling with inline retry prompt
- Navigate to Order Details on tap

### Order Details
- View service image, status badge, customer info, location with map launcher buttons
- Accept, Reject, In Progress, Complete, or Report Issue actions (contextual by status)
- Navigate to chat if order is active
- View customer rating after completion

### Chat
- Real-time messaging with a customer
- Send text messages and images (cropped from gallery)
- Emoji picker
- Pinch-to-zoom image viewer for received images
- Pull-to-load older messages

### Notifications
- Lists all push notifications with unread state
- Tapping navigates to the relevant order or chat
- Marks all as read automatically on open

### Subscription
- Browse available subscription plans
- Purchase a plan with credit card (card number, expiry, CVV)
- View and manage current subscription (cancel, renew, pay pending)

### Work Times
- View weekly schedule
- Edit start/end time and availability toggle per day using a time-picker wheel

### Menu
- Quick access to: Subscription, Work Times, Choose Services, Contact Us, Settings
- Edit profile in a bottom sheet (photo, name, hourly rate, city, identity, tax ID)

### Settings
- Toggle dark mode
- Change language
- View Privacy Policy and About pages
- Logout
- Disable / delete account

---

## Authentication Flow

```
App Launch
    │
    ▼
Splash Screen
    │
    ├─ No user session ──────────────────► Sign Up / Login
    │
    └─ User session exists
           │
           ├─ Hourly rate or identity missing ──► Complete Profile
           │
           ├─ Services not selected ────────────► Choose Services
           │
           ├─ No active subscription ───────────► Subscription
           │
           └─ All complete ─────────────────────► Pager (Home)
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / Xcode
- Firebase project configured for Android & iOS

### Setup

1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd provider_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`

4. **Run the app**
   ```bash
   flutter run
   ```

---

## Dependencies

| Package | Purpose |
|---|---|
| `get` | State management & navigation |
| `flutter_screenutil` | Responsive UI scaling |
| `firebase_messaging` | Push notifications |
| `flutter_local_notifications` | Local notification display |
| `geolocator` | Device GPS location |
| `location` | Location service requests |
| `image_picker` | Gallery / camera image selection |
| `map_launcher` | Open addresses in map apps |
| `cached_network_image` | Efficient network image caching |
| `pin_code_fields` | OTP input field |
| `emoji_picker_flutter` | Emoji picker in chat |
| `lottie` | JSON animation playback |
| `flutter_svg` | SVG icon rendering |
| `flutter_switch` | Custom toggle switch |
| `auto_size_text` | Auto-scaling text widget |
| `pull_to_refresh` | Pull-to-refresh & load-more |
| `video_player` | Splash screen video playback |
| `pinch_zoom` | Pinch-to-zoom image viewer |
| `permission_handler` | Runtime permission management |
| `url_launcher` | Open URLs externally |

---

## License

This project is proprietary. All rights reserved.
