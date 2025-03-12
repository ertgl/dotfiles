function brew_update
    brew update
    brew outdated --greedy
    brew upgrade --greedy
    brew cleanup
    brew cleanup --prune=all
end
