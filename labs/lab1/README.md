<a href="https://dei.tecnico.ulisboa.pt/"><img style="float: right;" src="../../res/logodei.png"></a>

# [AGISIT 24/25](https://fenix.tecnico.ulisboa.pt/disciplinas/AGI11/2024-2025/1-semestre)

# Lab 1 - Environment Setup

## Overview
This first lab script is very simple and its goal is to install some basic tools that you will need and to illustrate how they can be used to create a virtual platform (in this case a single virtual machine) in an automated way.

The subsequent five lab scripts (2 through 6, weeks 3 through 7) describe more complex experiments which are followed by an individual assessment, providing 50% of the final evaluation grade by a simple average. Lab assessments will be available on Moodle and consist of questions to be answered based on the results obtained throughout the lab experiments and the knowledge gained from them. Lab 6 is optional. If answers are submitted, only the best four grades out of the five lab grades (2 to 6) will be used. Lab 1 questions will also be provided to help you familiarize with Moodle and the evaluation process, but they will **not** be considered in the final grade.

These experiments will be conducted on your own personal computer, in which you have administrator privileges and can install the required tools. Access to a public cloud will also be needed, but that will be provided.

You should use lab classes mainly to get support for solving exercises in which you had problems. Going to the lab classes to read the lab tutorials for the first time and to see what is there to be done, without reading the script first, is discouraged.

The Capstone Project, to be executed throughout the quarter, will provide the remaining 50% of the evaluation grade. The corresponding deliverable should be submitted to Fenix before the end of the quarter. 

All the lab scripts and the Capstone Project specification will be available beforehand in Fenix. The lab questions will be available on Moodle and the solution of the Capstone Project must be submitted to Fenix.

## BYOD (Bring Your Own Device) Lab Environment Preparation
One nice feature of the software stack you are going to use for the Lab experiments and in the Capstone Project is that it is portable to many platforms including YOUR OWN personal computers.

The instructions below will help you to configure your Laptop or Desktop properly, and are suitable for machines running the following Operating Systems:

- Microsoft Windows from version 10 up
- Apple macOS from versions 10.14 'Mojave' up (when using Apple’s M1/M2 chip some instructions are different to set up the environment)
- Debian-based Linux, such as Ubuntu (recommended) from versions 18.04 'Bionic' up.

For other computing environments or Operating Systems (except mobile devices), you should be able to make the necessary adaptations to arrive at the desired software stack.

Although you could also use a Raspberry Pi 4 (with a Hypervisor and Ubuntu), that is not advisable 😂.

Although also possible, it is **not recommended** to apply this setup to a virtual machine (nested virtualization), since the configuration requires access to a hypervisor environment (in our case, VirtualBox) in the host system. This is not applied to computers based on the Apple chips because the solution is based on Docker other than Virtualbox.

For the aforementioned Operating Systems, the setup makes use of package managers in order to turn the process well controlled (versions, updates), simple to cleanup and not affecting the host environment.

**Note:** Beware when copying text strings from the command line examples or configuration texts, since pasting them directly into your system or files may introduce/modify some characters, leading to errors or inadequate results.


## Setting up the Environment
This section describes the minimum setup of the experimental environment for systems running Windows,
macOS and Linux.

We recommend (and use) the following tools or programs:

- **wget**: (recommended) a non-interactive tool to download files from the web, using HTTP/HTTPS.
- **git**: (mandatory) GIT is a distributed version-control system for tracking changes in source code.
- **vagrant**: (mandatory) Vagrant is an open-source product for building and maintaining portable virtual development environments.
- **atom**: (optional) Atom is a free and open-source text and source code editor.
- **Vscode**: (recommended) Visual Studio Code is a free and powerful, based on open-source, code editor from Microsoft.

Additionally, for Windows, macOS (Intel) and Linux:

- **virtualbox**: (mandatory) Oracle VM VirtualBox is a free and open-source hosted hypervisor for x86 virtualization.
- **virtualbox extension pack**: (mandatory) for Oracle VM VirtualBox support of USB, cloud integration features, etc.

