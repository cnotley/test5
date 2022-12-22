# Overview
Module provisions EC2 Instance of the given size with User-specified operating system.<br><br>
During deployment it enables to set up a custom application environment through
shell install script (e.g. installation of 3PP software etc.).<br/><br/>
There is also a possibility to connect to the Instance via SSH using `ssh_command` field
value from module outputs (assuming that User provided his /her public SSH key during module
provisioning).

## Supported host operating systems
- Linux Ubuntu 20.04
- Linux Ubuntu 18.04

# Components
- EC2 Instance
