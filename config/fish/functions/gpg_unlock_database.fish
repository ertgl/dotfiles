function gpg_unlock_database
    rm -f ~/.gnupg/public-keys.d/pubring.db.lock
end
