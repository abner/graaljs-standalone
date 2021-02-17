# GraalJS Application Example

By [@abner](@abner) - Ábner Oliveira

* https://twitter.com/abneroliveira
* https://www.linkedin.com/public-profile/in/abneroliveira

This project allows to write scripts Java using Javascript
trough the GraalJS Engine in a standalone way.

The script provided as an example connects to a Postgres database and prints the rows of the sample table.

**Requirements: **

* Any Java SDK at version 11 or superior
* Platforms supported: Linux, MacOS or Windows (with WSL or Git Bash)
* Docker (optional to run the Postgres instance)

## How to execute

Run the command bellow, inside this repository root path, in order to setup the jars folder with the Java dependencies needed to run javascript inside the JVM through GraalJS and also to load two aliases commands: `startpg` [runs Postgres] and `localjjs` [starts the javascript REPL or run a given script].


```bash
source ./setup.sh
```

### Assigning a different port to Postgres

If you want to override the port used both to run the postgres container and used to connect to the database, you can pass
POSTGRES_PORT variable to the setup.sh script:

```bash
POSTGRES_PORT=5433 source ./setup.sh
```

### Requirements

> Java 11 or above installed.

## Aliases

* `rungpg`  - Starts a docker container running a postgres  database
* `localjjs` - Runs the localjjs GraalJS REPL or runs a script if passed



## Running the postgres script

After sourcing the setup.sh in a terminal session, you can execute:

### 1. Starting the postgres database

```bash
startpg
```

### 2. Call the postgres_graal_script.js using the localjjs aliase

> The localjjs is a bash alias which calls the Java Class `com.oracle.truffle.js.shell.JSLauncher` passing the psotgres_graal_script.js as the
script it should execute.


```bash
localjjs postgres_graal_script.js
```

**It Outputs:**

```
--------------------------------------------------------------
GRAAL JS - Postgres script - PG Port: 5432
--------------------------------------------------------------
--------------------------------------------------------------
Row 1   ::::    1       |       Angel
Row 2   ::::    2       |       Beth
Row 3   ::::    3       |       Sophie
Row 4   ::::    4       |       Zeneth
--------------------------------------------------------------
```
## References:

* https://www.graalvm.org/reference-manual/js/RunOnJDK/#graalvm-javascript-without-maven---jar-files-from-graalvm
