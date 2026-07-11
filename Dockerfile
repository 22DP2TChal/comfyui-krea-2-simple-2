# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# install custom nodes into comfyui
RUN git clone https://github.com/Auryg/Krea-2-Two-Stage-Sampler /comfyui/custom_nodes/Krea-2-Two-Stage-Sampler && cd /comfyui/custom_nodes/Krea-2-Two-Stage-Sampler && (git checkout b201412a0178da17b9760faa897107283428a78a 2>/dev/null || (git fetch origin b201412a0178da17b9760faa897107283428a78a --depth=1 && git checkout b201412a0178da17b9760faa897107283428a78a) || echo "WARN: commit b201412a0178da17b9760faa897107283428a78a unreachable in https://github.com/Auryg/Krea-2-Two-Stage-Sampler, falling back to default branch HEAD")
RUN comfy node install --exit-on-fail was-node-suite-comfyui@1.0.2 --mode remote || (echo "WARN: was-node-suite-comfyui@1.0.2 unavailable in registry, falling back to latest" >&2 && comfy node install --exit-on-fail was-node-suite-comfyui --mode remote)
