# 🔍 USERNAME Enum

A fast and lightweight **username enumeration script** for web login forms that leak user validity based on error messages (e.g., "Username not found" vs "Login failed").

Created for pentesting and CTF scenarios where server responses allow user enumeration via timing or content differences.

---

## 🔧 Features
- Terminal-based user enumeration
- Automatic progress bar display
- Optional cookie/session injection

---

## 📌 Usage

```bash
./check-username.sh <url> <fake-password> <userlist> [cookie]
