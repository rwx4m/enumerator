````markdown
# 🔐 enumerator

A fast and focused web login **enumeration & brute-force toolkit** built for offensive security and CTF use cases.

This toolkit helps you:
- Enumerate valid usernames based on login responses
- Brute-force passwords for known users using response behavior

Author: [**rwx4m**](https://github.com/rwx4m)

---

## 📁 Included Tools

### 1. `Check Username`

**Function:**  
Performs username enumeration against web login forms that return different messages for valid/invalid usernames.

**Usage:**

```bash
./check-username.sh <url> <fake-password> <userlist> [cookie]
````

* `<url>`: Target login endpoint (e.g., `http://site/login.php`)
* `<fake-password>`: Random string to trigger login failure
* `<userlist>`: Wordlist of usernames
* `[cookie]`: (Optional) PHPSESSID or other session cookie if required

**Example:**

```bash
./check-username.sh http://example.com/login.php fake123 users.txt PHPSESSID=abc123
```

Only valid usernames are displayed at the end, with real-time progress feedback.

---

### 2. `Brute Password`

**Function:**
Brute-forces the password for a known valid username using standard POST-based web login forms.

**Usage:**

```bash
./brute-pass.sh <url> <username> <wordlist> [cookie]
```

* `<url>`: Target login endpoint
* `<username>`: Valid username to test
* `<wordlist>`: List of possible passwords
* `[cookie]`: (Optional) Session token, if required

**Example:**

```bash
./brute-pass.sh http://example.com/login.php admin pass-list.txt PHPSESSID=xyz456
```

The script will print the password if found, or exit silently when exhausted.

---

## ⚡ Features

* Clean, readable terminal output
* Real-time progress bar
* Silent until success
* Works on any web login with predictable response messages
* Cookie support (optional)
* Zero external dependencies

---

## 📌 Notes

* Both scripts use `curl` for HTTP requests
* Works best on targets that leak user validity via messages like:

  * `Username not found`
  * `Login failed`

---

## ✍️ Author

**rwx4m**
🔗 GitHub: [https://github.com/rwx4m](https://github.com/rwx4m)

```

---

Kalau kamu butuh file `README.md` ini dikirim langsung sebagai file `.md`, beri tahu saja — atau saya bisa bantu generate juga `.zip` repo ready-to-push. Siap bantu tahap deploy!
```
