# Modifications to GnuTLS to build on Android.
# Copyright (C) 2023 Free Software Foundation, Inc.

# These modifications are part of GNU Emacs.

# GNU Emacs is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.

# GNU Emacs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

LOCAL_PATH := $(call my-dir)

# Static libgnu_gnutls module.
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH) $(LOCAL_PATH)/../includes \
  $(LOCAL_PATH)/..

WARN_CFLAGS = -fno-common -Wall -Wbad-function-cast -Wdate-time		\
  -Wdisabled-optimization -Wdouble-promotion -Wextra -Winit-self	\
  -Winvalid-pch -Wmissing-declarations -Wmissing-include-dirs		\
  -Wmissing-prototypes -Wnested-externs -Wnull-dereference		\
  -Wold-style-definition -Wpacked -Wpointer-arith -Wshadow		\
  -Wstrict-prototypes -Wuninitialized -Wunknown-pragmas			\
  -Wvariadic-macros -Wwrite-strings -Wformat=2				\
  -Wno-missing-field-initializers -Wno-unused-parameter			\
  -fdiagnostics-show-option -fno-builtin-strcmp

# Import source files from Makefile.am.
libgnu_la_SOURCES = basename-lgpl.c bitrotate.h bitrotate.c c-ctype.h \
	c-ctype.c c-strcase.h c-strcasecmp.c c-strncasecmp.c cloexec.c \
	dirname-lgpl.c stripslash.c fd-hook.c gettext.h hash.c \
	hash-pjw-bare.h hash-pjw-bare.c idx.h glthread/lock.h \
	glthread/lock.c malloca.c minmax.h read-file.c size_max.h \
	stat-time.c sys_socket.c glthread/threadlib.c unistd.c xsize.h \
	xsize.c
EXTRA_libgnu_la_SOURCES = explicit_bzero.c \
	fcntl.c float.c free.c getdelim.c getdtablesize.c \
	getline.c malloc.c memchr.c \
	memmem.c realloc.c secure_getenv.c \
	stpcpy.c strcasecmp.c strncasecmp.c fopen.c \
	strnlen.c strtok_r.c strverscmp.c time_r.c

LOCAL_SRC_FILES := $(call libgnutls_filter_sources,$(libgnu_la_SOURCES) \
		      $(EXTRA_libgnu_la_SOURCES))
LOCAL_MODULE := libgnu_gnutls
LOCAL_CFLAGS := $(libgnutls_common_CFLAGS) $(WARN_CFLAGS) \
  -DGNULIB_defined_F_DUPFD_CLOEXEC=1			  \
  -DO_BINARY=0 -fvisibility=hidden

include $(BUILD_STATIC_LIBRARY)
