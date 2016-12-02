
# check env var JAVA_HOME:
if [ ! -n "$JAVA_HOME" ] ;then
	export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
fi

if [ ! -x "$JAVA_HOME/bin/java" ] ;then

	#echo ERROR: Need JAVA_HOME, for example:
	#echo export JAVA_HOME=\"/Applications/Android Studio-2.app/Contents/jre/jdk/Contents/Home\"
	#echo export JAVA_HOME=\"/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home\"

	echo cannot find the java in the $JAVA_HOME
	exit;

fi

echo JAVA_HOME=$JAVA_HOME

#using daemon mode to speed up the next compilation:
echo "org.gradle.daemon=true" > ~/.gradle/gradle.properties

# in mac, the android sdk mostly default install into:
echo "sdk.dir=$HOME/Library/Android/sdk" > local.properties

# ===
# gradlew

sh gradlew --stacktrace --info build -x test

#gradle build -x test 

#sh gradlew build

# === build release
#./gradlew assembleRelease

# ===
#find . |grep apk
ls -al build/*.apk

