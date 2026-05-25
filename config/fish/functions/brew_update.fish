function brew_update
    brew update
    brew outdated --greedy
    brew upgrade --greedy
    brew_bundle_upgrade
    brew cleanup
    brew cleanup --prune=all
end
