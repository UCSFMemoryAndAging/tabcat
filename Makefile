# Copyright (c) 2013, Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   1. Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This mostly ties together other makefiles. Most of the interesting stuff is in
# core/Makefile and tasks/Makefile.default
include Makefile.common  # $(TABCAT_HOST) and $(PUSHED)

# each task gets its own target (e.g. "line-orientation")
TASK_TARGETS = $(patsubst tasks/%/kanso.json, %, $(wildcard tasks/*/kanso.json))
TASK_MAKEFILES = $(patsubst %, tasks/%/Makefile, $(TASK_TARGETS))

# tabcat config. this needs to not 404 for offline manifest to work
DEFAULT_CONFIG = config-default.json
CONFIG_URL = $(TABCAT_HOST)/tabcat-data/config

# offline manifest
KANSO_FILES = core/kanso.json $(wildcard tasks/*/kanso.json)
MANIFEST = cache.manifest
MANIFEST_DEPS = $(shell scripts/json-ls /attachments $(KANSO_FILES))
MANIFEST_URL = $(TABCAT_HOST)/tabcat/offline/$(MANIFEST)

.PHONY: all core tasks clean $(TASK_TARGETS)

all: core $(TASK_TARGETS) $(PUSHED)

core:
	$(MAKE) -C core

tasks: $(TASK_TARGETS)

$(TASK_TARGETS): %: tasks/%/Makefile
	$(MAKE) -C tasks/$@

# no real magic here; just symlink to Makefile.default if the task doesn't
# have its own Makefile
$(TASK_MAKEFILES): %:
	if [ ! -e $@ ]; then cd $(@D); ln -s ../Makefile.default Makefile; fi

$(MANIFEST): scripts/make-manifest $(KANSO_FILES) $(MANIFEST_DEPS)
	$< $(KANSO_FILES) > $@.tmp
	mv -f $@.tmp $@

# create the config file, if it exists, and upload the manifest
$(PUSHED): $(DEFAULT_CONFIG) $(MANIFEST)
	scripts/put-default $(DEFAULT_CONFIG) $(CONFIG_URL)
	scripts/force-put $(MANIFEST) $(MANIFEST_URL) text/cache-manifest
	for path in $$(grep -v '^ *#' old-docs.txt); do scripts/force-delete $(TABCAT_HOST)/$$path; done
	touch $@

clean:
	$(MAKE) -C core clean
	for task in $(TASK_TARGETS); do if [ -e tasks/$$task/Makefile ]; then $(MAKE) -C tasks/$$task clean; else $(MAKE) -C tasks/$$task -f ../Makefile.task clean; fi done
	rm -f *~
