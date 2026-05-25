function mlx_lm_quantize_hf_model --wraps=mlx_lm.convert -a hf_path -a q_bits -a q_mode
    if test -z "$hf_path"
        echo "Usage: mlx_lm_quantize_hf_model <hf_path> [q_mode] [q_bits]"
        return 1
    end

    set -l extra_args $argv[4..-1]

    if test -z "$q_bits"
        set q_bits 8
    end

    if test -z "$q_mode"
        set q_mode affine
    end

    set -l mlx_path_suffix

    if test "$q_mode" = affine
        set mlx_path_suffix ""$q_bits"bit"
    else
        set q_mode "$q_mode$q_bits"
        set mlx_path_suffix $q_mode
    end

    set -l model_name_segments (string split / $hf_path)
    set -l model_name $model_name_segments[-1]

    mlx_lm.convert \
        --hf-path $hf_path \
        --mlx-path ~/.cache/huggingface/hub/""$model_name"-mlx-$mlx_path_suffix" \
        --quantize \
        --q-bits $q_bits --q-mode $q_mode \
        $extra_args
end
