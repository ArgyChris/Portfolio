# UNIX script

This project purpose is to write a UNIX bash script that could find files with a certain, predefined, suffix below a target location. It also includes a switch to apply a regular expression in order to select the files.

## Getting Started

### Prerequisites

The prerequisite structure that the script was developed and tested included some dummy files (file.txt, file1.txt, file3.txt, ... , file5.txt), and a subfolder with a copy of file3.txt. A similar structure is not required. The script can work under different scenarios. 

### Installing

Go to the directory where the script is located. In order to be able to run the script, change the permission:

```
sudo chmod +x BashFile.sh
```
## General Structure

Initally, the script name is called together with 4 arguments. 1) the absolute path of the files location, 2) the suffix, 3) the absolute path of an .txt, where the file names will be written in an output, and 4) the applied regular expression. The code can accept an empty regular expression which correspond to an unfiltered result.

In the main code, the arguments are parsed by a function that first performs a check in the file location, and then proceeds to the switch case to handle the empty/non-empty regular expression case.

The output is .txt file that contains the selected file names in absolutes path, with each path on its own line.


## Running the code

An example to run the code is given:

```
argy@Argy:/home/argy/Portfolio/Bash$ ./BashFile.sh /home/argy/Portfolio/Bash/ .txt /home/argy/Portfolio/Bash/output.txt f......t
```
The previous outputs:
```
Input variables:
pathlocation:/home/argy/Portfolio/Bash/
suffix:.txt
output filename:/home/argy/Portfolio/Bash/output.txt
regular expression:f......t

The input pathlocation is a directory
Write files that satisfy the regular expression: f......t
Target file for the output: /home/argy/Portfolio/output.txt
Success

```
## Authors

* **Argyrios Christodoulidis** - [email](mailto:argyrios.christodoulidis@gmail.com)
