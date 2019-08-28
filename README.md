# Autolab OneClick Installation

This is a customized installer for CMU DL "passing together" course.
The idea is to make it very simple for users to join. Users can only sing in using github oauth,and then automatically subscribed to the only course: CMUDL. There is no need in sign-upda, confimation email, password changes etc.


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

## Customization

### Autolab 

* edit `cover/autolab.rack` to set your admin_email
* edit `cover/autolab.rack` to set custom pre-created course name
* edit `cover/create_ods_user.rb` to set a course name to automatically subscribe a newly signed in user.
* edit `cover/new.html.erb` to customize login page.

Once your images are built and the containers are up, login to the local_web_1 container:

`docker exec -it local_web_1 bash`

Find devise.rb and put there your github app id and secret. If you can suggest a better way, please do. I could not make .env working here.

### Grading images

Go to live tango container:

`docker exec -it local_web_1 bash`

and then pull your image,  i.e.:

`docker pull datamove/cmudlimage:torch100`

Then you need to retag the image, since Tango doesn't like / in the image:

`docker tag datamove/cmudlimage:torch100 cmudlimage_torch100`

`cmudlimage_torch100` is what you use in Autograder section of your assignment settings.

## Debugging

Note, Autolab is cloned from its repo during the installation, so as it evolves, patches applied by the installer may become incompatible.

You do not have to clone Autolab every time, i.e. instead of running install.sh with your changes, you can just use docker:

`docker-compose up -d`

and optionally `web rake` commands to reset the db.


## Debugging users

Use `rails console` inside the container:

```
User.all
User.first
User(where ...).first
User.new(...).save
```

To create a new user use code sample from autolab.rake.

## Acknowledgements

* Petr Ermakov (datagym.ru, dlcourse.ru) for driving this project.
* Nick Bienko (@bikolya at ODS Slack) for adapting Autolab to this work mode.

# Original README from Autolab team

Autolab-OneClick is the fastest way to install a full autograding environment and course management system!

You can setup Autolab in a [local](https://github.com/autolab/autolab-oneclick/wiki/Autolab-Local-Installation) or [server](https://github.com/autolab/autolab-oneclick/wiki/Autolab-Server-Installation) environment

Contact autolab-dev@andrew.cmu.edu for questions. Please fill out Github issues if you encounter any problems.
