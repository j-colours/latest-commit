#!/usr/bin/env bash

# latest_commit
# Author: jcolours
# Date: 2026-05-07
# Description: grabs the latest commit from the git repo in the directory

# Function Name: main
# Purpose: runs log recent commit
main() {

  if [[ "$1" == "-u" || "$1" == "--update" ]]; then

    GITHUB="https://github.com/j-colours/latest-commit/archive/refs/heads/main.zip"
    CODEBERG="https://codeberg.org/j-colours/latest-commit/archive/refs/heads/main.zip"

    curl -sSL $GITHUB -o /tmp/latest-commit.zip || \ 
    curl -sSL $CODEBERG -o /tmp/latest-commit.zip

    sudo rm -rf /usr/local/lib/latest-commit

    sudo unzip /tmp/latest-commit.zip -d /tmp/latest-commit
    sudo mv /tmp/latest-commit/latest-commit /usr/local/lib/latest-commit
    sudo rm -rf /tmp/latest-commit.zip /tmp/latest-commit
    sudo chmod +x /usr/local/lib/latest-commit/latest_commit.sh
    sudo ln -sf /usr/local/lib/latest-commit/latest_commit.sh /usr/local/bin/lcommit

    exit 0 # status success
  fi

  if [ -d ".git" ]; then
    # run in background to check if commits have been made
    git log >/dev/null 2>&1

    # or git log &> /dev/null

    # if the recent run in background doesn't
    # have an exit code of 0 then error
    if [ $? -ne 0 ]; then
      echo
      echo -e "$'\033[31m'Error$'\033[0m': No commits currently in repo..."
      echo "       rerun when atleast one commit is made."
      exit 1 # exit failure
    fi

    echo
    echo -e "\033[33m[$(basename $PWD)]\033[0m" # \x1b hex for ESC character (27)
    echo

    git log | head -n 6

    # echo $PWD | cut -d "/" -f- --> didn't work --> to work must be echo $PWD | rev | cut -d "/" -f1 | rev
    # echo $PWD | awk -F'/' '{print $NF}' --> works!

    echo $'\033[33m'"[$(basename $PWD)]"$'\033[0m' # \x1b hex for ESC character (27) or 033
  else
    echo
    echo "$'\033[31m'Error$'\033[0m': Not in a git repo (directory)..."
    exit 1 # exit failure
  fi

  exit 0 # exit success
}

main "$@"
