#!/usr/bin/env bash

# if ~/.lazy_venv/lazy_venv.sh is not found then install
if [ ! -f ~/.lazy_venv/lazy_venv.sh ]; then
    echo "Installing lazy venv"

    # Create a hidden directory in the home directory to store the shell script if it does not exist
    mkdir -p ~/.lazy_venv

    # Copy the shell script into the hidden directory
    cp lazy_venv.sh ~/.lazy_venv/lazy_venv.sh

    # Source the script from the .bashrc file
    echo "source ~/.lazy_venv/lazy_venv.sh" >>~/.bashrc

    echo "lazy venv was successfully installed, run \"source ~/.bashrc\" or reopen your terminal to run commands"

    exit 0
fi

# If file is equal to newest version skip update
if cmp --silent ~/.lazy_venv/lazy_venv.sh lazy_venv.sh; then
    echo "lazy venv is already installed and up to date"
else
    echo "Updating lazy venv"

    # Update by copying the new version of the shell script into the hidden directory
    cp lazy_venv.sh ~/.lazy_venv/lazy_venv.sh

    echo "To complete update run \"source ~/.bashrc\" or reopen your terminal"
fi
