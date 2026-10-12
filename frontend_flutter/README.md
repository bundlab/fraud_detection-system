# FraudGuard

**Real-time Fraud Detection Platform** — Flutter Frontend

A modern, cross-platform mobile & web client for monitoring transactions, scoring fraud risk, managing alerts, and investigating cases.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Riverpod](https://img.shields.io/badge/State-Riverpod-00D8A0)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Overview

FraudGuard helps analysts and security teams:

- Monitor transactions in real time
- View ML-powered risk scores and explanations
- Triage fraud alerts
- Open and track investigation cases
- Act on high-risk activity quickly

The frontend is built with Flutter and connects to a FastAPI + AI backend (coming next).

---

## Features

| Feature | Description |
|---------|-------------|
| **Dashboard** | Live stats, risk distribution chart, recent alerts |
| **Transactions** | Filterable list by risk level + detailed risk breakdown |
| **Risk Scoring** | Visual risk score with top contributing factors (SHAP-style) |
| **Alerts** | Open / Investigating / Resolved tabs |
| **Cases** | Investigation case management with priority & status |
| **Auth** | Secure login with token storage |
| **Responsive** | Adapts from mobile → tablet → desktop |
| **Dark Mode** | System-aware light & dark themes |

---

## Screens

- **Splash** → checks auth state
- **Login** → email / password
- **Dashboard** → overview metrics + charts
- **Transactions** → list + detail with risk factors
- **Alerts** → triage inbox
- **Cases** → investigation workspace
- **Settings** → profile, preferences, logout

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter 3.x |
| Language | Dart 3.x |
| State Management | Riverpod |
| Navigation | go_router |
| HTTP Client | Dio |
| Charts | fl_chart |
| Fonts | Google Fonts (Inter) |
| Secure Storage | flutter_secure_storage |
| UI | Material 3 |

---

## Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/          # API endpoints, app constants
│   ├── theme/              # Colors, ThemeData (light + dark)
│   ├── network/            # Dio client + auth interceptor
│   └── utils/
├── features/
│   ├── auth/               # Splash, Login
│   ├── dashboard/          # Overview, stats, charts
│   ├── transactions/       # List + Detail + risk filters
│   ├── alerts/             # Alert inbox
│   ├── cases/              # Investigation cases
│   └── settings/           # Preferences & logout
├── models/                 # User, Transaction, Alert
├── services/               # Storage, API services
├── providers/              # Global Riverpod providers
├── routes/                 # go_router configuration
└── widgets/                # Shared widgets (MainScaffold, etc.)
```

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.16
- Chrome (for web) or Android/iOS emulator

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/fraud-detection-system.git
cd fraud-detection-system/frontend_flutter
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
# Web (Chrome)
flutter run -d chrome

# Linux desktop
flutter run -d linux

# Android / iOS
flutter run
```

---

## Configuration

Update the backend API URL in:

```
lib/core/constants/api_constants.dart
```

| Environment | Base URL |
|-------------|----------|
| Android emulator | `http://10.0.2.2:8000` |
| iOS simulator / desktop | `http://localhost:8000` |
| Physical device | `http://YOUR_LAN_IP:8000` |
| Production | `https://api.yourdomain.com` |

---

## Risk Levels

| Score Range | Label | Color |
|-------------|-------|-------|
| 0.00 – 0.34 | Low | Green |
| 0.35 – 0.64 | Medium | Amber |
| 0.65 – 0.84 | High | Red |
| 0.85 – 1.00 | Critical | Dark Red |

---

## Roadmap

- [x] Project scaffolding & theme
- [x] Auth screens (Splash + Login)
- [x] Responsive Dashboard
- [x] Transactions list & detail
- [x] Alerts & Cases screens
- [ ] Wire real FastAPI backend
- [ ] Riverpod providers for live data
- [ ] Pagination & search
- [ ] Push notifications for high-risk alerts
- [ ] Role-based access (Analyst / Admin)
- [ ] Offline cache

---

## Backend

The companion backend lives in:

```
../backend_fastapi/
../ai_services/
```

Stack: **FastAPI · PostgreSQL · Redis · XGBoost / LightGBM · MLflow**

---

## Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

This project is licensed under the MIT License.

---

<p align="center">
  Built with Flutter for the FraudGuard platform
</p>
```
