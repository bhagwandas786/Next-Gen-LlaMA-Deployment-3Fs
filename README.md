# **🚀 Next-Gen LLaMA 3 Containerized AI Deployment (CLI | Web UI | REST API) 🚀**


A fully containerized setup to run LLaMA 3.2 (3B) locally or on a cloud VM with an elegant Web UI, developer-friendly REST API, and interactive Command Line Interface — all in one place.

*This deployment is designed for speed, privacy, and simplicity. 💻✨*


# **✨ Key Features**

🌐 Web Interface — Beautiful, responsive chat UI for easy interaction.

🔌 REST API — Developer-ready endpoints for integrations.

💻 Command Line Access — Lightweight terminal-based chat interface.

🔒 100% Private — Runs entirely on your machine or VM (no data leaves your system).

💸 Completely Free — No external API or token costs.

📶 Offline Mode — Works without internet once set up.

🧠 Optimized Model — Uses Llama-3.2-3B Q4_K_M quantized model for fast inference.


# 🏗️ **Architecture Overview**

 *My architecture is based on the Transformer model, which is the foundation of modern NLP systems such as GPT and LLaMA.*

 <img width="1396" height="443" alt="image" src="https://github.com/user-attachments/assets/ade1f2a3-eaf8-48c4-bd3e-de7dd7387656" />

**Key Components:**

*Encoder* – Processes and extracts meaning from input text sequences.
- *Decoder* – Generates context-aware responses based on encoded information.
- *Self-Attention Mechanism* – Determines which words or tokens in a sentence are most relevant to each other.
- *Feed-Forward Layers* – Refine and transform representations between model layers.
- *Positional Encoding* – Helps the model understand word order in a sentence.
- *Multi-Head Attention* – Allows the model to capture multiple types of relationships simultaneously.
- *Layer Normalization & Dropout* – Improve generalization and prevent overfitting during training.

*llama-server → Handles Web UI and REST API
llama-cli → Terminal interface for prompt/response
/models → Local folder with downloaded model file*

# **📊 Core Hyperparameters**

- Parameter	Description
- Model Size	~300M parameters
- Layer Depth	6–8 layers
- Attention Heads	8 heads
- Learning Rate	1e-4

# **QUICK START**

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
http://158.101.98.132:9090/

## Health Check: 
curl http://158.101.98.132:9090/health

## CLI Chat: 
docker exec -it llama-cli /app/llama-cli -m /models/Llama-3.2-3B-Instruct-Q4_K_M.gguf -i

## Tokenize Endpoint 
curl -X POST http://158.101.98.132:9090/tokenize -H "Content-Type: application/json" -d '{"content": "LETTERS/WORDS"}'

## # Server Info API
curl http://158.101.98.132:9090/v1/models

```

**6. API Requests**
```bash

curl -s -X POST http://158.101.98.132:9090/completion \
  -H "Content-Type: application/json" \
  -d '{"prompt": "What is DevOps", "max_tokens": 50}' \
| grep -oP '"content":"\K[^"]+'

  
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
 # 🧠 **Model Overview**

This deployment runs a LLaMA-based Large Language Model (LLM) designed to understand and generate natural language responses in real time. The model is powered by the llama.cpp backend, running inside a containerized environment for efficient and scalable inference.

# **🔄 Model Switching Feature**

You can easily switch between different .gguf models without rebuilding anything.

-  Add new model — Place your .gguf file inside the models folder.
-  Update path — In docker-compose.yml, set:
  
  **Tested Model Info**
  
  *Name: Llama-3.2-3B-Instruct-Q4_K_M.gguf
  Size: ~2GB
  Type: Instruction-tuned AI model
  Quantization: Q4_K_M (optimized for performance)*

**🧩 What Can the Model Do?**

- Answer Questions: Respond intelligently to user prompts.
- Generate Text: Write articles, summaries, or creative text.
- Converse Naturally: Maintain contextual, coherent conversations.
- Translate Languages: Perform basic translation tasks between major languages.

# **🌐Live Endpoints for LlaMA**  

  **🖥️Live Chat with LlaMA (UI) :** http://158.101.98.132:9090/ 🚀
  
  **🩺 Web UI Health Status:** http://158.101.98.132:9090/health 🚀
  
  **🧠 Server Info API:** http://158.101.98.132:9090/v1/models 🚀

  **📥 Model Overview:** https://huggingface.co/meta-llama/Llama-3.2-3B-Instruct 🚀
   
  **📥 Model Downloading Link:** https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf 🚀

  # **Purpose of This Deployment**

**This setup demonstrates:**

- *Real-world LLaMA model serving using llama.cpp*
- *Deployment through Docker Compose for reproducibility*
- *API and CLI access for both interactive and programmatic usage*


*This final project was collaboratively developed by Bhagwan Das Rathore and Wasiq Mahmood as part of their DevOps foundation course under the guidance of Muzamil Bilwani.*



