# 📝 Todo App

A simple and intuitive Todo app built with **Flutter** and **Riverpod**.  
Easily add, view, and organize tasks into **Upcoming** and **History** views with date grouping, persistent storage, and task status tracking.

---

## 📱 Screenshots

| Upcoming Tasks | History Tasks |
|----------------|---------------|
| ![Upcoming](https://i.postimg.cc/y8bYLQgv/Whats-App-Image-2025-04-25-at-2-41-17-PM.jpg) | ![History](https://i.postimg.cc/nLwxFCY2/Whats-App-Image-2025-04-25-at-2-41-16-PM.jpg) |
---

## 🚀 Features

- Add tasks with title, description, and date
- Categorized into:
  - **Upcoming Tasks** – Future tasks sorted by date
  - **History Tasks** – Past or completed tasks grouped by date
- Persistent local storage using `SharedPreferences`
- Grouped and sorted task list views
- Status auto-updated for missed (pending) tasks
- Riverpod for state management

---

## 🛠️ Tech Stack

- Flutter
- Riverpod
- SharedPreferences
- Intl (for date formatting)

---

## 📦 Installation

```bash
git clone https://github.com/your-username/todo-app.git
cd todo-app
flutter pub get
flutter run
