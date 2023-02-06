# Disclaimer

This guide is for how to install LaTeX and how to compile LaTeX using VS Code as the IDE.

This guide assumes the system uses the ``apt`` package manager.

# Install LaTeX

1. Install WSL

2. Install VS Code

3. Run installation script (``setupWSL.sh``) in WSL

4. Ready to use


## Install WSL

Follow guide from: https://learn.microsoft.com/en-us/windows/wsl/install


## VS Code

Download from: https://code.visualstudio.com/  
Install the following extensions:

1. Latex-Workshop *by James Yu* - [Marketplace](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)

2. Remote Development *by Microsoft* - [Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)


## Command to execute script

You may need to enter your password for the user

```bash
sudo chmod u+x setup.sh && ./setup.sh
```


## Installation script

setupWSL.sh :

```bash
#!/bin/bash

LIST_OF_PACKAGES="build-essential texlive-full python3-pygments python-is-python3 openjdk-11-jdk"
sudo apt update && sudo apt upgrade -y && sudo apt install ${LIST_OF_PACKAGES} -y
```


# How to use LaTeX

## How to open a project

### Manually opening the project

1. Enter the path in WSL / Navigate to the project in WSL
    - To access the Windows files you need to go to the path ``Ubuntu/mnt/{Path In Windows Including the Drive}``

2. Enter the following command to launch VS Code (If using other IDE use its launch command)

```Bash
code .
```


### Use a script to open the project

WSL default starting path is ``/Ubuntu/home/{Profile-name}``, a bash script can be made to automatically enter the path of the project and open it in VS Code.

1. Make a file which opens the project by using the following command

```Bash
touch open.sh
```

2. Open the file using VIM

```Bash
vim open.sh
```

3. Insert the following script

open.sh :

```Bash
#!/bin/bash

cd ../../mnt/{Path In Windows Including the Drive}
code .
```

Example :

```Bash
#!/bin/bash

cd ../../mnt/c/Users/AAU/Projects/P1/
code .
```

4. To exit VIM press the esc-button, write ``:wq`` and press enter

5. To run the script enter the follwing

```Bash
./open.sh
```


## How to compile the project

### Generally

The project most likely contain either a ``master.tex`` or ``main.tex`` which makes setup and inclusion of all the different ``.tex`` files. 
In general you want to compile that file, however, the explanation of how to compile has been abstracted to how compile in general.


### Using VS Code

1. By having the extension package *Latex-Workshop* a green playbutton will apear in the upper right corner which will compile the current ``.tex`` file

2. Open the file you want to compile

3. Press the green playbutton. The file will now compile and you can open the pdf named after the file

4. A small icon next to the playbutton will give you the possibility to open a preview of the pdf next to the editor - and upon re-compiling the preview will update to the new pdf


### Using commandline

*Comming soon in a theater near you*


# Project settings

## General settings for Latex

Place the following file in ``/.vscode/``

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
