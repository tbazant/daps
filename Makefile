# Makefile.in generated by automake 1.11.1 from Makefile.am.
# Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
# 2003, 2004, 2005, 2006, 2007, 2008, 2009  Free Software Foundation,
# Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.



# Makefile.am for DocBook Authoring and Publishing Suite (daps)
# Generate catalogs and install daps
#
# Copyright (C) 2011,2012 Frank Sundermeyer <fsundermeyer@opensuse.org>
#
# Author:
# Frank Sundermeyer <fsundermeyer@opensuse.org>
#
# TODO: aspell location
# Stylesheets for building xhtml need to be packaged in src tar
# Replace PHONY manuals:

# Manuals



pkgdatadir = $(datadir)/daps
pkgincludedir = $(includedir)/daps
pkglibdir = $(libdir)/daps
pkglibexecdir = $(libexecdir)/daps
am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
install_sh_DATA = $(install_sh) -c -m 644
install_sh_PROGRAM = $(install_sh) -c
install_sh_SCRIPT = $(install_sh) -c
INSTALL_HEADER = $(INSTALL_DATA)
transform = $(program_transform_name)
NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
subdir = .
DIST_COMMON = INSTALL NEWS README AUTHORS ChangeLog \
	$(srcdir)/Makefile.in $(srcdir)/Makefile.am \
	$(top_srcdir)/configure $(am__configure_deps) \
	$(top_srcdir)/etc/config.in $(top_srcdir)/bin/daps.in \
	$(dist_bin_SCRIPTS) $(dist_dapslibexec_SCRIPTS) \
	$(dist_aspell_DATA) $(dist_dapsconf_DATA) $(dist_dapslib_DATA) \
	$(dist_dapsmake_DATA) $(dist_doc_DATA) $(dist_emacssite_DATA) \
	$(dist_fopconf_DATA) $(dist_hyphen_DATA) $(dist_template_DATA) \
	$(dist_ttfonts_DATA) $(dist_xepconf_DATA)
ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
am__aclocal_m4_deps = $(top_srcdir)/m4/ax_python_module.m4 \
	$(top_srcdir)/configure.ac
am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
	$(ACLOCAL_M4)
am__CONFIG_DISTCLEAN_FILES = config.status config.cache config.log \
 configure.lineno config.status.lineno
mkinstalldirs = $(install_sh) -d
CONFIG_CLEAN_FILES = etc/config bin/daps
CONFIG_CLEAN_VPATH_FILES =
am__vpath_adj_setup = srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`;
am__vpath_adj = case $$p in \
    $(srcdir)/*) f=`echo "$$p" | sed "s|^$$srcdirstrip/||"`;; \
    *) f=$$p;; \
  esac;
am__strip_dir = f=`echo $$p | sed -e 's|^.*/||'`;
am__install_max = 40
am__nobase_strip_setup = \
  srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*|]/\\\\&/g'`
am__nobase_strip = \
  for p in $$list; do echo "$$p"; done | sed -e "s|$$srcdirstrip/||"
am__nobase_list = $(am__nobase_strip_setup); \
  for p in $$list; do echo "$$p $$p"; done | \
  sed "s| $$srcdirstrip/| |;"' / .*\//!s/ .*/ ./; s,\( .*\)/[^/]*$$,\1,' | \
  $(AWK) 'BEGIN { files["."] = "" } { files[$$2] = files[$$2] " " $$1; \
    if (++n[$$2] == $(am__install_max)) \
      { print $$2, files[$$2]; n[$$2] = 0; files[$$2] = "" } } \
    END { for (dir in files) print dir, files[dir] }'
am__base_list = \
  sed '$$!N;$$!N;$$!N;$$!N;$$!N;$$!N;$$!N;s/\n/ /g' | \
  sed '$$!N;$$!N;$$!N;$$!N;s/\n/ /g'
am__installdirs = "$(DESTDIR)$(bindir)" "$(DESTDIR)$(dapslibexecdir)" \
	"$(DESTDIR)$(aspelldir)" "$(DESTDIR)$(dapsconfdir)" \
	"$(DESTDIR)$(dapslibdir)" "$(DESTDIR)$(dapsmakedir)" \
	"$(DESTDIR)$(docdir)" "$(DESTDIR)$(emacssitedir)" \
	"$(DESTDIR)$(fopconfdir)" "$(DESTDIR)$(hyphendir)" \
	"$(DESTDIR)$(templatedir)" "$(DESTDIR)$(ttfontsdir)" \
	"$(DESTDIR)$(xepconfdir)"
SCRIPTS = $(dist_bin_SCRIPTS) $(dist_dapslibexec_SCRIPTS)
SOURCES =
RECURSIVE_TARGETS = all-recursive check-recursive dvi-recursive \
	html-recursive info-recursive install-data-recursive \
	install-dvi-recursive install-exec-recursive \
	install-html-recursive install-info-recursive \
	install-pdf-recursive install-ps-recursive install-recursive \
	installcheck-recursive installdirs-recursive pdf-recursive \
	ps-recursive uninstall-recursive
