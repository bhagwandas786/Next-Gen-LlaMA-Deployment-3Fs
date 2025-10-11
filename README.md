**Next-Gen LLaMA 3 Containerized Deployment for CLI, Web UI and REST API**

A complete Docker setup to run Llama-3.2-3B AI model locally with Web UI, API, and CLI.

## ✨ Features
- 🌐 **Web Interface** - Beautiful chat UI
- 🔌 **REST API** - For developers  
- 💻 **Command Line** - Terminal access
- 🔒 **100% Private** - Runs on your machine
- 💸 **Completely Free** - No API costs
- 🌐 **Offline Mode** - Runs locally without internet capability 

**QUICK START**

### 1. Create Project
```bash
mkdir llama-docker
cd llama-docker
mkdir models
```

**2. Download Model**
```bash
cd models
wget https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf
cd ..
```

**3. Clone llama.cpp**
```bash
git clone https://github.com/ggerganov/llama.cpp.git
```
**4. Start Services**
```bash
docker-compose up -d --build
```

**5. Access all 3 Interfaces**
```bash
## Web UI: 
http://localhost:8080

## Health Check: 
curl http://localhost:8080/health

## CLI Chat: 
docker exec -it llama-cli /app/llama-cli -m /models/Llama-3.2-3B-Instruct-Q4_K_M.gguf -i

## Tokenize Endpoint 
curl -X POST http://localhost:8080/tokenize -H "Content-Type: application/json" -d '{"content": "LETTERS/WORDS"}'

## # Server Info API
curl http://localhost:8080/v1/models
```

**6. API Requests**
```bash
curl -X POST http://localhost:8080/completion \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "PROMPT",
    "max_tokens": 20
  }'
  ```
  **7. Command Line**
  ```bash
  # Interactive session
docker exec -it llama-cli /app/llama-cli -m /models/Llama-3.2-3B-Instruct-Q4_K_M.gguf -i

# Single question
docker exec llama-cli /app/llama-cli -m /models/Llama-3.2-3B-Instruct-Q4_K_M.gguf -p "What is AI?"
  ```

  **8. Management**
   ```bash
## Check Status
docker-compose ps 
docker-compose logs llama-server
docker-compose logs llama-cli
Docker stats

## Stop Services
docker-compose down

## Restart Services
docker-compose restart

## Clean Build (If having issues)
docker-compose down
docker system prune -a
docker-compose up --build
  ```

  **Tested Model Info**
  
  *Name: Llama-3.2-3B-Instruct-Q4_K_M.gguf
  Size: ~2GB
  Type: Instruction-tuned AI model
  Quantization: Q4_K_M (optimized for performance)*

  Ready to start? Run docker-compose up -d and open http://localhost:8080 🚀





