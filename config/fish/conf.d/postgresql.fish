set libpq_directory_path (brew --prefix libpq)

if test $status -eq 0
    fish_add_path --global --move --path --prepend "$libpq_directory_path/bin"
end