DATA = $(dist_aspell_DATA) $(dist_dapsconf_DATA) $(dist_dapslib_DATA) \
	$(dist_dapsmake_DATA) $(dist_doc_DATA) $(dist_emacssite_DATA) \
	$(dist_fopconf_DATA) $(dist_hyphen_DATA) $(dist_template_DATA) \
	$(dist_ttfonts_DATA) $(dist_xepconf_DATA)
RECURSIVE_CLEAN_TARGETS = mostlyclean-recursive clean-recursive	\
  distclean-recursive maintainer-clean-recursive
AM_RECURSIVE_TARGETS = $(RECURSIVE_TARGETS:-recursive=) \
	$(RECURSIVE_CLEAN_TARGETS:-recursive=) tags TAGS ctags CTAGS
ETAGS = etags
CTAGS = ctags
DIST_SUBDIRS = $(SUBDIRS)
ACLOCAL = ${SHELL} /local_data/svns/daps/trunk/daps/missing --run aclocal-1.11
AMTAR = ${SHELL} /local_data/svns/daps/trunk/daps/missing --run tar
AUTOCONF = ${SHELL} /local_data/svns/daps/trunk/daps/missing --run autoconf
AUTOHEADER = ${SHELL} /local_data/svns/daps/trunk/daps/missing --run autoheader
AUTOMAKE = ${SHELL} /local_data/svns/daps/trunk/daps/missing --run automake-1.11
AWK = gawk
BZIP = /usr/bin/bzip2
CHECKBOT = /usr/bin/checkbot
CONVERT = /usr/bin/convert
CYGPATH_W = echo
DEBUG = 
DEFS = -DPACKAGE_NAME=\"DAPS\" -DPACKAGE_TARNAME=\"daps\" -DPACKAGE_VERSION=\"0.9.9\" -DPACKAGE_STRING=\"DAPS\ 0.9.9\" -DPACKAGE_BUGREPORT=\"https://sourceforge.net/p/daps/tickets/\" -DPACKAGE_URL=\"http://daps.sf.net\" -DPACKAGE=\"daps\" -DVERSION=\"0.9.9\"
DIA = /usr/bin/dia
ECHO_C = 
ECHO_N = -n
ECHO_T = 
EPUBCHECK = /usr/bin/epubcheck
EXIFTOOL = /usr/bin/exiftool
FOP = /usr/bin/fop
GHOSTSCRIPT = /usr/bin/gs
GREP = /usr/bin/grep
HAVE_PYMOD_XML = yes
INKSCAPE = /usr/bin/inkscape
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_STRIP_PROGRAM = $(install_sh) -c -s
JING = /usr/bin/jing
LIBOBJS = 
LIBS = 
LN_S = ln -s
LTLIBOBJS = 
MAKE = /usr/bin/make
MAKEINFO = ${SHELL} /local_data/svns/daps/trunk/daps/missing --run makeinfo
MKDIR_P = /bin/mkdir -p
OPTIPNG = /usr/bin/optipng
PACKAGE = daps
PACKAGE_BUGREPORT = https://sourceforge.net/p/daps/tickets/
PACKAGE_NAME = DAPS
PACKAGE_STRING = DAPS 0.9.9
PACKAGE_TARNAME = daps
PACKAGE_URL = http://daps.sf.net
PACKAGE_VERSION = 0.9.9
PATH_SEPARATOR = :
PDFFONTS = /usr/bin/pdffonts
PYTHON = /usr/bin/python
PYTHON_EXEC_PREFIX = ${exec_prefix}
PYTHON_PLATFORM = linux2
PYTHON_PREFIX = ${prefix}
PYTHON_VERSION = 2.7
Q = @
REMAKE = /usr/bin/remake
ROOT_CATALOG = /etc/xml/catalog
RUBY = /usr/bin/ruby
SED = /usr/bin/sed
SET_MAKE = 
SHELL = /bin/sh
STRIP = 
TAR = /bin/tar
VENDOR = SUSE
VERSION = 0.9.9
W3M = /usr/bin/w3m
XEP = /usr/bin/xep
XFIG = /usr/bin/xfig
XMLCATALOG = /usr/bin/xmlcatalog
XMLLINT = /usr/bin/xmllint
XSLTPROC = /usr/bin/xsltproc
abs_builddir = /local_data/svns/daps/trunk/daps
abs_srcdir = /local_data/svns/daps/trunk/daps
abs_top_builddir = /local_data/svns/daps/trunk/daps
abs_top_srcdir = /local_data/svns/daps/trunk/daps
am__leading_dot = .
am__tar = ${AMTAR} chof - "$$tardir"
am__untar = ${AMTAR} xf -
bindir = ${exec_prefix}/bin
build_alias = 
builddir = .
datadir = ${datarootdir}
datarootdir = ${prefix}/share
docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}
dvidir = ${docdir}
exec_prefix = ${prefix}
host_alias = 
htmldir = ${docdir}
includedir = ${prefix}/include
infodir = ${datarootdir}/info
install_sh = ${SHELL} /local_data/svns/daps/trunk/daps/install-sh
libdir = ${exec_prefix}/lib
libexecdir = ${exec_prefix}/libexec
localedir = ${datarootdir}/locale
localstatedir = ${prefix}/var
mandir = ${datarootdir}/man
mkdir_p = /bin/mkdir -p
oldincludedir = /usr/include
pdfdir = ${docdir}
pkgpyexecdir = ${pyexecdir}/daps
pkgpythondir = ${pythondir}/daps
prefix = /usr
program_transform_name = s,x,x,
psdir = ${docdir}
pyexecdir = ${exec_prefix}/lib64/python2.7/site-packages
pythondir = ${prefix}/lib/python2.7/site-packages
sbindir = ${exec_prefix}/sbin
sharedstatedir = ${prefix}/com
srcdir = .
sysconfdir = ${prefix}/etc
target_alias = 
top_build_prefix = 
top_builddir = .
top_srcdir = .

