function mlx_vlm_convert_hf_model --wraps=mlx_lm.convert -a hf_path
    if test -z "$hf_path"
        echo "Usage: mlx_vlm_convert_hf_model <hf_path>"
        return 1
    end

    set -l extra_args $argv[2..-1]

    set -l model_name_segments (string split / $hf_path)
    set -l model_name $model_name_segments[-1]

    mlx_vlm.convert \
        --hf-path $hf_path \
        --mlx-path ~/.cache/huggingface/hub/""$model_name"-mlx" \
        $extra_args
end
