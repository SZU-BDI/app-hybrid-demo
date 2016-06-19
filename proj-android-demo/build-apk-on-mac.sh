echo Please do following before continue:

echo touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" \>\> ~/.gradle/gradle.properties
echo "cp local.properties.eg => local.properties"

# ===
# gradlew

# === build debug/default
sh gradlew build

# === build release
#./gradlew assembleRelease

# ===
#find . |grep apk
ls -al build/*.apk

## NOTES