#------------------------
AUTOMAKE_OPTIONS = 1.10 foreign no-define no-dist no-installinfo \
			-Wall -Werror -Wno-portability

SUBDIRS = 

#------------------------
DAPS_CATALOG := catalogs/for-catalog-$(PACKAGE).xml
DAPSROOT := $(abs_top_srcdir)

# stylesheets with which to build the documentation
STYLEROOT := $(DAPSROOT)/suse-xslt

# Man pages
DC_MANPAGES := DC-daps-manpages
MAN_PAGE_DIR := $(subst DC-,,$(DC_MANPAGES))
MAN_PAGES := daps.1 ccecho.1
MAN_BUILD_PATH := $(srcdir)/man/build/$(MAN_PAGE_DIR)/man/

# Manuals
DC_USERGUIDE = $(srcdir)/doc/DC-daps-user
DC_QUICKSTART = $(srcdir)/doc/DC-daps-quick
USERGUIDE_NAME = daps-user
QUICKSTART_NAME = daps-quick
USERGUIDE = $(srcdir)/doc/build/$(USERGUIDE_NAME)/html/$(USERGUIDE_NAME)/$(USERGUIDE_NAME).html
QUICKSTART = $(srcdir)/doc/build/$(QUICKSTART_NAME)/html/$(QUICKSTART_NAME)/$(QUICKSTART_NAME).html
MANUALS = $(dir $(USERGUIDE)) $(dir $(QUICKSTART)) 

#------------------------
# Installation hooks
#
dapsconfdir = ${prefix}/etc/daps
fopconfdir = $(dapsconfdir)/fop
xepconfdir = $(dapsconfdir)/xep
hyphendir = $(xepconfdir)/hyphen
aspelldir = ${datarootdir}/aspell
dapslibdir = $(pkgdatadir)/lib
dapslibexecdir = $(pkgdatadir)/libexec
dapsmakedir = $(pkgdatadir)/make
emacssitedir = ${datarootdir}/emacs/site-lisp
templatedir = $(pkgdatadir)/init_templates
ttfontsdir = ${datarootdir}/fonts/truetype
htmldocdir = ${datarootdir}/doc/${PACKAGE_TARNAME}/html

#------------------------
# Automake primaries

