# EulerPyToOrgMode

## TL;DR

### Practice

1. Open `py_euler.org`

2. Find solution for first problem, mark DONE, do next problem

### Generate

The script `py-euler-to-org.sh` leverages the [iKevinY/EulerPy](https://github.com/iKevinY/EulerPy) command line tool to grab problems from Project Euler. It then takes the files generated by EulerPy, and converts the files into OrgMode Babel Source Blocks and puts them all in a single OrgFile.

#### Using py-euler-to-org.sh

1. `pip install -r requirements.txt`

*note: you may want to setup a new virtualenv as to not disrupt your systems python configuration*

2. `sh ./py-euler-to-org.sh` to see the various options

    a. `sh ./py-euler-to-org.sh all` gets all the problems and converts them into a single org file.

## TODO

- [ ] Remove dependency on EulerPy and convert to Emacs Mode.
