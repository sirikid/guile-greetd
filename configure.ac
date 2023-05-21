AC_INIT([Guile-Greetd], [0.1.2], [https://github.com/sirikid/guile-greetd/issues], [guile-greetd])

AM_INIT_AUTOMAKE([gnu -Wall -Wno-portability])

GUILE_PKG([3.0 2.2])
GUILE_PROGS
GUILE_SITE_DIR

AC_PROG_SED

AC_CONFIG_SRCDIR([scripts/agreety.in])
AC_CONFIG_FILES([Makefile build-aux/am/Makefile modules/greetd/Makefile scripts/Makefile])

AC_OUTPUT
