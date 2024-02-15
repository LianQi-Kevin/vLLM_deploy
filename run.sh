# init network turbo
source /etc/network_turbo

# install requirements
#echo "Installing requirements"
#/root/venv/bin/pip install -r /root/vLLM_deploy/requirements.txt

# init huggingface
export HF_HOME='/root/autodl-tmp/huggingface'

# run
# vLLM Supported Models: https://docs.vllm.ai/en/latest/models/supported_models.html#supported-models
# Qwen1.5 Model Card: https://huggingface.co/collections/Qwen/qwen15-65c0a2f577b1ecb76d786524
# Local Model: Qwen/Qwen1.5-7B-Chat & Qwen/Qwen1.5-7B-Chat-GPTQ-Int4 & Qwen/Qwen1.5-14B-Chat-GPTQ-Int4
# PS: Qwen/Qwen1.5-14B-Chat (OOM on RTX4090)
echo "Running server"
cd /root/vLLM_deploy || exit
/root/venv/bin/python -m vllm.entrypoints.openai.api_server \
  --model "Qwen/Qwen1.5-14B-Chat-GPTQ-Int4" \
  --enforce-eager \
  --gpu-memory-utilization 0.9 \
  --max-model-len 9500 \
  --seed 1234 \
  --port 6006 \
  --host "0.0.0.0"
