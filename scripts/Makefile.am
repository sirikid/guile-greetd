bin_SCRIPTS = agreety

EXTRA_DIST = agreety.in

CLEANFILES = agreety agreety-t

agreety: agreety.in
	@if $(AM_V_P); then set -x; else printf '  %-8s %s\n' GEN agreety; fi; \
	$(SED) -e 's,[@]GUILE[@],$(GUILE),g' $< > $@-t; \
	chmod a+x $@-t; \
	mv $@-t $@
