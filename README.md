Manually creating, activating and deactivating virtual environments is a pain. None of the other solutions to solve this same problem worked like I wanted them to so I started working on this bash script to fix my problem. By using this script you won't have to manually deal with virtual environments anymore.

## Installation
To install run the install script with this command

`bash install.sh`

Then source your .bashrc file

`source ~/.bashrc`

![Error loading images/install](images/install.png)

## Uninstallation
To uninstall run the command `uninstall_lazy_venv`

![Error loading images/uninstall.png](images/uninstall.png)

## Usage

Create a vitual environment with
`ve`

![Error loading images/create_venv.png](images/create_venv.png)

Activate a virtual environment by entering a directory containing a virtual environment

![Error loading images/cd_activate.png](images/cd_activate.png)

If you are currently in a directory which contains a virtual environment but it is not activated the ve command will activate it

![Error loading cd_deactivate.png](images/ve_activate.png)


Deactivate with the usual `deactivate` command or simply exit the directory

![Error loading images/deactivate.png](images/deactivate.png)

![Error loading images/cd_deactivate.png](images/cd_deactivate.png)
