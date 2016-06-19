echo Please do following before continue:

#basedir=`dirname $0`
basedir=`pwd`
echo $basedir

echo do git pull app-hybrid-core first... or 
echo git clone https://github.com/SZU-BDI/app-hybrid-core.git

cd ../../app-hybrid-core/
git pull

cd $basedir

#echo touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" \>\> ~/.gradle/gradle.properties

echo "cp local.properties.eg => local.properties and edit it if sdk pos is not correct..."

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
