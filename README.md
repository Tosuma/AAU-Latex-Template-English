**Disclaimer**

This guide is for how to install LaTeX and how to compile LaTeX using VS Code as the IDE.

This guide assumes the system uses the ``apt`` or ``brew`` package manager, and that [Windows systems uses a terminal within WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

## Installation

1. [Install VS Code](https://code.visualstudio.com/) and the extension [Latex Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)

    1. Windows also need the [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension.

2. Run installation script:

    1. [Windows](./setupWSL.sh):
    
        ```bash
        script="./setupWSL.sh"
        ```

    2. [Mac](./setupMac.sh):
    
        ```bash
        script="./setupMac.sh"
        ```

    3. [Ubuntu](./setupUbuntu.sh): 
    
        ```bash
        script="./setupUbunto.sh"
        ```

    You may need to enter your password for the user

    ```bash
    sudo chmod u+x $script && $script
    ```

3. Ready to use

## How to open a project

1. Enter the path in the shell / Navigate to the project in the shell

2. Enter the following command to launch VS Code (If using other IDE use its launch command)

```bash
code .
```

## How to compile the project

When a ``.tex`` file is open, *Latex-Workshop* will present a green playbutton in the upper right corner to compile the current file.

The project most likely contain either a ``master.tex`` or ``main.tex`` which makes setup and inclusion of all the different ``.tex`` files. 
In general you want to compile that file, however, the explanation of how to compile has been abstracted to how compile in general.

### Using VS Code

1. Press the green button to compile

2. The file has been compiled into a pdf with the same name

3. A small icon next to the compile button, opens a preview of the pdf next to the editor, which updates upon re-compiling

<!-- ### Using commandline -->

## Project settings

### General settings for Latex

Place [``settings.json``](./settings.json) in the ``/.vscode/`` folder of your project.

### Settings for ``MakeGlossaries`` package

Place [``.latexmkrc``](./.latexmkrc) in the same directory level as ``main.tex`` or ``master.tex``
