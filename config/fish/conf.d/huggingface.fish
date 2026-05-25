if test -z "$HF_HUB_CACHE"
    set -Ux HF_HUB_CACHE ~/.cache/huggingface/hub
end

if test -z "$HF_HUB_DISABLE_TELEMETRY"
    set -Ux HF_HUB_DISABLE_TELEMETRY 1
end

# if test -z "$HF_HUB_DISABLE_XET"
#     set -Ux HF_HUB_DISABLE_XET 1
# end

if test -z "$HF_XET_HIGH_PERFORMANCE"
    set -Ux HF_XET_HIGH_PERFORMANCE 1
end

if test -z "$HF_XET_NUM_CONCURRENT_RANGE_GETS"
    set -Ux HF_XET_NUM_CONCURRENT_RANGE_GETS 32
end
