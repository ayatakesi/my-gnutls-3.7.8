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

# Static libgnutls_crypto module.
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../gl $(LOCAL_PATH)/../includes \
  $(LOCAL_PATH) $(LOCAL_PATH)/.. $(LOCAL_PATH)/int

# Import sources from Makefile.am.
libcrypto_la_SOURCES = pk.c mpi.c mac.c cipher.c init.c \
	gnettle.h rnd-common.h prf.c \
	rnd.c int/rsa-fips.h int/rsa-keygen-fips186.c int/provable-prime.c \
	int/dsa-fips.h int/dsa-keygen-fips186.c int/dsa-validate.c \
	int/tls1-prf.c int/tls1-prf.h \
	int/dsa-compute-k.c int/dsa-compute-k.h \
	int/ecdsa-compute-k.c int/ecdsa-compute-k.h \
	int/mpn-base256.c int/mpn-base256.h \
	int/block8.h backport/block-internal.h \
	int/rsa-pad.c

libcrypto_la_SOURCES += \
	gost/nettle-write.h gost/write-le32.c \
	gost/gost28147.c gost/gost28147.h gost/gost-wrap.c \
	gost/streebog.c gost/streebog.h gost/streebog-meta.c \
	gost/hmac-streebog.c gost/hmac-gost.h

libcrypto_la_SOURCES += \
	gost/bignum-le.c gost/bignum-le.h

libcrypto_la_SOURCES += \
	gost/gostdsa-mask.c gost/gostdsa2.h

libcrypto_la_SOURCES += gost_keywrap.c

libcrypto_la_SOURCES += \
	gost/magma.c gost/magma.h \
	gost/kuznyechik.c gost/kuznyechik.h gost/kuztable.h \
	gost/acpkm.c gost/acpkm.h \
	gost/cmac.h gost/cmac-magma.c gost/cmac-kuznyechik.c

LOCAL_SRC_FILES := $(call libgnutls_filter_sources,$(libcrypto_la_SOURCES)) \
  sysrng-linux.c
LOCAL_MODULE := libgnutls_crypto
LOCAL_CFLAGS := $(libgnutls_common_CFLAGS)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_SHARED_LIBRARIES := libnettle libhogweed libtasn1
include $(BUILD_STATIC_LIBRARY)
