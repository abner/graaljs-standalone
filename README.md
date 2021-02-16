# GraalJS Application Example

By [@abner](@abner) - Ábner Oliveira

* https://twitter.com/abneroliveira
* https://www.linkedin.com/public-profile/in/abneroliveira

## How to execute

Run the command bellow, inside this repository root path, in order to setup the jars folder with the Java dependencies needed to run javascript inside the JVM through GraalJS and also to load two aliases commands: `runpg` and `localjjs` (works on linux or wsl on Windows).


```bash
source ./init.sh
```

### Requirements

> Java 11 or above installed.

## Aliases

* `rungpg`  - Starts a docker container running a postgres  database
* `localjjs` - Runs the localjjs GraalJS REPL or runs a script if passed



## Test the postgres script

After sourcing the init.sh in a terminal session, you can execute:

```bash
localjjs postgres_graal_script.js
```