# BIN
dist_bin_SCRIPTS = $(srcdir)/$(wildcard bin/*)
dist_dapslibexec_SCRIPTS = $(srcdir)/$(wildcard libexec/*)

# CONFIG files
dist_dapsconf_DATA = $(srcdir)/etc/config
dist_fopconf_DATA = $(srcdir)/etc/fop/fop-daps.xml
dist_xepconf_DATA = $(srcdir)/etc/xep/xep-daps.xml
dist_hyphen_DATA = $(wildcard $(srcdir)/etc/xep/hyphen/*.tex) \
			$(wildcard $(srcdir)/etc/xep/hyphen/*.il2)


# DATA
dist_aspell_DATA = $(srcdir)/misc/suse_aspell.rws
dist_dapslib_DATA = $(wildcard $(srcdir)/lib/*)
dist_emacssite_DATA = $(srcdir)/misc/docbook_macros.el
dist_dapsmake_DATA = $(wildcard $(srcdir)/make/*.mk)
dist_template_DATA = $(wildcard $(srcdir)/init_templates/*)
dist_ttfonts_DATA = $(wildcard $(srcdir)/fonts/*.ttf)

# DOCUMENTATION
dist_doc_DATA = $(addprefix, $(srcdir)/, BUGS COPYING COPYING-2.0 \
			COPYING-3.0 INSTALL README README.quickstart \
			README.upgrade_from_susedoc_4.x)

man_MANS = $(addprefix $(MAN_BUILD_PATH), $(MAN_PAGES))

#---------------------------Local INSTALLATION--------------------------------
INSTALLDIRS = $(DESTDIR)$(docdir)/html $(DESTDIR)$(pkgdatadir)
all: all-recursive

.SUFFIXES:
am--refresh:
	@:
$(srcdir)/Makefile.in:  $(srcdir)/Makefile.am  $(am__configure_deps)
	@for dep in $?; do \
	  case '$(am__configure_deps)' in \
	    *$$dep*) \
	      echo ' cd $(srcdir) && $(AUTOMAKE) --foreign'; \
	      $(am__cd) $(srcdir) && $(AUTOMAKE) --foreign \
		&& exit 0; \
	      exit 1;; \
	  esac; \
	done; \
	echo ' cd $(top_srcdir) && $(AUTOMAKE) --foreign Makefile'; \
	$(am__cd) $(top_srcdir) && \
	  $(AUTOMAKE) --foreign Makefile
.PRECIOUS: Makefile
Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	@case '$?' in \
	  *config.status*) \
	    echo ' $(SHELL) ./config.status'; \
	    $(SHELL) ./config.status;; \
	  *) \
	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe)'; \
	    cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe);; \
	esac;

$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
	$(SHELL) ./config.status --recheck

$(top_srcdir)/configure:  $(am__configure_deps)
	$(am__cd) $(srcdir) && $(AUTOCONF)
$(ACLOCAL_M4):  $(am__aclocal_m4_deps)
	$(am__cd) $(srcdir) && $(ACLOCAL) $(ACLOCAL_AMFLAGS)
$(am__aclocal_m4_deps):
etc/config: $(top_builddir)/config.status $(top_srcdir)/etc/config.in
	cd $(top_builddir) && $(SHELL) ./config.status $@
bin/daps: $(top_builddir)/config.status $(top_srcdir)/bin/daps.in
	cd $(top_builddir) && $(SHELL) ./config.status $@
install-dist_binSCRIPTS: $(dist_bin_SCRIPTS)
	@$(NORMAL_INSTALL)
	test -z "$(bindir)" || $(MKDIR_P) "$(DESTDIR)$(bindir)"
	@list='$(dist_bin_SCRIPTS)'; test -n "$(bindir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  if test -f "$$d$$p"; then echo "$$d$$p"; echo "$$p"; else :; fi; \
	done | \
	sed -e 'p;s,.*/,,;n' \
	    -e 'h;s|.*|.|' \
	    -e 'p;x;s,.*/,,;$(transform)' | sed 'N;N;N;s,\n, ,g' | \
	$(AWK) 'BEGIN { files["."] = ""; dirs["."] = 1; } \
	  { d=$$3; if (dirs[d] != 1) { print "d", d; dirs[d] = 1 } \
	    if ($$2 == $$4) { files[d] = files[d] " " $$1; \
	      if (++n[d] == $(am__install_max)) { \
		print "f", d, files[d]; n[d] = 0; files[d] = "" } } \
	    else { print "f", d "/" $$4, $$1 } } \
	  END { for (d in files) print "f", d, files[d] }' | \
	while read type dir files; do \
	     if test "$$dir" = .; then dir=; else dir=/$$dir; fi; \
	     test -z "$$files" || { \
	       echo " $(INSTALL_SCRIPT) $$files '$(DESTDIR)$(bindir)$$dir'"; \
	       $(INSTALL_SCRIPT) $$files "$(DESTDIR)$(bindir)$$dir" || exit $$?; \
	     } \
	; done

uninstall-dist_binSCRIPTS:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_bin_SCRIPTS)'; test -n "$(bindir)" || exit 0; \
	files=`for p in $$list; do echo "$$p"; done | \
	       sed -e 's,.*/,,;$(transform)'`; \
	test -n "$$list" || exit 0; \
	echo " ( cd '$(DESTDIR)$(bindir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(bindir)" && rm -f $$files
install-dist_dapslibexecSCRIPTS: $(dist_dapslibexec_SCRIPTS)
	@$(NORMAL_INSTALL)
	test -z "$(dapslibexecdir)" || $(MKDIR_P) "$(DESTDIR)$(dapslibexecdir)"
	@list='$(dist_dapslibexec_SCRIPTS)'; test -n "$(dapslibexecdir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  if test -f "$$d$$p"; then echo "$$d$$p"; echo "$$p"; else :; fi; \
	done | \
	sed -e 'p;s,.*/,,;n' \
	    -e 'h;s|.*|.|' \
	    -e 'p;x;s,.*/,,;$(transform)' | sed 'N;N;N;s,\n, ,g' | \
	$(AWK) 'BEGIN { files["."] = ""; dirs["."] = 1; } \
	  { d=$$3; if (dirs[d] != 1) { print "d", d; dirs[d] = 1 } \
	    if ($$2 == $$4) { files[d] = files[d] " " $$1; \
	      if (++n[d] == $(am__install_max)) { \
		print "f", d, files[d]; n[d] = 0; files[d] = "" } } \
	    else { print "f", d "/" $$4, $$1 } } \
	  END { for (d in files) print "f", d, files[d] }' | \
	while read type dir files; do \
	     if test "$$dir" = .; then dir=; else dir=/$$dir; fi; \
	     test -z "$$files" || { \
	       echo " $(INSTALL_SCRIPT) $$files '$(DESTDIR)$(dapslibexecdir)$$dir'"; \
	       $(INSTALL_SCRIPT) $$files "$(DESTDIR)$(dapslibexecdir)$$dir" || exit $$?; \
	     } \
	; done

uninstall-dist_dapslibexecSCRIPTS:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_dapslibexec_SCRIPTS)'; test -n "$(dapslibexecdir)" || exit 0; \
	files=`for p in $$list; do echo "$$p"; done | \
	       sed -e 's,.*/,,;$(transform)'`; \
	test -n "$$list" || exit 0; \
	echo " ( cd '$(DESTDIR)$(dapslibexecdir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(dapslibexecdir)" && rm -f $$files
install-dist_aspellDATA: $(dist_aspell_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(aspelldir)" || $(MKDIR_P) "$(DESTDIR)$(aspelldir)"
	@list='$(dist_aspell_DATA)'; test -n "$(aspelldir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(aspelldir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(aspelldir)" || exit $$?; \
	done

uninstall-dist_aspellDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_aspell_DATA)'; test -n "$(aspelldir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(aspelldir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(aspelldir)" && rm -f $$files
install-dist_dapsconfDATA: $(dist_dapsconf_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(dapsconfdir)" || $(MKDIR_P) "$(DESTDIR)$(dapsconfdir)"
	@list='$(dist_dapsconf_DATA)'; test -n "$(dapsconfdir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(dapsconfdir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(dapsconfdir)" || exit $$?; \
	done

uninstall-dist_dapsconfDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_dapsconf_DATA)'; test -n "$(dapsconfdir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(dapsconfdir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(dapsconfdir)" && rm -f $$files
install-dist_dapslibDATA: $(dist_dapslib_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(dapslibdir)" || $(MKDIR_P) "$(DESTDIR)$(dapslibdir)"
	@list='$(dist_dapslib_DATA)'; test -n "$(dapslibdir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(dapslibdir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(dapslibdir)" || exit $$?; \
	done

uninstall-dist_dapslibDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_dapslib_DATA)'; test -n "$(dapslibdir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(dapslibdir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(dapslibdir)" && rm -f $$files
install-dist_dapsmakeDATA: $(dist_dapsmake_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(dapsmakedir)" || $(MKDIR_P) "$(DESTDIR)$(dapsmakedir)"
	@list='$(dist_dapsmake_DATA)'; test -n "$(dapsmakedir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(dapsmakedir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(dapsmakedir)" || exit $$?; \
	done

uninstall-dist_dapsmakeDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_dapsmake_DATA)'; test -n "$(dapsmakedir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(dapsmakedir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(dapsmakedir)" && rm -f $$files
install-dist_docDATA: $(dist_doc_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(docdir)" || $(MKDIR_P) "$(DESTDIR)$(docdir)"
	@list='$(dist_doc_DATA)'; test -n "$(docdir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(docdir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(docdir)" || exit $$?; \
	done

uninstall-dist_docDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_doc_DATA)'; test -n "$(docdir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(docdir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(docdir)" && rm -f $$files
install-dist_emacssiteDATA: $(dist_emacssite_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(emacssitedir)" || $(MKDIR_P) "$(DESTDIR)$(emacssitedir)"
	@list='$(dist_emacssite_DATA)'; test -n "$(emacssitedir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(emacssitedir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(emacssitedir)" || exit $$?; \
	done

uninstall-dist_emacssiteDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_emacssite_DATA)'; test -n "$(emacssitedir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(emacssitedir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(emacssitedir)" && rm -f $$files
install-dist_fopconfDATA: $(dist_fopconf_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(fopconfdir)" || $(MKDIR_P) "$(DESTDIR)$(fopconfdir)"
	@list='$(dist_fopconf_DATA)'; test -n "$(fopconfdir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(fopconfdir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(fopconfdir)" || exit $$?; \
	done

uninstall-dist_fopconfDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_fopconf_DATA)'; test -n "$(fopconfdir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(fopconfdir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(fopconfdir)" && rm -f $$files
install-dist_hyphenDATA: $(dist_hyphen_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(hyphendir)" || $(MKDIR_P) "$(DESTDIR)$(hyphendir)"
	@list='$(dist_hyphen_DATA)'; test -n "$(hyphendir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(hyphendir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(hyphendir)" || exit $$?; \
	done

uninstall-dist_hyphenDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_hyphen_DATA)'; test -n "$(hyphendir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(hyphendir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(hyphendir)" && rm -f $$files
install-dist_templateDATA: $(dist_template_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(templatedir)" || $(MKDIR_P) "$(DESTDIR)$(templatedir)"
	@list='$(dist_template_DATA)'; test -n "$(templatedir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(templatedir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(templatedir)" || exit $$?; \
	done

uninstall-dist_templateDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_template_DATA)'; test -n "$(templatedir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(templatedir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(templatedir)" && rm -f $$files
install-dist_ttfontsDATA: $(dist_ttfonts_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(ttfontsdir)" || $(MKDIR_P) "$(DESTDIR)$(ttfontsdir)"
	@list='$(dist_ttfonts_DATA)'; test -n "$(ttfontsdir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(ttfontsdir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(ttfontsdir)" || exit $$?; \
	done

uninstall-dist_ttfontsDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_ttfonts_DATA)'; test -n "$(ttfontsdir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(ttfontsdir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(ttfontsdir)" && rm -f $$files
install-dist_xepconfDATA: $(dist_xepconf_DATA)
	@$(NORMAL_INSTALL)
	test -z "$(xepconfdir)" || $(MKDIR_P) "$(DESTDIR)$(xepconfdir)"
	@list='$(dist_xepconf_DATA)'; test -n "$(xepconfdir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  echo "$$d$$p"; \
	done | $(am__base_list) | \
	while read files; do \
	  echo " $(INSTALL_DATA) $$files '$(DESTDIR)$(xepconfdir)'"; \
	  $(INSTALL_DATA) $$files "$(DESTDIR)$(xepconfdir)" || exit $$?; \
	done

uninstall-dist_xepconfDATA:
	@$(NORMAL_UNINSTALL)
	@list='$(dist_xepconf_DATA)'; test -n "$(xepconfdir)" || list=; \
	files=`for p in $$list; do echo $$p; done | sed -e 's|^.*/||'`; \
	test -n "$$files" || exit 0; \
	echo " ( cd '$(DESTDIR)$(xepconfdir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(xepconfdir)" && rm -f $$files

# This directory's subdirectories are mostly independent; you can cd
# into them and run `make' without going through this Makefile.
# To change the values of `make' variables: instead of editing Makefiles,
# (1) if the variable is set in `config.status', edit `config.status'
#     (which will cause the Makefiles to be regenerated when you run `make');
# (2) otherwise, pass the desired values on the `make' command line.
$(RECURSIVE_TARGETS):
	@fail= failcom='exit 1'; \
	for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=* | --[!k]*);; \
	    *k*) failcom='fail=yes';; \
	  esac; \
	done; \
	dot_seen=no; \
	target=`echo $@ | sed s/-recursive//`; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  echo "Making $$target in $$subdir"; \
	  if test "$$subdir" = "."; then \
	    dot_seen=yes; \
	    local_target="$$target-am"; \
	  else \
	    local_target="$$target"; \
	  fi; \
	  ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) $$local_target) \
	  || eval $$failcom; \
	done; \
	if test "$$dot_seen" = "no"; then \
	  $(MAKE) $(AM_MAKEFLAGS) "$$target-am" || exit 1; \
	fi; test -z "$$fail"

