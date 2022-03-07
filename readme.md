# Multi-Plate-KiCad6
An automation tool (shell script) to setup multiple KiCad 6 projects under one git repository. 

## Who Would Want Such a Tool ?
If you require to break down a large system made of KiCad6 based designs, this tool will help you setup the individual kicad projects, within a root folder(which is incedently the git reposiotry for you larger system) without the need for all the manual labor.

# Time To Boiler-Plate!
1. clone this repository in a desirable folder:
```
 git clone https://github.com/higherSentinel/multi-plate-KiCad6.git
```
2. setup your subsystems on the dir.config file, make sure to stick to the following regex for naming : ```"^[a-zA-Z0-9]*$"```. Example below shows the content of the dir.config which contains cnfiguration for 3 boards.
```sh
# list the name of the kicad projects that you would like the setup script to create on each line
# make sure to only include characters from the following regex : ^[a-ZA-Z\-]*$

board1
board2
board3

```
3. prepare the root repository, you'll need to make this on your own :)
4. run the shell script.
```sh
source setup-folders.sh "a valid path to your git repository folder"
```
5. that's it, your all set to go on you KiCad6 project's'.