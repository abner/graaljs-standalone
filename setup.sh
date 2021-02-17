#!/bin/bash

export JJS_JARSPATH="$PWD/jars"

if [ ! -d $JJS_JARSPATH ]; then
  mkdir $JJS_JARSPATH && \
  cd $JJS_JARSPATH && \
  wget https://repo1.maven.org/maven2/com/ibm/icu/icu4j/68.2/icu4j-68.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/sdk/graal-sdk/21.0.0.2/graal-sdk-21.0.0.2.jar &&  \
  wget https://repo1.maven.org/maven2/org/graalvm/truffle/truffle-api/21.0.0.2/truffle-api-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/compiler/compiler/21.0.0.2/compiler-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/compiler/compiler-management/21.0.0.2/compiler-management-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/sdk/launcher-common/21.0.0.2/launcher-common-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/js/js-launcher/21.0.0.2/js-launcher-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/js/js/21.0.0.2/js-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/js/js-scriptengine/21.0.0.2/js-scriptengine-21.0.0.2.jar &&
  wget https://repo1.maven.org/maven2/org/graalvm/regex/regex/21.0.0.2/regex-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/tools/chromeinspector/21.0.0.2/chromeinspector-21.0.0.2.jar && \
  wget https://repo1.maven.org/maven2/org/graalvm/tools/profiler/21.0.0.2/profiler-21.0.0.2.jar && \
  wget https://jdbc.postgresql.org/download/postgresql-42.2.18.jar
fi


alias graaljs="java -XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:+UseJVMCICompiler --module-path=$JJS_JARSPATH/graal-sdk-21.0.0.2.jar:$JJS_JARSPATH/truffle-api-21.0.0.2.jar --upgrade-module-path=$JJS_JARSPATH/compiler-21.0.0.2.jar:$JJS_JARSPATH/compiler-management-21.0.0.2.jar -cp $JJS_JARSPATH/launcher-common-21.0.0.2.jar:$JJS_JARSPATH/js-launcher-21.0.0.2.jar:$JJS_JARSPATH/js-21.0.0.2.jar:$JJS_JARSPATH/truffle-api-21.0.0.2.jar:$JJS_JARSPATH/graal-sdk-21.0.0.2.jar:$JJS_JARSPATH/js-scriptengine-21.0.0.2.jar:$JJS_JARSPATH/regex-21.0.0.2.jar:$JJS_JARSPATH/chrome-inspector-21.0.0.2.jar:$JJS_JARSPATH/icu4j-68.2.jar:$JJS_JARSPATH/postgresql-42.2.18.jar -Dpostgres.port=${POSTGRES_PORT:-5432} com.oracle.truffle.js.shell.JSLauncher"
alias startpg="docker run --name pggraal -d --rm -it -v $PWD/postgresql:/docker-entrypoint-initdb.d -e  POSTGRES_USER=pguser -e POSTGRES_DB=pgdb  -e POSTGRES_PASSWORD=pgpassword -p ${POSTGRES_PORT:-5432}:5432 postgres:12-alpine"
alias stoppg="docker stop pggraal"