$(RECURSIVE_CLEAN_TARGETS):
	@fail= failcom='exit 1'; \
	for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=* | --[!k]*);; \
	    *k*) failcom='fail=yes';; \
	  esac; \
	done; \
	dot_seen=no; \
	case "$@" in \
	  distclean-* | maintainer-clean-*) list='$(DIST_SUBDIRS)' ;; \
	  *) list='$(SUBDIRS)' ;; \
	esac; \
	rev=''; for subdir in $$list; do \
	  if test "$$subdir" = "."; then :; else \
	    rev="$$subdir $$rev"; \
	  fi; \
	done; \
	rev="$$rev ."; \
	target=`echo $@ | sed s/-recursive//`; \
	for subdir in $$rev; do \
	  echo "Making $$target in $$subdir"; \
	  if test "$$subdir" = "."; then \
	    local_target="$$target-am"; \
	  else \
	    local_target="$$target"; \
	  fi; \
	  ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) $$local_target) \
	  || eval $$failcom; \
	done && test -z "$$fail"
tags-recursive:
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  test "$$subdir" = . || ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) tags); \
	done
ctags-recursive:
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  test "$$subdir" = . || ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) ctags); \
	done

ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	mkid -fID $$unique
tags: TAGS

TAGS: tags-recursive $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
		$(TAGS_FILES) $(LISP)
	set x; \
	here=`pwd`; \
	if ($(ETAGS) --etags-include --version) >/dev/null 2>&1; then \
	  include_option=--etags-include; \
	  empty_fix=.; \
	else \
	  include_option=--include; \
	  empty_fix=; \
	fi; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  if test "$$subdir" = .; then :; else \
	    test ! -f $$subdir/TAGS || \
	      set "$$@" "$$include_option=$$here/$$subdir/TAGS"; \
	  fi; \
	done; \
	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	shift; \
	if test -z "$(ETAGS_ARGS)$$*$$unique"; then :; else \
	  test -n "$$unique" || unique=$$empty_fix; \
	  if test $$# -gt 0; then \
	    $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
	      "$$@" $$unique; \
	  else \
	    $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
	      $$unique; \
	  fi; \
	fi
