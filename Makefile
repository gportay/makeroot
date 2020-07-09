#
# Copyright 2019-2020 Gaël PORTAY
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

PREFIX ?= /usr/local

.PHONY: all
all:

.PHONY: install
install:
	install -Dm755 makeroot $(DESTDIR)$(PREFIX)/bin/makeroot
	cp -a aarch64-makeroot amd64-makeroot arm64-makeroot x86_64-makeroot $(DESTDIR)$(PREFIX)/bin/

.PHONY: tests
.SILENT: tests
tests: override MAKEROOTFLAGS += --dry-run
tests: machine-tests x86_64-tests aarch64-tests debarchs-tests
	bash makeroot $(MAKEROOTFLAGS) --distro debian test-debian
	bash makeroot $(MAKEROOTFLAGS) --distro fedora test-fedora

.PHONY: machine-tests
.SILENT: machine-tests
machine-tests:
	bash $(shell uname -m)-makeroot $(MAKEROOTFLAGS) --distro debian test-debian-$(shell uname -m)
	bash $(shell uname -m)-makeroot $(MAKEROOTFLAGS) --distro fedora test-fedora-$(shell uname -m)

.PHONY: x86_64-tests
.SILENT: x86_64-tests
x86_64-tests:
	bash x86_64-makeroot $(MAKEROOTFLAGS) --distro debian test-debian-x86_64
	bash x86_64-makeroot $(MAKEROOTFLAGS) --distro fedora test-fedora-x86_64

.PHONY: aarch64-tests
.SILENT: aarch64-tests
aarch64-tests:
	bash aarch64-makeroot $(MAKEROOTFLAGS) --distro debian test-debian-aarch64
	bash aarch64-makeroot $(MAKEROOTFLAGS) --distro fedora test-fedora-aarch64

.PHONY: debarch-tests
.SILENT: debarch-tests
debarchs-tests:
	bash arm64-makeroot $(MAKEROOTFLAGS) --distro debian test-debian-arm64
	bash amd64-makeroot $(MAKEROOTFLAGS) --distro debian test-debian-amd64

run-debian run-fedora:
run-%:
	bash makeroot $(MAKEROOTFLAGS) --distro $* rootfs-$* $($*_PACKAGES)