For, macOs (Apple chips):
- Do not try to install VirtualBox in this environment, it will not be supported.
- docker: (mandatory) [Docker desktop](https://www.docker.com/products/docker-desktop/) enables to build and run containerized applications

### Microsoft Windows Setup
The recommended Package Managers for Microsoft Windows are [Chocolatey](https://chocolatey.org/) or [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/), similar to Linux **apt** or **yum**.

On your machine, it is recommended that you create a directory (folder) for your projects, named for example **Projects**, but **NOT LOCATED under the C:\Users** folder.

    C:\> mkdir C:\Projects

**IMPORTANT**: you MUST also ensure that there are no spaces or accented characters in the PATH name of your User folder, due to character encoding on some versions of Windows 10 systems, not being UTF-8, unless specifically configured.

If using Chocolatey, to install the packages/applications you just do the following, after opening a **Command Prompt** or a **Powershell** Console, with **Administrator privileges**:

    C:\> choco install wget
    C:\> choco install git.install --params "/GitAndUnixToolsOnPath"
    C:\> choco install virtualbox
    C:\> choco install vagrant
    # OPTIONAL
    C:\> choco install atom
    C:\> choco install vscode

You also need to download and install the [Virtualbox Extension Pack](https://download.virtualbox.org/virtualbox/6.1.38/Oracle_VM_VirtualBox_Extension_Pack-6.1.38.vbox-extpack). After downloading, open again a **Command Prompt** or a **Powershell** Console, with Administrator privileges and run the following command (adapt for the version downloaded):

    C:\> cd "c:\Program Files\Oracle\VirtualBox"
    C:\Program Files\Oracle\VirtualBox> vboxmanage extpack install extension_pack_path

Where ``extension_pack_path`` can be, e.g.: ``c:\downloads\Oracle_VM_VirtualBox_Extension_Pack-6.1.38.vbox-extpack``

After this point, and in order to settle everything (Windows is quite tricky in updating environment variables), close the Console.

Additionally, as an SSH (secure shell) client was not distributed with some versions of Windows 10, until recently, it may be necessary to tell the system where to find the SSH client installed with GIT:

- Open Control Panel
- Go to System and Security
- Click on System, then select Advanced system settings
- Select Environment Variables...
- Look for the Path variable in the System variables list, select it then Edit...

At the end of the string, confirm if exists a path such as the following, otherwise add the path pointing to Git's bin folder:

    C:\Program Files\Git\bin\;C:\Program Files\Git\usr\bin

If all went well, you can test it by opening a Console and writing the following commands to get the help information:

    > git --help
    > ssh

### Apple macOS Setup ``(attention to the Apple chips specific instructions)``

The recommended Package Manager for macOS is [Homebrew](http://brew.sh/), similar the Linux **apt** or **yum**. 

Homebrew installs packages (binary or to be compiled from source) to their own directory and then symlinks their executables typically into \textit{/usr/local}. Homebrew provides a Cask option, that extends Homebrew and brings its elegance, simplicity, and speed to the installation and management of GUI macOS applications such as Google Chrome, Visual Studio Code, etc.

As a first step, you may need to install Command Line Tools for XCode from Apple (free from the App Store), in order for Homebrew to be able to compile applications from their source code. Mac systems do not have any of the developer's Command Line tools installed by default, so we need to install them before we can get anywhere. If you do not have XCode installed, then open a Terminal and at the shell prompt type the following:

    > xcode-select --install

To install Homebrew, at the shell prompt copy the install script that you can find at http://brew.sh, similar to the following:

    > /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

The shell prompt will tell you what it is about to do, and ask you if you want to proceed: press Enter to do so. The shell prompt may then ask for a password: this is the password to the Admin account on your computer. Type your password, and press Enter again. When done, the shell prompt will say that the installation was successful, and ask you to run the command:

    > brew doctor

This will make Homebrew inspect your system and make sure that everything is set up correctly. If the shell prompt informs of any issues, you will need to fix them, and then run that command again to verify that everything was fixed correctly. When everything is set up correctly, you will see the message Your system is
ready to brew, and so, move on.

It is now time to install the other packages for the Lab experiments environment. Open Terminal and install the following programs using Homebrew:

    > brew install wget
    > brew install git
    > brew install --cask virtualbox #skip this instruction if using an Apple chip
    > brew install --cask virtualbox-extension-pack #skip this instruction if using an Apple chip
    > brew install --cask vagrant
    > brew install --cask atom
    > brew install --cask visual-studio-code

For each command, the Terminal will start displaying lots of information, as Homebrew is keeping you updated on what it is doing. This flow of information will be a guide to let you know whether the computer is still working and, if so, do not interrupt it.

Now it is the time to create a directory/folder for your Lab projects, for example, in an external Disk named MEDIA:

    :~$ mkdir /Volumes/MEDIA/Projects

### Linux

For a Linux system, namely a Debian-based Ubuntu, the standard package manager **apt** (Aptitude) is already present, as well as some packages, such as **wget**.

To install the other packages, open a Terminal and use commands similar to the following (answer Y to the prompts, and several dependencies will also be installed):

    > sudo apt-get -y update
    > sudo apt-get -y upgrade
    >
    > sudo apt-get -y install git

Some packages are also available as **Snap Packages**. In the case of Visual Studio Code, you can install it with the following command:

    > sudo snap install --classic code

Please note that for latest distributions of Ubuntu, a careful install of **Oracle Virtualbox** is required, as the package architecture has to match the Linux kernel architecture.

Additionally, the VirtualBox package in Ubuntu may have some issues when running in RAM-constrained environments. For that purpose, you need to ensure that you have the adequate sources referenced for your kernel architecture. As such, the recommendation is to follow the instructions in [Virtualbox in Debian-based Linux distributions](https://www.virtualbox.org/wiki/Linux_Downloads).

Finally, to install Vagrant we recommend you head to their official [download page](https://www.vagrantup.com/downloads) and follow the instructions provided for your specific distribution. If you encounter problems during the installation, the [official documentation](https://www.vagrantup.com/docs/installation) is a helpful resource.

After having the recommended and mandatory packages installed, it is better to reboot the system and then to create a directory for your Lab projects.

# Your (first ?) Vagrant Environment

If you have ever tried to create **Virtual Machines** used for testing through a Graphical User Interface (GUI), you know that it can be a pain, and it is a very manual process (installing the Operating System, the packages/applications, configure them, etc.).

There is also a tendency to leave testing machines around in your computer (even running and consuming precious resources) for a long time without rebuilding them (or even shutting them down).

Before **Vagrant**, there was a natural resistance to create clean environments, because there is an extra labor cost associated with making this happen, as it is just a very manual process via a GUI.

Vagrant eliminates much of that extra labor, as most of it is completely automated, so let us dive a little deeper into Vagrant.

If you run the `vagrant` command without any arguments, you will get the default help output, which displays available command options.

The main command options of Vagrant are used for managing the life cycle of Vagrant **boxes**.

A **Box** is a Vagrant term for a pre-built **virtual machine** template image. Vagrant boxes are special virtual machines, in that they typically have several required packages already pre-installed, and a **vagrant** user already added inside the image.

The ``vagrant box`` command allows to list, add, and remove boxes that Vagrant knows about in your system, for example:

    > vagrant box
    Usage: vagrant box <subcommand> [<args>]
    Available subcommands:
        add
        list
        outdated
        remove
        repackage
        update
    For help on any individual subcommand run `vagrant box <subcommand> -h`

The ``vagrant init`` command allows initializing a new Vagrant environment (without specific customizations).

A **Vagrant environment** can be a single Virtual Machine (or a Docker Container), or a collection of Virtual Machines (or Containers). Therefore, an environment will describe which boxes, Virtual Machines, and/or Containers to boot, along with all of the associated settings, through a **configuration file** named **Vagrantfile**, located in the directory where the environment will be created.

The other common command are ``vagrant up`` to boot the environment, ``vagrant halt`` to shut down the environment, ``vagrant global-status`` to check the status of instantiated Virtual Machines, ``vagrant destroy`` to completely destroy each instance of a Virtual Machine, and ``vagrant ssh`` to establish a secure session shell with (each) virtual machine that is running in the environment.

In order to ensure adequate updating and upgrading for Vagrant environments **using the Virtualbox provider**, you will need to add to Vagrant the ``vagrant-vbguest`` Plugin, by using the command:

    > vagrant plugin install vagrant-vbguest #skip this instruction if using an Apple chip

or, if already installed,

    > vagrant plugin update vagrant-vbguest #skip this instruction if using an Apple chip

If all set, you can now launch a very simple environment, following these steps:

1. In your ``Projects`` directory, use the Terminal/Console as previously explained to create another directory, with a name of your choice.
2. Inside that directory, create a pure text file named ``Vagrantfile`` with the content adequate to your set-up (use your preferred Code Editor, such as Atom or VsCode).  
**VERSION 1** is to be used by the students with the VirtualBox provider.  
**VERSION 2** is to be used by the students using the Docker provider.  
Please note that the ``Vagrantfile`` is a program script written in **Ruby** language:

**VERSION 1**

    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.vbguest.auto_update = false
    config.vm.box_check_update = false
    # create the (myvm) VM
    config.vm.define "myvm" do |vm_config|
    vm_config.vm.box = "ubuntu/bionic64"
    vm_config.vm.hostname = "myvm"
    vm_config.vm.network :private_network, ip: "192.168.56.10"
    vm_config.vm.provider "virtualbox" do |vb|
    vb.name = "myvm"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.memory = "256"
    end # of vb
    # Provisioning
    vm_config.vm.provision "shell", inline: 'sudo apt-get update; sudo apt-get -y install git'
    end # of vm_config
    end # of config

**VERSION 2**

    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    Vagrant.configure("2") do |config|
    config.vm.define "myvm" do |d_config|
    d_config.vm.hostname = "myvm"
    d_config.vm.network :private_network, ip: "192.168.56.10", netmask: "24"
    # create the (myvm) docker container
    d_config.vm.provider :docker do |docker, override|
    override.vm.box = nil
    docker.image = "rofrano/vagrant-provider:ubuntu"
    docker.remains_running = true
    docker.has_ssh = true
    docker.privileged = true
    docker.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:rw"]
    docker.create_args = ["--cgroupns=host"]
    # Uncomment to force arm64 for testing images on Intel
    # docker.create_args = ["--platform=linux/arm64"]
    end # of docker
    # Provisioning
    d_config.vm.provision "shell", inline: 'sudo apt-get -y update; sudo apt-get -y install git'
    end # of d_config
    end # of config

3. You can now start the process with the Terminal/Console opened in the directory where the ``Vagrantfile`` is, with the command ``vagrant up``.
4. You will start seeing a lot of information appearing in the Terminal/Console, meaning that the VM (or the container) is being created.
5. If all went well, you should now have a Virtual Machine (or a container) with Ubuntu running in your system.

In fact, that ``Vagrantfile`` is your first deployment of an **Infrastructure as Code** (IaC), in which the characteristics of a virtual platform are specified by a text file.

You can now establish a session with the created ``myvm`` system, using the following command:

    > vagrant ssh

The session is established and you will get the virtual machine prompt, similar to the following:

    Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 3.13.0-87-generic x86_64)
    Last login: Mon Sep 19 22:50:28 2022 from 10.0.2.2
    vagrant@myvm:~$

You can now exit the session with the command:

    vagrant@myvm:~$ exit
    logout
    Connection to 127.0.0.1 closed.

In order to stop the Virtual Machine and to verify the global state of all active Vagrant environments on the system, you can use the following commands:

    > vagrant halt
    myvm: Attempting graceful shutdown of VM…
    # or
    myvm: Stopping container…
    > vagrant global-status

Confirm that the status of the VM provided by the last command is **powered off**.
