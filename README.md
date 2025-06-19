# 🛠️ Worker Task Management System (WTMS)

A mobile application developed using Flutter to manage worker tasks efficiently. WTMS allows workers to register, log in, view assigned tasks, submit work completion reports, and maintain a personal profile. The app connects to a PHP-MySQL backend via HTTP.

## 📲 Key Features

### 🔐 Authentication
- Worker registration and login with SHA1 password hashing
- Session persistence using SharedPreferences
- “Remember Me” functionality for auto-login

### 📝 Task List for Workers
- View tasks assigned to the logged-in worker
- Task info includes: title, description, assigned date, due date, and status
- Data retrieved via `get_works.php` API

### 📤 Work Completion Submission
- Select a task and submit a completion report
- Task title is pre-filled (read-only)
- Completion text is sent via `submit_work.php` and saved in `tbl_submissions`

### 👤 Profile Management
- View personal information (name, email, phone, etc.)


