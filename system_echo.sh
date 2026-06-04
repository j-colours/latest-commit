#!/usr/bin/env bash

# Author: jcolours
# Date: 2026-06-04
# Description: finds current OS and echos or doesn't based upon that information
# for a better cli interface look

OS=$(uname -o)

if [[ "$OS" == "Darwin" ]]; then
  : # no-op: don't do an extra echo due to how OS (macOS) works
else
  # echo on Windows or Linux system
  echo
fi
