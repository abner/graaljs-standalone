#!/bin/bash

export JJS_JARSPATH="$PWD/.libs"
export JJS_JVMCIPATH="$PWD/.jvmci"

if [ ! -d $JJS_JARSPATH ]; then
  mkdir $JJS_JARSPATH && mkdir -p .jvmci && \
  wget -P $JJS_JVMCIPATH https://repo1.maven.org/maven2/org/graalvm/sdk/graal-sdk/21.0.0.2/graal-sdk-21.0.0.2.jar &&  \
  wget -P $JJS_JVMCIPATH https://repo1.maven.org/maven2/org/graalvm/truffle/truffle-api/21.0.0.2/truffle-api-21.0.0.2.jar && \
  wget -P $JJS_JVMCIPATH https://repo1.maven.org/maven2/org/graalvm/compiler/compiler/21.0.0.2/compiler-21.0.0.2.jar && \
  wget -P $JJS_JVMCIPATH https://repo1.maven.org/maven2/org/graalvm/compiler/compiler-management/21.0.0.2/compiler-management-21.0.0.2.jar && \
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/com/ibm/icu/icu4j/68.2/icu4j-68.2.jar && \
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/org/graalvm/sdk/launcher-common/21.0.0.2/launcher-common-21.0.0.2.jar && \
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/org/graalvm/js/js-launcher/21.0.0.2/js-launcher-21.0.0.2.jar && \
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/org/graalvm/js/js/21.0.0.2/js-21.0.0.2.jar && \
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/org/graalvm/js/js-scriptengine/21.0.0.2/js-scriptengine-21.0.0.2.jar &&
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/org/graalvm/regex/regex/21.0.0.2/regex-21.0.0.2.jar && \
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/org/graalvm/tools/chromeinspector/21.0.0.2/chromeinspector-21.0.0.2.jar && \
  wget -P $JJS_JARSPATH https://repo1.maven.org/maven2/org/graalvm/tools/profiler/21.0.0.2/profiler-21.0.0.2.jar && \
  wget -P $JJS_JARSPATH https://jdbc.postgresql.org/download/postgresql-42.2.18.jar
fi


#JAVA_CLASSPATH="$JJS_JARSPATH/launcher-common-21.0.0.2.jar:$JJS_JARSPATH/js-launcher-21.0.0.2.jar:$JJS_JARSPATH/js-21.0.0.2.jar:$JJS_JVMCIPATH/truffle-api-21.0.0.2.jar:$JJS_JVMCIPATH/compiler-management-21.0.0.2.jar:$JJS_JVMCIPATH/graal-sdk-21.0.0.2.jar:$JJS_JARSPATH/js-scriptengine-21.0.0.2.jar:$JJS_JARSPATH/regex-21.0.0.2.jar:$JJS_JARSPATH/chrome-inspector-21.0.0.2.jar:$JJS_JARSPATH/icu4j-68.2.jar:$JJS_JARSPATH/postgresql-42.2.18.jar"
JAVA_CLASSPATH="$JJS_JARSPATH/*"
JVMCI_CLASSPATH="$JJS_JVMCIPATH:$JJS_JARSPATH"

MODULES_READS="--add-reads com.oracle.truffle.tools.chromeinspector=java.logging"
MODULES_EXPORTS="--add-exports com.oracle.truffle.tools.profiler/com.oracle.truffle.tools.utils.json=com.oracle.truffle.tools.chromeinspector"

alias graaljs="java $MODULES_READS $MODULES_EXPORTS -XX:+IgnoreUnrecognizedVMOptions --module-path=$JVMCI_CLASSPATH -XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:+UseJVMCICompiler  --upgrade-module-path=$JJS_JVMCIPATH/compiler-21.0.0.2.jar:$JJS_JVMCIPATH/compiler-management-21.0.0.2.jar -Dpostgres.port=${POSTGRES_PORT:-5432}  -cp '$JAVA_CLASSPATH' com.oracle.truffle.js.shell.JSLauncher"
alias graaljs_debug="java $MODULES_READS $MODULES_EXPORTS -XX:+IgnoreUnrecognizedVMOptions -Dpolyglot.inspect=9300 --module-path=$JVMCI_CLASSPATH -XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:+UseJVMCICompiler  --upgrade-module-path=$JJS_JVMCIPATH/compiler-21.0.0.2.jar:$JJS_JVMCIPATH/compiler-management-21.0.0.2.jar -Dpostgres.port=${POSTGRES_PORT:-5432}  -cp '$JAVA_CLASSPATH' com.oracle.truffle.js.shell.JSLauncher"
alias startpg="docker run --name pggraal -d --rm -it -v $PWD/postgresql:/docker-entrypoint-initdb.d -e  POSTGRES_USER=pguser -e POSTGRES_DB=pgdb  -e POSTGRES_PASSWORD=pgpassword -p ${POSTGRES_PORT:-5432}:5432 postgres:12-alpine"
alias stoppg="docker stop pggraal"
