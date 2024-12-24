# Based on the code shared by `sbe-arg` in the following issue:
# https://github.com/asdf-vm/asdf/issues/830#issuecomment-1539107936

function asdf_uninstall_unused_versions
    for plugin_name in (asdf plugin-list)
        for tool_version in (asdf list $plugin_name | grep -v (asdf current $plugin_name | awk '{print $2}'))
            set -lu normalized_tool_version (string trim $tool_version)
            echo "Uninstalling $plugin_name $normalized_tool_version"
            asdf uninstall $plugin_name $normalized_tool_version
        end
    end
end
