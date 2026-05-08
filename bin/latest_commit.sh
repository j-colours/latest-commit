#!/usr/bin/env bash

# latest_commit
# Author: jcolours
# Date: 2026-05-07
# Description: grabs the latest commit from the git repo in the directory

# Function Name: main
# Purpose: runs log recent commit
main() {
  if [ -d ".git" ]; then
    # run in background to check if commits have been made
    git log >/dev/null 2>&1

    # or git log &> /dev/null

    # if the recent run in background doesn't
    # have an exit code of 0 then error
    if [ $? -ne 0 ]; then
      echo
      echo "Error: No commits currently in repo..."
      echo "       rerun when atleast one commit is made."
      exit 1 # exit failure
    fi

    git log | head -n 6

    # echo $PWD | cut -d "/" -f- --> didn't work
    echo "Repo: $(basename $PWD)"
  else
    echo
    echo "Error: Rerun in a git repo (directory)..."
    exit 1 # exit failure
  fi

  exit 0 # exit success
}

main
