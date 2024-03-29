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

# Static libminitasn1 module.
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../gl $(LOCAL_PATH)/../includes \
  $(LOCAL_PATH)/../unistring

# Import sources from Makefile.am.
libminitasn1_la_SOURCES = libtasn1.h gstr.h int.h parser_aux.h		\
        structure.h element.h decoding.c gstr.c errors.c parser_aux.c	\
        structure.c element.c coding.c version.c

LOCAL_SRC_FILES := $(call libgnutls_filter_sources,$(libminitasn1_la_SOURCES))
LOCAL_MODULE := libminitasn1
LOCAL_CFLAGS := $(libgnutls_common_CFLAGS)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)