ctags: CTAGS
CTAGS: ctags-recursive $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
		$(TAGS_FILES) $(LISP)
	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	test -z "$(CTAGS_ARGS)$$unique" \
	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
	     $$unique

GTAGS:
	here=`$(am__cd) $(top_builddir) && pwd` \
	  && $(am__cd) $(top_srcdir) \
	  && gtags -i $(GTAGS_ARGS) "$$here"

distclean-tags:
	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
check-am: all-am
check: check-recursive
all-am: Makefile $(SCRIPTS) $(DATA) all-local
installdirs: installdirs-recursive
installdirs-am:
	for dir in "$(DESTDIR)$(bindir)" "$(DESTDIR)$(dapslibexecdir)" "$(DESTDIR)$(aspelldir)" "$(DESTDIR)$(dapsconfdir)" "$(DESTDIR)$(dapslibdir)" "$(DESTDIR)$(dapsmakedir)" "$(DESTDIR)$(docdir)" "$(DESTDIR)$(emacssitedir)" "$(DESTDIR)$(fopconfdir)" "$(DESTDIR)$(hyphendir)" "$(DESTDIR)$(templatedir)" "$(DESTDIR)$(ttfontsdir)" "$(DESTDIR)$(xepconfdir)"; do \
	  test -z "$$dir" || $(MKDIR_P) "$$dir"; \
	done
install: install-recursive
install-exec: install-exec-recursive
install-data: install-data-recursive
uninstall: uninstall-recursive

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am

