# 🚀 NEP (National Education Platform)

## Developer Handoff Pack for Codex

---

# 1. 🧠 PRODUCT OVERVIEW

NEP is a **mobile-first learning + exam platform** for:

* Nursing students (Phase 1)
* Teacher training colleges (Phase 2)
* Health colleges (Phase 3)

Core idea:
👉 **Offline-first learning + centralized content + AI Companion + national exam system**

---

# 2. 🧱 CORE APP MODULES (FINAL STRUCTURE)

### Student App Tabs (Bottom Navigation)

1. **Home**
2. **Lectures**
3. **Quizzes**
4. **Exam Hall**
5. **Companion (AI Tutor)**
6. **Library**

---

# 3. 🔁 CORE USER FLOW

### Onboarding

* Input:

  * Phone/Email
  * Programme (e.g., Nursing)
  * Level (100, 200, 300)
  * Institution

🚫 No semester selection

---

### Learning Flow

```
Lectures → Programme → Course → Topic
```

Inside Topic:

* Lecture (video)
* Notes (text)
* Topic Quiz
* Companion

---

### Library Flow

* Sections:

  * Lectures
  * Notes
  * Quizzes
* Offline storage from:

  * App
  * School Server

---

# 4. 🧑‍🏫 CONTENT CONTROL (CRITICAL RULE)

🚨 VERY IMPORTANT

* ONLY ADMIN uploads content
* NO tutor uploads allowed

### Tutor Role:

* AI Companion only
* Guides learning
* Does NOT introduce new content

---

# 5. 🤖 COMPANION (AI TEACHER)

Personality:

* Calm
* Patient
* Step-by-step teacher
* Asks follow-up questions
* Pushes for understanding

### Behavior:

* Uses ONLY admin-approved content
* Asks MCQs
* Gives feedback:

  * Correct → reinforce
  * Wrong → explain gently

### Limits:

* Free users → limited daily usage
* Premium → unlimited

---

# 6. 📝 QUIZ SYSTEM

### Types:

* Topic Quiz
* Course Practice
* Level Practice
* Mock Exam

### Source:

```
Programme → Course → Topic → Question Bank
```

### Behavior:

* Randomized questions
* Immediate feedback (practice mode)

---

# 7. 🏫 EXAM HALL (VERY IMPORTANT MODULE)

### Exams:

* Mid-Semester Exam
* End of Semester Exam
* End of Year Exam
* Licensure Exam

---

### Access Rules:

* Only visible when:

  * Connected to **School Server**
  * Exam window is active

---

### Exam Behavior:

✅ Time-controlled
✅ Autosave answers
✅ Navigation allowed between questions
🚫 Cannot exit exam session
🚫 Cannot switch tabs

### Exam Lock:

* Once started → session locked
* Submit required to exit

---

### Post Exam:

* Practice exams → instant results
* Formal exams → delayed (controlled by institution)

---

# 8. 📚 LIBRARY SYSTEM

### Structure:

* Lectures
* Notes
* Quizzes

---

### KEY RULE:

✅ Downloaded content remains on device
🚫 Locked after subscription expires

Example:

* Student downloads lecture
* Subscription expires
* Lecture:

  * Still visible
  * Shows **“Locked”**
  * Cannot open

---

# 9. 📡 SCHOOL SERVER SYSTEM (CORE INNOVATION)

### Concept:

* Each school has a **local wireless server**
* Students connect via Wi-Fi (no data cost)

---

### App Behavior:

* Detects server automatically
* Allows:

  * Download lectures
  * Download notes
  * Download quizzes

---

### Sync System:

* Servers connected to central admin via internet
* Admin pushes updates remotely

👉 Students NEVER pay for data

---

# 10. 💳 SUBSCRIPTION SYSTEM

### Plans:

#### 1. Monthly

* Duration: 30 days

#### 2. Semester Bundle

* Duration: 3 months

---

### Flow:

1. User selects plan
2. Pays via Mobile Money
3. Gets receipt
4. Access activated

---

### Lifecycle:

| Stage                | Behavior          |
| -------------------- | ----------------- |
| Active               | Full access       |
| 7 days before expiry | Warning shown     |
| Expired              | Downgrade to Free |
| After expiry         | Content locked    |

---

### Free Plan Limitations:

* Limited quizzes
* Limited Companion usage
* Cannot access premium lectures

---

# 11. 🔒 KEY SYSTEM RULES (NON-NEGOTIABLE)

* No semester selection
* Admin-only content uploads
* Companion does NOT create content
* Exams must be:

  * Locked
  * Autosaving
  * Time-controlled
* Subscription must:

  * Expire correctly
  * Show warning
  * Downgrade user
* Downloaded content:

  * Must remain
  * Must lock after expiry

---

# 12. 🧩 TECHNICAL ARCHITECTURE (FOR CODEX)

### Frontend (Mobile App)

Recommended:

* Flutter OR React Native

---

### Backend

* Node.js / Firebase / Supabase

---

### Core Services:

* Auth Service
* Content Service
* Quiz Engine
* Exam Engine
* Subscription Service
* Server Sync Service

---

### Special Systems:

* Offline-first storage
* Local server detection (Wi-Fi based)
* Content sync engine

---

# 13. 🗂️ REPO STRUCTURE (SUGGESTED)

```
nep/
 ├── mobile-app/
 ├── backend/
 ├── admin-dashboard/
 ├── server-node/
 ├── AGENTS.md
 └── README.md
```

---

# 14. 🎯 FIRST TASKS FOR CODEX

### Task 1:

Convert the prototype into a Flutter mobile app with the same navigation structure

### Task 2:

Build authentication + onboarding flow

### Task 3:

Create Lecture module with Programme → Course → Topic hierarchy

### Task 4:

Implement Library with offline storage and locked content behavior

### Task 5:

Build Quiz engine with randomized questions

### Task 6:

Build Exam Hall with locked session + autosave

-

---
