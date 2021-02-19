#!/bin/bash
shopt -s expand_aliases
source setup.sh
graaljs_debug postgres_graal_script.js
