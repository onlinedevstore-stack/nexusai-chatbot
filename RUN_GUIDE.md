# NexusAI Chatbot — Run & Setup Guide

> **Stack:** FastAPI · LangChain · Ollama · Google Gemini · SQLite · Bootstrap 5

---

## Prerequisites

Before running the app, make sure you have the following installed:

| Requirement | Version | Check |
|-------------|---------|-------|
| Python | 3.10 or higher | `python --version` |
| pip | latest | `pip --version` |
| Ollama | latest | [ollama.com/download](https://ollama.com/download) |
| Git (optional) | any | `git --version` |

---

## Project Structure

```
chatbot_1/
├── backend/
│   ├── main.py              ← FastAPI application
│   ├── database.py          ← SQLite setup
│   ├── models.py            ← ORM models
│   ├── schemas.py           ← Pydantic schemas
│   ├── .env                 ← API keys (DO NOT commit)
│   ├── chatbot.db           ← Auto-created SQLite database
│   ├── requirements.txt     ← Python dependencies
│   └── routers/
│       ├── config.py        ← Bot config API
│       └── chat.py          ← Chat + history API
├── frontend/
│   ├── index.html           ← Main UI
│   ├── css/style.css        ← Dark theme styles
│   └── js/app.js            ← All frontend logic
├── start_server.bat         ← One-click Windows startup
├── DESIGN.md                ← UI design documentation
├── SOCIAL_MEDIA.md          ← Social media content
├── RUN_GUIDE.md             ← This file
└── .gitignore
```

---

## Step 1 — Install Python Dependencies

Open a terminal in the `backend/` folder and run:

```bash
cd chatbot_1/backend
pip install -r requirements.txt
```

This installs:
- `fastapi` — web framework
- `uvicorn` — ASGI server
- `langchain` + `langchain-ollama` + `langchain-google-genai` — LLM integration
- `sqlalchemy` — database ORM
- `pydantic` — data validation
- `python-dotenv` — .env file support
- `python-multipart` — form support

---

## Step 2 — Set Up Ollama (for Local AI)

### 2a. Install Ollama
Download from: **https://ollama.com/download**

### 2b. Start the Ollama server
```bash
ollama serve
```
Leave this running in a terminal (or it runs as a background service after install).

### 2c. Pull a model
```bash
# Recommended — fast and capable
ollama pull llama3.2

# Other options
ollama pull mistral
ollama pull gemma3
ollama pull phi4
ollama pull tinyllama     # smallest, fastest
```

### 2d. Verify installed models
```bash
ollama list
```
The app's model dropdown will show exactly these models — live from Ollama.

---

## Step 3 — Configure Gemini API (Optional)

> Skip this step if you only want to use local Ollama models.

### 3a. Get a free API key
1. Go to **https://aistudio.google.com/app/apikey**
2. Sign in with your Google account
3. Click **"Create API Key"**
4. Copy the key (starts with `AIzaSy...`)

### 3b. Add to .env
Open `backend/.env` and replace the placeholder:

```env
GEMINI_API_KEY=AIzaSyYOUR_REAL_KEY_HERE
```

> The server reads this file dynamically — no restart needed after editing.

### Available Gemini models (auto-appear in dropdown when key is set):
- `gemini-2.0-flash` ← recommended (fast + smart)
- `gemini-2.0-flash-lite` ← fastest, cheapest
- `gemini-1.5-flash`
- `gemini-1.5-flash-8b`
- `gemini-1.5-pro` ← most capable

---

## Step 4 — Start the Server

### Option A: Double-click (Windows)
Just double-click `start_server.bat` from the `chatbot_1/` folder.

### Option B: Terminal (All platforms)
```bash
cd chatbot_1/backend

# Windows PowerShell
$env:PYTHONUTF8=1
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000

# macOS / Linux
PYTHONUTF8=1 python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

> `--reload` enables hot-reloading. The server auto-restarts when you edit Python files.

---

## Step 5 — Open the App

Open your browser and go to:

```
http://localhost:8000
```

| URL | Purpose |
|-----|---------|
| `http://localhost:8000` | Main chatbot UI |
| `http://localhost:8000/docs` | Interactive Swagger API docs |
| `http://localhost:8000/health` | Quick server health check |
| `http://localhost:8000/api/config` | View current bot config (JSON) |
| `http://localhost:8000/api/config/models` | View available models (JSON) |

---

## Step 6 — Customize Your Bot

1. Click the **⚙️ Settings** button in the top-right of the navbar
2. Fill in:
   - **Bot Name** — e.g., "MediBot", "CodeHelper", "FinanceGuru"
   - **Category** — choose from 13 built-in categories
   - **System Prompt** — describe how the bot should behave
   - **Model** — select from your Ollama models or Gemini models
3. Use **Quick Presets** to auto-fill the system prompt for common use cases
4. Click **Save Configuration**

Changes take effect immediately on the next message.

---

## API Reference

### GET /api/config
Returns current bot configuration.
```json
{
  "id": 1,
  "bot_name": "NexusAI",
  "category": "General",
  "description": "You are a helpful AI assistant...",
  "model": "llama3.2",
  "updated_at": "2026-07-03T12:00:00"
}
```

### PUT /api/config
Update bot configuration.
```json
{
  "bot_name": "MediBot",
  "category": "Medical",
  "description": "You are a medical information assistant...",
  "model": "gemini-2.0-flash"
}
```

### GET /api/config/models
Returns locally available models grouped by provider.
```json
{
  "ollama": ["llama3.2", "mistral"],
  "gemini": ["gemini-2.0-flash", "gemini-1.5-pro"],
  "gemini_key_set": true
}
```

### POST /api/chat
Send a message.
```json
// Request
{ "message": "Hello, how are you?" }

// Response
{ "reply": "Hi there! I'm doing great...", "bot_name": "NexusAI" }
```

### GET /api/history
Returns last 50 chat messages.

### DELETE /api/history
Clears all chat history.

---

## Troubleshooting

### "Ollama offline" in model dropdown
- Make sure `ollama serve` is running in a terminal
- Check: `curl http://localhost:11434/api/tags`

### Gemini models not showing
- Check `backend/.env` has your real API key (not the placeholder)
- Key must start with `AIzaSy...`
- Open Settings panel — it re-reads .env on every open

### "ModuleNotFoundError: langchain_ollama"
- Make sure you installed deps with the **correct Python version**
- Run: `python -m pip install -r requirements.txt` (use the full python path if needed)

### Server uses wrong Python version (Windows)
Use the explicit path:
```
C:\Users\YOUR_USERNAME\AppData\Local\Programs\Python\Python312\python.exe -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Port 8000 already in use
```bash
# Windows — find and kill the process
netstat -ano | findstr :8000
taskkill /PID <PID_NUMBER> /F
```

### UnicodeEncodeError on Windows
Set the environment variable before running:
```
set PYTHONUTF8=1
```
This is already handled in `start_server.bat`.

---

## Development Tips

- **Hot reload** — edit any `.py` file and the server restarts automatically
- **Database reset** — delete `backend/chatbot.db` to start fresh
- **API exploration** — use `http://localhost:8000/docs` (Swagger UI) to test all endpoints
- **Change port** — add `--port 9000` to the uvicorn command to use a different port
- **Mobile testing** — open `http://YOUR_IP:8000` on your phone (same Wi-Fi network)

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Enter` | Send message |
| `Shift + Enter` | New line in message |
| `Ctrl + K` | Focus the message input |

---

## Security Notes

- **Never commit** `backend/.env` to git — it's in `.gitignore` by default
- **Never commit** `backend/chatbot.db` — it contains your chat history
- The app runs locally only — not exposed to the internet by default
- Ollama models run 100% locally — no data sent externally
- Gemini API calls are sent to Google's servers — review their privacy policy if needed

---

*Last updated: July 2026 · NexusAI v1.0*
