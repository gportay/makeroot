#
# Copyright 2019 Gaël PORTAY
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

PREFIX ?= /usr/local

.PHONY: all
all:

.PHONY: install
install:
	install -Dm755 makeroot $(DESTDIR)$(PREFIX)/bin/makeroot
	cp -a amd64-makeroot arm64-makeroot $(DESTDIR)$(PREFIX)/bin/
