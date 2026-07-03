@echo off
echo ============================================
echo   Starting Customizable Chatbot Server
echo ============================================
echo.
echo [NOTE] Make sure Ollama is running: ollama serve
echo [NOTE] Add your Gemini API key in: backend\.env
echo.
echo [1/2] Activating Python 3.12...
set PYTHONUTF8=1
echo [2/2] Starting FastAPI server on port 8000...
echo.
echo  Open your browser: http://localhost:8000
echo  API Docs:          http://localhost:8000/docs
echo  Press CTRL+C to stop.
echo.
C:\Users\jaga5\AppData\Local\Programs\Python\Python312\python.exe -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
pause
