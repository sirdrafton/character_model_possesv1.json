# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow includes unknown-registry custom nodes that could not be resolved automatically.
# The following custom nodes are in the 'unknown_registry' group and no aux_id (GitHub repo) was provided,
# so they cannot be installed automatically and must be added manually to /comfyui/custom_nodes/ if needed:
# - PulidFluxModelLoader (not found / no aux_id provided)
# - PulidFluxEvaClipLoader (not found / no aux_id provided)
# - PulidFluxInsightFaceLoader (not found / no aux_id provided)
# - ApplyPulidFlux (not found / no aux_id provided)
# - CheckpointLoaderSimple (not found / no aux_id provided)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/guozinan/PuLID/resolve/main/pulid_flux_v0.9.1.safetensors --relative-path models/diffusion_models --filename pulid_flux_v0.9.1.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/flux1-dev/resolve/main/flux1-dev-fp8.safetensors --relative-path models/checkpoints --filename flux1-dev-fp8.safetensors
# RUN # Could not find URL for SoftLineart.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