installcheck: installcheck-recursive
install-strip:
	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
	  `test -z '$(STRIP)' || \
	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
mostlyclean-generic:

clean-generic:

distclean-generic:
	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
	-test . = "$(srcdir)" || test -z "$(CONFIG_CLEAN_VPATH_FILES)" || rm -f $(CONFIG_CLEAN_VPATH_FILES)

maintainer-clean-generic:
	@echo "This command is intended for maintainers to use"
	@echo "it deletes files that may require special tools to rebuild."
clean: clean-recursive

clean-am: clean-generic clean-local mostlyclean-am

distclean: distclean-recursive
	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
	-rm -f Makefile
distclean-am: clean-am distclean-generic distclean-tags

dvi: dvi-recursive

dvi-am:

html: html-recursive

html-am:

info: info-recursive

info-am:

install-data-am: install-data-local install-dist_aspellDATA \
	install-dist_dapsconfDATA install-dist_dapslibDATA \
	install-dist_dapsmakeDATA install-dist_docDATA \
	install-dist_emacssiteDATA install-dist_fopconfDATA \
	install-dist_hyphenDATA install-dist_templateDATA \
	install-dist_ttfontsDATA install-dist_xepconfDATA

install-dvi: install-dvi-recursive

install-dvi-am:

install-exec-am: install-dist_binSCRIPTS \
	install-dist_dapslibexecSCRIPTS

install-html: install-html-recursive

install-html-am:

install-info: install-info-recursive

install-info-am:

install-man:

install-pdf: install-pdf-recursive

install-pdf-am:

install-ps: install-ps-recursive

install-ps-am:

installcheck-am:

maintainer-clean: maintainer-clean-recursive
	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
	-rm -rf $(top_srcdir)/autom4te.cache
	-rm -f Makefile
maintainer-clean-am: distclean-am maintainer-clean-generic

mostlyclean: mostlyclean-recursive

mostlyclean-am: mostlyclean-generic

pdf: pdf-recursive

pdf-am:

ps: ps-recursive

ps-am:

uninstall-am: uninstall-dist_aspellDATA uninstall-dist_binSCRIPTS \
	uninstall-dist_dapsconfDATA uninstall-dist_dapslibDATA \
	uninstall-dist_dapslibexecSCRIPTS uninstall-dist_dapsmakeDATA \
	uninstall-dist_docDATA uninstall-dist_emacssiteDATA \
	uninstall-dist_fopconfDATA uninstall-dist_hyphenDATA \
	uninstall-dist_templateDATA uninstall-dist_ttfontsDATA \
	uninstall-dist_xepconfDATA uninstall-local

.MAKE: $(RECURSIVE_CLEAN_TARGETS) $(RECURSIVE_TARGETS) ctags-recursive \
	install-am install-strip tags-recursive

.PHONY: $(RECURSIVE_CLEAN_TARGETS) $(RECURSIVE_TARGETS) CTAGS GTAGS \
	all all-am all-local am--refresh check check-am clean \
	clean-generic clean-local ctags ctags-recursive distclean \
	distclean-generic distclean-tags dvi dvi-am html html-am info \
	info-am install install-am install-data install-data-am \
	install-data-local install-dist_aspellDATA \
	install-dist_binSCRIPTS install-dist_dapsconfDATA \
	install-dist_dapslibDATA install-dist_dapslibexecSCRIPTS \
	install-dist_dapsmakeDATA install-dist_docDATA \
	install-dist_emacssiteDATA install-dist_fopconfDATA \
	install-dist_hyphenDATA install-dist_templateDATA \
	install-dist_ttfontsDATA install-dist_xepconfDATA install-dvi \
	install-dvi-am install-exec install-exec-am install-html \
	install-html-am install-info install-info-am install-man \
	install-pdf install-pdf-am install-ps install-ps-am \
	install-strip installcheck installcheck-am installdirs \
	installdirs-am maintainer-clean maintainer-clean-generic \
	mostlyclean mostlyclean-generic pdf pdf-am ps ps-am tags \
	tags-recursive uninstall uninstall-am \
	uninstall-dist_aspellDATA uninstall-dist_binSCRIPTS \
	uninstall-dist_dapsconfDATA uninstall-dist_dapslibDATA \
	uninstall-dist_dapslibexecSCRIPTS uninstall-dist_dapsmakeDATA \
	uninstall-dist_docDATA uninstall-dist_emacssiteDATA \
	uninstall-dist_fopconfDATA uninstall-dist_hyphenDATA \
	uninstall-dist_templateDATA uninstall-dist_ttfontsDATA \
	uninstall-dist_xepconfDATA uninstall-local


#---------------------------Local TARGETS--------------------------------------
all-local: $(USERGUIDE) $(QUICKSTART) $(man_MANS) $(DAPS_CATALOG)

$(INSTALLDIRS):
	test -z "$@" || $(MKDIR_P) $@

install-data-local: $(INSTALLDIRS)
install-data-local: TMP_CATALOG := $(shell mktemp -q catalog.XXXXX)
install-data-local:
	for BOOK in $(MANUALS); do \
	  cp -a $$BOOK/* $(DESTDIR)$(docdir)/html; \
	done
	cp -a $(srcdir)/daps-xslt/ $(DESTDIR)$(pkgdatadir)
	find {$(DESTDIR)$(docdir)/html,$(DESTDIR)$(pkgdatadir)/daps-xslt} \
		-type d -exec chmod -R u=rwx,go=rx,a-s {} \;; \
	find {$(DESTDIR)$(docdir)/html,$(DESTDIR)$(pkgdatadir)/daps-xslt} \
		-type f -exec chmod -R u=rw,go=r,a-s {} \;;
# create entry in xml root catalog
	{ \
	  sed '/<\/catalog>/d' $(ROOT_CATALOG); \
	  $(XMLLINT) --nocatalogs --format $(DAPS_CATALOG) | \
	    awk '/<\/catalog>/{next} s == 1 {print} /<catalog/{s=1} \
	      END{print "</catalog>"}'; \
	} >$(TMP_CATALOG)
	chmod --reference=$(ROOT_CATALOG) $(TMP_CATALOG)
	$(XMLLINT) --nocatalogs --noout $(TMP_CATALOG) && \
	  mv $(TMP_CATALOG) $(ROOT_CATALOG)

#---------------------------Local UNINSTALL-----------------------------------
uninstall-local: TMP_CATALOG := $(shell mktemp -q catalog.XXXXX)
uninstall-local:
	$(XMLLINT) --nocatalogs --format $(ROOT_CATALOG) | \
	  awk "/<\/group>/ && s == 1 {s=0;next} s == 1 {next} /<group id="$(PACKAGE)">/{s=1;next} {print}" > $(TMP_CATALOG)
	chmod --reference=$(ROOT_CATALOG) $(TMP_CATALOG)
	$(XMLLINT) --nocatalogs --noout $(TMP_CATALOG) && \
	  mv $(TMP_CATALOG) $(ROOT_CATALOG)

#-----------------------------CLEAN--------------------------------------------
clean-local:
	rm -rf $(srcdir)/man/build/ $(srcdir)/doc/build/ $(dir $(DAPS_CATALOG)) 

#-----------------------------DAPS--------------------------------------------

# create temporary DAPS catalog entries file
$(DAPS_CATALOG): DAPS_PROFDIR := $(pkgdatadir)/daps-xslt/profiling
$(DAPS_CATALOG): URN_SUSE     := urn:x-suse:xslt:profiling
$(DAPS_CATALOG): URN_DAPS     := urn:x-daps:xslt:profiling
$(DAPS_CATALOG): DB_VERSIONS  := 41 42 43 44 45 50 51
$(DAPS_CATALOG):
	$(Q)test -z "$(dir $@)" || $(MKDIR_P) $(dir $@)
	$(Q)$(XMLCATALOG) --noout --create $@
	$(Q)for VERS in $(DB_VERSIONS); do \
	  $(XMLCATALOG) --noout --add \
	  "system" "$(URN_DAPS):docbook$${VERS}-profile.xsl" \
	  "file://$(DAPS_PROFDIR)/docbook$${VERS}-profile.xsl" $@; \
	  $(XMLCATALOG) --noout --add \
	  "system" "$(URN_SUSE):docbook$${VERS}-profile.xsl" \
	  "file://$(DAPS_PROFDIR)/docbook$${VERS}-profile.xsl" $@; \
	done
	$(Q)$(XMLCATALOG) --noout --add \
	  "system" "$(URN_DAPS):novdoc-profile.xsl" \
	  "file://$(DAPS_PROFDIR)/novdoc-profile.xsl" $@
	$(Q)$(XMLCATALOG) --noout --add \
	  "system" "$(URN_SUSE):novdoc-profile.xsl" \
	  "file://$(DAPS_PROFDIR)/novdoc-profile.xsl" $@
	$(Q)$(SED) -i '/^<!DOCTYPE .*>$$/d' $@
	$(Q)$(SED) -i '/<catalog/a\ <group id="$(PACKAGE)">' $@
	$(Q)$(SED) -i '/<\/catalog/i\ </group>' $@
	$(Q)$(srcdir)/bin/ccecho "result" "Created $@"

$(USERGUIDE):
	$(Q)$(srcdir)/bin/daps $(DEBUG) --dapsroot=$(DAPSROOT) \
	    --docconfig=$(DC_USERGUIDE) \
	    --styleroot=$(STYLEROOT) html-single --static \
	    --css=$(STYLEROOT)/xhtml/susebooks.css --name=$(USERGUIDE_NAME)
	$(Q)$(srcdir)/bin/ccecho "result" "Created $@"

$(QUICKSTART):
	$(Q)$(srcdir)/bin/daps $(DEBUG) --dapsroot=$(DAPSROOT) \
	    --docconfig=$(DC_QUICKSTART) \
	    --styleroot=$(STYLEROOT) html-single --static \
	    --css=$(STYLEROOT)/xhtml/susebooks.css --name=$(QUICKSTART_NAME)
	$(Q)$(srcdir)/bin/ccecho "result" "Created $@"

# Generate man pages on the fly
$(man_MANS):
	$(Q)$(srcdir)/bin/daps $(DEBUG) --dapsroot=$(DAPSROOT) --color=0 \
	  --docconfig=$(DAPSROOT)/man/$(DC_MANPAGES) man --nogzip
	$(Q)$(srcdir)/bin/ccecho "result" "Created man pages $@"

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
