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

include ../Makefile.common  # $(TABCAT_HOST) and $(PUSHED)

# CoffeeScript to compile into JavaScript
COFFEE_SRC = $(shell find . -name '*.coffee' -not -name '.*')
COFFEE_JS = $(patsubst %.coffee, %.js, $(COFFEE_SRC))

TABCAT_COFFEE_SRC = $(wildcard js/tabcat/*.coffee)
TABCAT_COFFEE_JS = $(patsubst %.coffee, %.js, $(TABCAT_COFFEE_SRC))
TABCAT_GENERATED_JS = js/tabcat/generated.js

# put jquery before other libs that might depend on it
VENDOR_JS = js/vendor/jquery.js $(filter-out jquery.js, $(wildcard js/vendor/*.js))

# files kanso expects to push
KANSO_DEPS = $(shell ../scripts/json-ls /attachments+/modules kanso.json)

.PHONY: all
all: $(PUSHED)
	@: # suppress "nothing to be done for "all" message

.PHONY: clean
clean:
	rm -f $(COFFEE_JS)
	rm -f js/tabcat.js js/tabcat.js
	rm -f .pushed-*
	find . -name '*~' -delete

design.json: kanso.json $(KANSO_DEPS) $(MANIFEST)
	kanso install
	kanso show > $@

# $(KANSO_DEPS) should include js/tabcat.js
#
# It's fine if we can't upload the config; we just want to ensure there is one.
$(PUSHED): design.json
	../scripts/force-put $< $(TABCAT_HOST)/tabcat/_design/core
	../scripts/force-put $< $(TABCAT_HOST)/tabcat-data/_design/core
	touch $@

ifeq ($(TABCAT_DEBUG), 1)
# force rebuild of js/tabcat.js
.PHONY: js/tabcat.js
js/tabcat.js: $(VENDOR_JS) $(TABCAT_COFFEE_JS) $(TABCAT_GENERATED_JS)
	cat $^ > $@
else
js/tabcat.js: $(VENDOR_JS) $(TABCAT_COFFEE_JS) $(TABCAT_GENERATED_JS)
	uglifyjs $^ -c warnings=false -o $@
endif

$(COFFEE_JS): %.js: %.coffee
	coffee -c $<
	if which coffeelint; then coffeelint -q $<; fi

$(TABCAT_GENERATED_JS): kanso.json ../scripts/json-ls
	echo "TabCAT.version = '$(shell ../scripts/json-ls version $<)';" > $@
