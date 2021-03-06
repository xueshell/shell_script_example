#
# Copyright (c) 1990 Michael A. Cooper.
# This software may be freely distributed provided it is not sold for 
# profit and the author is credited appropriately.
#
# $Header: /src/common/usc/bin/qterm/RCS/Makefile,v 5.1 1991/02/20 02:31:50 mcooper Exp $
#
# Makefile for QTerm
#

#
# DIR is the main/top-level directory.
# If you change DIR, run "make reconfig".
#
DIR = /usr/usc

#
# BIN is were the "qterm" binary gets installed.
#
BIN = $(DIR)/bin

#
# MAN is the directory where the "qterm.1" man page goes.
#
MAN = $(DIR)/man/man1

#
# TABFILE should be set to the location you want the qterm table
# file placed in.
#
TABFILE = $(DIR)/lib/qtermtab

#
# Add "-DUSG5" to DEFS below, if your system is Unix System V.
# Add "-DHAS_VARARGS" if your system supports varargs.
# Add "-DOPT_COMPAT" if you want compatibility with old command line options.
#
DEFS 	= -DTABFILE=\"$(TABFILE)\" -DOPT_COMPAT

#
# On some System V systems you will need to add "-lPW" to LIBS.
#
LIBS	=


CONFIGFILES	= Makefile qterm.1 options.3
CFILES 		= qterm.c options.c
HFILES		= qterm.h options.h
OBJS 		= qterm.o options.o
CFLAGS 		= -O $(DEFS)


qterm: $(OBJS) $(HFILES)
	$(CC) $(CFLAGS) $(OBJS) -o qterm $(LIBS)

reconfig:
	-@for i in $(CONFIGFILES); do \
                echo ReConfiguring $$i...;\
		sed "s;/usr/usc;$(DIR);g" < $$i > $$i.tmp;\
		mv -f $$i.tmp $$i;\
        done

$(OBJS): $(HFILES)

shar:
	shar README qtermtab $(CONFIGFILES) $(CFILES) $(HFILES) > qterm.shar

clean:
	rm -f *.o core log *~ \#* qterm qterm.shar o

#
# Install target for BSD machines.
#
install: qterm qterm.1 qtermtab
	install -c -m 755 qterm $(BIN)
	install -c -m 644 qterm.1 $(MAN)
	install -c -m 644 qtermtab $(TABFILE)

#
# Install target for System V machines.
#
install.usg5: qterm qterm.1 qtermtab
	cp qterm $(BIN); chmod 755 $(BIN)/qterm
	cp qterm.1 $(MAN); chmod 644 $(MAN)/qterm.1
	cp qtermtab $(TABFILE); chmod 644 $(TABFILE)
