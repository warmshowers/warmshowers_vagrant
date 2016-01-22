# Welcome to the Warmshowers Vagrant
This vagrant machine is intended to be used for quick and easy local development on the warmshowers.org project.

This is a draft version, please be patient while we get this working.

### Prerequisites
Before you get started you must install <a href="https://www.virtualbox.org/wiki/Downloads">VirtualBox</a> and <a href="https://www.vagrantup.com/downloads.html">Vagrant</a>

To get a copy of the sanitised Warmshowers.org database you must introduce yourself to the <a href="mailto:andrew@kalpaitch.com">project maintainers</a> and supply us with your public key. For more information please read <a href="https://help.github.com/articles/generating-an-ssh-key/">Github's guide on generating public your public key</> or contact us.

### Getting started
To get started run:
```
git clone -b master https://github.com/warmshowers/warmshowers_vagrant ws
cd ws && vagrant up
```

This will bring up a virtual machine and provision it with a copy of the warmshowers.org project.
