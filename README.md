**Disclaimer**

This guide is for how to install LaTeX and how to compile LaTeX using VS Code as the IDE.

This guide assumes the system uses the ``apt`` or ``brew`` package manager, and that [Windows systems uses a terminal within WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

## Installation

1. [Install VS Code](https://code.visualstudio.com/) and the extension [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.LaTeX-workshop)

    1. Windows also need the [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension.

2. Run installation script:

    1. [Windows](./_Scripts/setupWSL.sh):

        - Must be runned in WSL
    
        ```bash
        ./setupWSL.sh
        ```

    2. [Mac](./_Scripts/setupMac.sh):
    
        ```bash
        ./setupMac.sh
        ```

    3. [Ubuntu](./_Scripts/setupUbuntu.sh): 
    
        ```bash
        ./setupUbuntu.sh
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

*Remember to make the Project Settings*

When a ``.tex`` file is open, *LaTeX-Workshop* will present a green playbutton in the upper right corner to compile the current file.

The project most likely contain either a ``master.tex`` or ``main.tex`` which makes setup and inclusion of all the different ``.tex`` files. 
In general you want to compile that file, however, the explanation of how to compile has been abstracted to how compile in general.

### Using VS Code

1. Press the green button to compile

2. The file has been compiled into a pdf with the same name

3. A small icon next to the compile button, opens a preview of the pdf next to the editor, which updates upon re-compiling

<!-- ### Using commandline -->

# Project settings

## General settings for Latex

Place the following file in ``/.vscode/`` (create if it does not exist)

settings.json :

```json
{
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.outDir": "out",
    "latex-workshop.latex.autoClean.run": "onBuilt",
        "latex-workshop.latex.clean.fileTypes": ["chapters*/", "setup*/", "specials*/"],
    "latex-workshop.latex.clean.fileTypes": [
        "chapters*/",
        "setup*/",
        "specials*/"
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "--shell-escape",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-output-directory=%OUTDIR%",
                "-pdf",
                "%DOC%"
            ]
        },
        {
            "name": "biber",
            "command": "biber",
            "args": [
                "%DOC%"
            ]
        },
        {
            "name": "makeglossaries",
            "command": "makeglossaries",
            "args": [
                "%DOCFILE%"
            ]
        }
    ]
}
```


## Settings for ``MakeGlossaries`` package

This file should be at the same directory level as main.tex or master.tex

.latexmkrc :

```
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] ); #handle -outdir param by splitting path and file, ...
    pushd $path; # ... cd-ing into folder first, then running makeglossaries ...

    if ( $silent ) {
        system "makeglossaries -q '$base_name'"; #unix
        # system "makeglossaries", "-q", "$base_name"; #windows
    }
    else {
        system "makeglossaries '$base_name'"; #unix
        # system "makeglossaries", "$base_name"; #windows
    };

    popd; # ... and cd-ing back again
}
```
