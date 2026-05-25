function coredns_dig --wraps "dig @localhost -p 36737"
    dig @localhost -p 36737 $argv
end
