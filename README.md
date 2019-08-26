# Autolab OneClick Installation

This is a customized installer for CMU DL "passing together" course.
The idea is to make it very simple for users to join. Users can only sing in using github oauth,and then automatically subscribed to the only course: CMUDL


## Differences in installer

* removed sudo ops from install.sh, installation can be done as a normal user with no special rights except for docker.
* presume that docker is installed and current user is in docker group.
* docker compose is modernized to version 3
* database volume is created as docker volume
* courses volume is created as docker volume.
* do not copy Autopopulated course

## Patches to Autolab

* uglifier version upgraded to use harmony: true
* Autopopulate with "CMUDL" course
* create only 1 admin user
* github-oauth added to Gemfile
* github-oauth is the only auth method left. When user is logged in with github oauth, he/she is automatically subsribed to "CMUDL"
* Attention: github app id and secret must be added to the live container!



# Original README

Autolab-OneClick is the fastest way to install a full autograding environment and course management system!

You can setup Autolab in a [local](https://github.com/autolab/autolab-oneclick/wiki/Autolab-Local-Installation) or [server](https://github.com/autolab/autolab-oneclick/wiki/Autolab-Server-Installation) environment

Contact autolab-dev@andrew.cmu.edu for questions. Please fill out Github issues if you encounter any problems.
