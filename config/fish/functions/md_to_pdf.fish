function md_to_pdf -a file_name
    pandoc "$file_name.md" -s -t html | weasyprint - "$file_name.pdf"
end
