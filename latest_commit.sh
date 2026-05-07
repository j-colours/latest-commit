#!/usr/bin/env bash

# latest_commit
# Author: jcolours
# Date: 2026-05-07
# Description: grabs the latest commit from the git repo in the directory

# Function Name: main
# Purpose: runs script
main() {
  if [ -d ".git" ]; then
    git log | head -n 6
  else
    echo "Rerun in a git repo (directory)..."
  fi
}
