vm-test
======

Vagrant virtual machine for running browser tests with Cucumber.

This setup uses [Vagrant](http://www.vagrantup.com/) for local virtualisation
and [SaltStack](http://docs.saltstack.com/) for automated provisioning.

## Usage

1. Install virtualbox and vagrant (and X11-server on OSX/Windows - for development):
    - Ubuntu:
        * `sudo apt-get install virtualbox`
        * vagrant > 1.5 - install deb manually: https://www.vagrantup.com/downloads.html
    - OSX: We recommend using [homebrew](http://brew.sh/) and [homebrew cask](http://caskroom.io/), but you can install these manually if you prefer (see download links).
        * `brew cask install virtualbox` -- or [Virtualbox Downloads](https://www.virtualbox.org/wiki/Downloads)
        * `brew cask install vagrant` -- or [Vagrant Downloads](https://www.vagrantup.com/downloads)
        * `brew cask install xquartz` -- or [XQuartz Download](http://xquartz.macosforge.org/landing/)
    - Windows:
        * Download and install "VirtualBox platform package" for Window hosts: [Virtualbox Downloads](https://www.virtualbox.org/wiki/Downloads)
        * Download and install Vagrant for Windows: [Vagrant Downloads](https://www.vagrantup.com/downloads)
        * Reboot your machine.
        * Install Cygwin/X by following this procedure: [Setting Up Cygwin/X](http://x.cygwin.com/docs/ug/setup.html)
          - Important! In step 15 you must also choose the following packages:
            * git
            * make
            * openssh
          - We also recommend these:
            * curl
            * git-completion
            * tig
            * vim
            * wget
        * After installing Cygwin/X Windows users should use the program "XWin Server" for commands like git, make etc.
2. Clone this repo from the command line (in a directory of your choice):
   ```git clone https://github.com/akafred/browsertests.ext.git```
3. `cd ls.ext` into your cloned repo. 
4. Then change to this branch: `git checkout vm-test-only`
4. From the command line run: `make` to bootstrap the environment and run the tests.

Run `make help` for more commands.

### Adding graphical browser support

If you want a different browser than headless phantomjs in testing, we have installed firefox in vm-test and use X11
forwarding over ssh to show you the browser window as you run the test from inside vm-test.

To use you can either set `TESTBROWSER=<your favorite browser>` as an environment variable on your system or pass it to `make`. We currently support the following browsers:
- firefox
- chrome (we actually use chromium-browser)

Example:
`make test TESTBROWSER=firefox`  (  -- or  `TESTBROWSER=firefox make test` )

### Running development tools from inside the vm-test virtual machine

These tools also need support for X11 forwarding on the host.

* Sublime: `make sublime`

### Running a single test

You can pass arguments to Cucumber, e g which feature to test, like this (you must include `TESTPROFILE=wip` if it is a scenario which is still marked as work-in-progress (`@wip`):

```
make test TESTPROFILE=wip CUKE_ARGS='features/demonstration.feature'
```

### Running a single test or scenario

You can also run a single feature or scenario by title:

```
make test FEATURE="Title of feature|scenario"
```

### Typical workflow for creating new feature test

The first step for creating a new feature is authoring a test, in this case a verbal description of how you want the system to perform. This is a step-by-step decription of how you do this from your computer. You need to have completed the steps above to make this work.

1. Open terminal
2. Change directory to LS.ext by typing

   ```
cd (foldername where you keep your projects)/browsertests/test/features
```
Then type

    ```
git up
```

3. Open the editor of your choice to create the test

   - create a file name for the feature you are writing a test for
   - start by adding a "Egenskap" that explains the feature in the simplest way
   - Then follows the typical "User story" format (with one change).

      ```
Feature: Title of the feature
  As a (role)
  I want to (what you want to accomplish)
  So therefore I need (what you want to do)
```

      It often makes for bad grammar, but helps us focus on what we want to achieve, rather than how we achieve it.

  - Then you add the Scenario description. Add @wip before the scenario to make sure the test is not run until the feature is done.

    Format:

    ```
  Scenario: Title of the scenario
    Given (condition and precondition)
    And (another condition or precondition)
    When (user input)
    And (another user input)
    Then (expected result)
    And (another expected result)
```
    (you can have none or several "and" to each step)

    Please follow formatting and spacing rules from the other test descriptions

4. Return to the terminal to ensure the test is in proper format

    ```
make test TESTPROFILE=wip
```

5. Stay in the terminal to commit the changes to github

    ```
git up
```

    to check you have all the latest changes from github

    ```
git status
```

    to check the difference between your version and the master

    ```
git add (the filename(s) you want to push to github)
```

    ```
git commit -m "free text description of the change (less than 50 characters)"
```
    and finally

    ```
git push
```

## Illustration
![Alt text](stack.png?raw=true "Stack")
