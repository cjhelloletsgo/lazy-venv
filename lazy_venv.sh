#!/usr/bin/env bash

# Uninstall lazy env
function uninstall_lazy_venv() {
    while true; do
        read -p "Are you sure you want to uninstall lazy venv? (y/n) " uninstall_confirmation
        case $uninstall_confirmation in [[yYnN]) break ;; *) echo "Invalid input, must choose y/n" ;; esac
    done

    if [ "$uninstall_confirmation" = "y" ] || [ "$uninstall_confirmation" = "Y" ]; then
        rm -rf ~/.lazy_venv

        string_to_remove="source ~/.lazy_venv/lazy_venv.sh"
        escaped_string=$(sed 's/[\/&]/\\&/g' <<<"$string_to_remove")
        sed -i "/$escaped_string/d" ~/.bashrc

        unset activate_venv
        unset deactivate_venv
        unset cd
        unset ve
        unset uninstall_lazy_venv

        echo "lazy venv in uninstalled"
    fi

}

# A function to activate the virtual environment
function activate_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        return
    fi

    current_dir="$PWD"
    while [[ "$current_dir" != "/" ]]; do
        if [[ -d "$current_dir/.venv" && -f "$current_dir/.venv/bin/activate" ]]; then
            STORED_PATH=$PATH
            export STORED_PATH
            source "$current_dir/.venv/bin/activate"
            break
        fi
        current_dir=$(dirname "$current_dir")
    done
}

# A function to deactivate the virtual environment
function deactivate_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
}

# Override the "cd" command to activate/deactivate the virtual environment
function cd() {
    builtin cd "$@" || {
        return 1
    }

    deactivate_venv
    activate_venv
}

# If you don't add this in then vscode is passed the VIRTUAL_ENV environmental variable set with the value in the original terminal
# but the virtual environment is not actually activated, this unsets the VIRTUAL_ENV variable and resets the PATH variable so vscode will act identically to a regular terminal
if [ "$TERM_PROGRAM" == "vscode" ]; then
    if [[ -n "$VIRTUAL_ENV" ]]; then
        unset VIRTUAL_ENV
        PATH=$STORED_PATH
        export PATH
    fi
fi

# Creates virtual environment or activates one if one is present in the current directory
function ve() {
    venv=".venv"

    bin=".venv/bin/activate"

    # If not already in virtualenv
    # $VIRTUAL_ENV is being set from $venv/bin/activate script
    if [ -z "${VIRTUAL_ENV}" ]; then
        if [ ! -d ${venv} ]; then
            echo "Creating and activating virtual environment ${venv}"
            python3 -m venv ${venv}
            source "$bin"
            pip install --upgrade pip -q
        else
            echo "Virtual environment ${venv} already exists, activating..."
            source "$bin"
        fi
    else
        echo "Already in a virtual environment!"
    fi
}

# Activate any virtual environments found when a terminal is opened
activate_venv
