if test -z "$DO_NOT_TRACK"
    set -Ux DO_NOT_TRACK 1
end

# Astro
# https://astro.build/telemetry/

if test -z "$ASTRO_TELEMETRY_DISABLED"
    set -Ux ASTRO_TELEMETRY_DISABLED 1
end
