.PHONY: all test clean help

all: reload provision test                            ## Run tests after (re)loading and (re)provisioning vagrant boxes.

help:                                                 ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

reload: halt up                                       ## Reload vagrant box.

halt:                                                 ## Stop vm-test vagrant box
	vagrant halt vm-test

up:                                                   ## Start vm-test vagrant box
	vagrant up vm-test

full_provision:                                       ## Make sure everything is set up
	vagrant provision vm-test

provision:                                            ## Quick provision
	vagrant ssh vm-test -c 'sudo salt-call --local state.highstate'

ifdef TESTPROFILE
CUKE_PROFILE_ARG=--profile $(TESTPROFILE)
endif

ifdef TESTBROWSER
BROWSER_ARG=BROWSER=$(TESTBROWSER)
endif

ifdef FEATURE
CUKE_ARGS=-n "$(FEATURE)"
endif

test:                                                 ## Run cucumber tests.
	vagrant ssh vm-test -c 'cd vm-test && $(BROWSER_ARG) cucumber $(CUKE_PROFILE_ARG) $(CUKE_ARGS)'

test_one:                                             ## Run one test only.
	vagrant ssh vm-test -c 'cd vm-test && $(BROWSER_ARG) cucumber $(CUKE_PROFILE_ARG) -n "Search on koha"'

clean_report:                                         ## Clean cucumber reports.
	rm -rf test/report || true

clean: clean_report                                   ## Destroy vm-test box.
	vagrant destroy vm-test --force

sublime: install_sublime                              ## Run sublime from within vm-test.
	vagrant ssh vm-test -c 'subl "/vagrant" > subl.log 2> subl.err < /dev/null' &

install_sublime:
	vagrant ssh vm-test -c 'sudo salt-call --local state.sls sublime'
