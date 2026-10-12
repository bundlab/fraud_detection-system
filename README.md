# FraudGuard

### Real-Time Fraud Detection System

A production-oriented platform that detects, scores, and investigates fraudulent transactions in real time -- combining a modern Flutter client, a high-performance FastAPI backend, and machine-learning models.

![Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?logo=flutter)
![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?logo=fastapi)
![Python](https://img.shields.io/badge/AI-Python-3776AB?logo=python)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-4169E1?logo=postgresql)
![Docker](https://img.shields.io/badge/Infra-Docker-2496ED?logo=docker)
![License](https://img.shields.io/badge/License-MIT-green)

---

## What is FraudGuard?

FraudGuard is an end-to-end fraud detection system designed for fintech, banking, and payment platforms. It ingests transactions, scores them with a hybrid **rules + machine learning** engine, surfaces high-risk alerts to analysts, and supports full investigation workflows.

**Key capabilities**

| Capability | Description |
|------------|-------------|
| Real-time scoring | Sub-second risk scores for every transaction |
| Explainable AI | SHAP-style feature contributions with every score |
| Alert triage | Open -> Investigating -> Resolved workflow |
| Case management | Assign, track, and resolve fraud cases |
| Feedback loop | Analyst labels improve future models |
| Cross-platform UI | Flutter app for web, Android, and iOS |

---

## Architecture

```
+---------------------+
|   Flutter Client    |  Mobile / Web / Desktop
|   (FraudGuard UI)   |
+----------+----------+
           | HTTPS / REST
+----------v----------+
|   FastAPI Backend   |  Auth / Transactions / Alerts / Cases
+----------+----------+
           |
     +-----+-----+
     v           v
+---------+  +--------------+
|PostgreSQL|  |  AI Service  |  Feature eng / Model inference / Explainability
| + Redis |  | (ML models)  |
+---------+  +--------------+
```

---

## Repository Structure

```
fraud_detection-system/
|
|-- frontend_flutter/     # Cross-platform Flutter client
|-- backend_fastapi/      # REST API (auth, transactions, alerts, cases)
|-- ai_services/          # ML training, inference & explainability
|-- database/             # Schema, migrations, seed data
|-- docker/               # Docker Compose & deployment configs
|-- docs/                 # Architecture, API, ML pipeline docs
|-- README.md
|-- LICENSE
|-- .gitignore
```

| Folder | Responsibility |
|--------|----------------|
| `frontend_flutter/` | UI for analysts -- dashboard, transactions, alerts, cases |
| `backend_fastapi/` | Business logic, auth (JWT), API endpoints |
| `ai_services/` | Model training, real-time scoring, SHAP explanations |
| `database/` | PostgreSQL schema, Alembic migrations |
| `docker/` | One-command local & production deployment |
| `docs/` | Technical documentation |

---

## Tech Stack

### Frontend
- **Flutter 3** + Dart
- Riverpod (state management)
- go_router (navigation)
- Dio (HTTP)
- fl_chart (visualizations)
- Material 3 + dark mode

### Backend
- **FastAPI** (async Python)
- Pydantic v2
- SQLAlchemy / Alembic
- JWT + OAuth2
- Redis (cache & queues)

### AI / ML
- scikit-learn / XGBoost / LightGBM
- SHAP (explainability)
- MLflow (experiment tracking)
- Optional: PyTorch for deep models

### Infrastructure
- PostgreSQL + Redis
- Docker & Docker Compose
- Nginx (optional reverse proxy)

---

## Getting Started

### Prerequisites

- Docker & Docker Compose (recommended)
- Flutter SDK >= 3.16 (for frontend development)
- Python 3.11+ (for backend / AI development)

### Quick start with Docker

```bash
git clone https://github.com/YOUR_USERNAME/fraud-detection-system.git
cd fraud_detection-system

# Start all services
cd docker
docker compose up --build
```

Services will be available at:

| Service | URL |
|---------|-----|
| API | http://localhost:8000 |
| API Docs (Swagger) | http://localhost:8000/docs |
| Frontend (web) | http://localhost:3000 |

### Frontend only

```bash
cd frontend_flutter
flutter pub get
flutter run -d chrome
```

### Backend only

```bash
cd backend_fastapi
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

---

## Core Features

### 1. Transaction Monitoring
Ingest and display transactions with amount, merchant, location, device, and real-time risk score.

### 2. Risk Scoring Engine
Hybrid approach:
- Hard rules (velocity, amount thresholds, new device, etc.)
- ML model (XGBoost / LightGBM) for complex patterns
- Returns score (0-1) + risk level + top contributing features

### 3. Alert Management
Automatic alert creation when score exceeds threshold. Analysts can investigate, assign, and resolve.

### 4. Case Investigation
Group related transactions into cases, add notes, mark outcomes (fraud / legitimate), and feed labels back into the model pipeline.

### 5. Dashboard
At-a-glance metrics: volume, flagged count, open alerts, average risk, and risk distribution.

---

## Risk Levels

| Score | Level | Color | Action |
|-------|-------|-------|--------|
| 0.00 - 0.34 | Low | Green | Auto-approve |
| 0.35 - 0.64 | Medium | Amber | Monitor |
| 0.65 - 0.84 | High | Red | Review |
| 0.85 - 1.00 | Critical | Dark Red | Block / escalate |

---

## Roadmap

- [x] Project structure & architecture
- [x] Flutter frontend (screens, theme, navigation)
- [ ] FastAPI backend (auth, CRUD, scoring endpoint)
- [ ] AI service (training + inference + SHAP)
- [ ] Database schema & migrations
- [ ] Docker Compose full stack
- [ ] Analyst feedback -> model retraining loop
- [ ] Role-based access control
- [ ] Push notifications
- [ ] Production deployment guides

---

## Documentation

Detailed docs will live in the `docs/` folder:

| Document | Content |
|----------|---------|
| `architecture.md` | System design & data flow |
| `api.md` | REST API reference |
| `data_model.md` | Database schema |
| `ml_pipeline.md` | Feature engineering & model lifecycle |
| `deployment.md` | Docker, CI/CD, production checklist |

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

Please keep commits focused and follow existing code style.

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

Built as a modern reference implementation of a real-world fraud detection platform -- combining clean architecture, explainable ML, and a polished analyst experience.

---

<p align="center">
  <strong>FraudGuard</strong> · Detect · Explain · Investigate
</p>
