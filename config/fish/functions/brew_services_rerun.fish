function brew_services_rerun -a service_name
    brew services stop $service_name
    brew services run $service_name
end
