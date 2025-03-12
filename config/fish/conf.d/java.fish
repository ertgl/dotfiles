if test -z "$JAVA_HOME"
    set -Ux JAVA_HOME (asdf where java)
end

if test -z "$JDK_HOME"
    set -Ux JDK_HOME "$JAVA_HOME"
end
