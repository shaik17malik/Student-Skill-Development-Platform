# Student Skill Development Platform (SSP) - API Documentation

Base URL: `http://127.0.0.1:8000/api`

Interactive Swagger Docs: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

---

## 1. Response Envelope Format

### Success Response:
```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "timestamp": "2026-10-14T17:30:00Z"
  }
}
```

### Error Response:
```json
{
  "success": false,
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "Incorrect email or password.",
    "details": []
  }
}
```

---

## 2. Authentication Endpoints (`/api/auth`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `POST` | `/auth/register` | Public | Student registration with USN, Branch, and Semester |
| `POST` | `/auth/login` | Public | Authenticate user; returns JWT token and user info |
| `POST` | `/auth/logout` | Authenticated | Invalidate session |
| `POST` | `/auth/forgot-password` | Public | Generate reset token (logs token if no SMTP) |
| `POST` | `/auth/reset-password` | Public | Set new password with valid token |
| `GET` | `/auth/me` | Authenticated | Retrieve current user profile |

---

## 3. Curriculum & Modules (`/api/modules`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/modules/categories` | Public | List 12 soft-skills categories with module counts |
| `GET` | `/modules` | Public / Student | List modules with difficulty and student progress |
| `GET` | `/modules/{id}` | Public / Student | Retrieve module details with bite-sized lessons |
| `POST` | `/modules` | Faculty, Admin | Author and create new learning module |
| `PATCH` | `/modules/{id}` | Faculty, Admin | Update module metadata or publish status |
| `POST` | `/modules/{id}/lessons/{lesson_id}/complete` | Student | Idempotently mark lesson completed and award points |

---

## 4. Assessments & Diagnostics (`/api/assessments`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/assessments` | Public / Student | List assessments with user attempt history |
| `GET` | `/assessments/{id}` | Public / Student | Retrieve questions (sanitized without answers) |
| `POST` | `/assessments/{id}/attempts` | Student | Submit answers; returns score, strengths & weaknesses |
| `GET` | `/assessments/{id}/results` | Student | Retrieve student's latest attempt evaluation |
| `GET` | `/assessments/attempts/history` | Student | View historical assessment attempts |

---

## 5. Practical Activities (`/api/activities`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/activities` | Student | List practical workplace challenges |
| `GET` | `/activities/{id}` | Student | View activity scenario, rubrics, and submission |
| `POST` | `/activities/{id}/submissions` | Student | Submit response (draft or final with file upload) |
| `GET` | `/activities/submissions/queue` | Faculty, Admin | View queue of student submissions for grading |
| `PATCH` | `/activities/submissions/{id}/review` | Faculty, Admin | Grade submission with rubric sliders and feedback |

---

## 6. Mock Interview Lab (`/api/interviews`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/interviews/questions` | Student | Fetch behavioral and campus interview questions |
| `POST` | `/interviews/submissions` | Student | Save practice session with STAR breakdown (+20 pts) |
| `GET` | `/interviews/history` | Student | View student rehearsal logs |

---

## 7. Recommendations & Progress (`/api/recommendations`, `/api/progress`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/recommendations` | Student | Retrieve personalized learning roadmap |
| `GET` | `/progress/me` | Student | Retrieve full progress metrics & weekly chart |
| `GET` | `/progress/report.pdf` | Student | Download official ReportLab PDF skill portfolio |
| `GET` | `/progress/reports/{student_id}/pdf`| Faculty, Admin | Download specific student's PDF report |

---

## 8. Gamification & Leaderboard (`/api/achievements`, `/api/leaderboard`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/achievements/badges` | Public | List all available badges |
| `GET` | `/achievements/points` | Student | Retrieve user point ledger, level, streak |
| `GET` | `/leaderboard` | Public | Privacy-preserving student rankings by points |

---

## 9. Faculty Management (`/api/faculty`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/faculty/dashboard` | Faculty, Admin | Retrieve mentee metrics and pending review counts |
| `GET` | `/faculty/students` | Faculty, Admin | List assigned student mentees |
| `GET` | `/faculty/students/{id}` | Faculty, Admin | View single student full academic record |
| `GET` | `/faculty/reports` | Faculty, Admin | Cohort score distribution and review metrics |

---

## 10. Platform Administration (`/api/admin`)

| Method | Endpoint | Access | Description |
| :--- | :--- | :--- | :--- |
| `GET` | `/admin/analytics` | Admin | Macro platform telemetry and adoption stats |
| `GET` | `/admin/users` | Admin | Search and filter all registered platform accounts |
| `POST` | `/admin/faculty` | Admin | Provision new faculty account |
| `PATCH` | `/admin/users/{id}/status` | Admin | Activate or deactivate user access |
| `POST` | `/admin/assignments` | Admin | Assign students to faculty mentors |
| `GET` | `/admin/audit-logs` | Admin | View immutable security and administrative log |
