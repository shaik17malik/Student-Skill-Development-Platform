
# Student Skill Development Platform (SSP)

A collegiate web application designed to help college students cultivate and benchmark **human-centric soft skills** (interpersonal communication, active listening, negotiation, workplace empathy, leadership, professional etiquette, time management) through structured modular curriculum, situational assessments, practical challenges evaluated by faculty, mock interview labs, personalized learning paths, and verifiable PDF transcripts.

---

## 🚀 Live Localhost URLs

The application is currently running live on localhost:

- **Frontend Client (React + Vite):** [http://127.0.0.1:5173](http://127.0.0.1:5173) (or [http://localhost:5173](http://localhost:5173))
- **Backend API (FastAPI + Uvicorn):** [http://127.0.0.1:8000](http://127.0.0.1:8000)
- **Interactive Swagger / OpenAPI Docs:** [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
- **Alternative ReDoc Documentation:** [http://127.0.0.1:8000/redoc](http://127.0.0.1:8000/redoc)
- **Health Check Status:** [http://127.0.0.1:8000/api/health](http://127.0.0.1:8000/api/health)

---

## 👥 Seeded Demo Login Credentials

The platform is seeded with pre-configured accounts representing each user role:

| Role | Email Address | Password | Permissions & Capabilities |
| :--- | :--- | :--- | :--- |
| **Student** | `student@college.edu` | `Password123!` | Take 20-question diagnostic, complete modules, submit activities, practice STAR interviews, download PDF reports, view leaderboard |
| **Faculty (sign-in disabled)** | — | — | Faculty accounts are currently rejected by the authentication API. |
| **Admin** | `admin@ssp.edu` | `AdminPass123!` | Manage all users, assign students to faculty, inspect security audit logs, configure system scoring weights & platform telemetry |

---

## 🛠️ Technology Stack

### Frontend (`client/`)
- **Framework:** React 18 with Vite
- **Styling:** Tailwind CSS **v3.4** (Dark navy/indigo collegiate theme)
- **Routing:** React Router DOM v6 with role-guarded routes (`ProtectedRoute`, `RoleRoute`)
- **HTTP Client:** Axios instance with request/response interceptors (auto-attaches JWT, handles 401 logout)
- **Visualizations:** Recharts (Radar charts for competencies, Bar charts for weekly learning velocities)
- **Icons:** Lucide React
- **Notifications:** react-hot-toast

### Backend (`server/`)
- **Framework:** FastAPI (Python 3.12, fully asynchronous) with Uvicorn
- **Database Driver:** Motor (async MongoDB driver) with Pydantic v2 document models
- **Database Resilience:** Connects to local MongoDB (`mongodb://localhost:27017`) or MongoDB Atlas. In development without a live local port 27017, seamlessly falls back to `mongomock-motor` with automatic auto-seeding.
- **Security & Cryptography:** `bcrypt` (direct threadpooled execution) and `PyJWT`
- **Rate Limiting:** SlowAPI limiter
- **Reporting:** ReportLab (official PDF skill portfolio and certificates)
- **Testing:** pytest, pytest-asyncio, httpx

---

## 📐 Platform Core Architecture

```
student-skill-development-platform/
|-- client/
|   |-- src/
|   |   |-- components/     (Button, Card, Modal, Table, Spinner, EmptyState, Badge, StatCard...)
|   |   |-- context/        (AuthContext with persistent session)
|   |   |-- layouts/        (DashboardLayout with responsive drawer & role navigation)
|   |   |-- pages/
|   |   |   |-- auth/       (Landing, Login, Register with USN, Forgot/Reset Password)
|   |   |   |-- student/    (Dashboard, Modules, Assessments, Activities, STAR Lab, Path, Progress, Achievements)
|   |   |   |-- faculty/    (Dashboard, AssignedStudents, SubmissionsReview, ModuleManage, Reports)
|   |   |   |-- admin/      (Dashboard, UserDirectory, FacultyAssignments, Analytics, AuditLogs, Settings)
|   |   |-- services/       (api.js with JWT interceptor)
|   |   |-- App.jsx         (Client route map)
|
|-- server/
|   |-- app/
|   |   |-- core/           (config.py, database.py, security.py, deps.py, errors.py, rate_limit.py)
|   |   |-- routers/        (auth, modules, assessments, activities, interviews, recommendations, achievements, progress, faculty, admin)
|   |   |-- schemas/        (Pydantic v2 validation models)
|   |   |-- services/       (scoring.py, recommendation.py, pdf.py)
|   |   |-- utils/          (object_id.py, serializers.py)
|   |-- scripts/
|   |   |-- seed.py         (Full platform curriculum & demo account seeder)
|   |   |-- create_admin.py (CLI tool to create administrative users)
|   |-- tests/              (pytest test suite)
```

---

## 💡 Key Educational Features

1. **Collegiate Soft-Skills Curriculum:** 12 human-centric behavioral disciplines (no coding or programming courses) with 24+ structured modules and bite-sized lessons.
2. **Objective Skill Assessments:** 20-question situational diagnostic test with server-side answer sanitization (answers are never leaked to client JSON).
3. **Transparent Scoring Formula:** Documented equation:
   $$\text{Overall Readiness} = (\text{Assessment Score} \times 0.40) + (\text{Activities Average} \times 0.40) + (\text{Module Progress} \times 0.20)$$
4. **Practical Roleplay Challenges:** Students submit situational responses (text + attachments) graded by faculty using criterion-by-criterion rubrics.
5. **STAR Method Mock Interview Lab:** Guided preparation for collegiate placement behavioral interviews with model answer accordions and self-evaluations.
6. **Smart Recommendations:** Automatically identifies the student's lowest scoring competencies and prioritizes targeted coursework.
7. **Official PDF Skill Portfolio:** Generates ReportLab PDF transcripts ready for employer placement verification.
8. **Gamification & Hall of Fame:** Points ledger with unique compound indexing to prevent double-awarding, badges, and a privacy-preserving leaderboard.

---

## 💻 Manual Setup & Execution Guide

### 1. Backend Setup

#### Windows (PowerShell):
```powershell
cd server
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
python -m uvicorn app.main:app --reload --port 8000
```

#### macOS / Linux (bash):
```bash
cd server
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

### 2. Frontend Setup

```bash
cd client
npm install
npm run dev -- --port 5173
```

### 3. Run Automated Tests

```powershell
cd server
.\venv\Scripts\python.exe -m pytest
```
