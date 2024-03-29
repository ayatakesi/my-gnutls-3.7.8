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

# Static libgnutls_x509 module.
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../gl $(LOCAL_PATH)/../includes \
  $(LOCAL_PATH)/.. $(LOCAL_PATH)/../unistring $(LOCAL_PATH)

# Import source files from Makefile.am.
libgnutls_x509_la_SOURCES =	\
	common.c key_encode.c	\
	common.h key_decode.c	\
	time.c			\
	crl.c			\
	crl_write.c		\
	crq.c			\
	dn.c			\
	attributes.c		\
	attributes.h		\
	prov-seed.c		\
	prov-seed.h		\
	extensions.c		\
	mpi.c			\
	output.c		\
	pkcs12.c		\
	pkcs12_bag.c		\
	pkcs12_encr.c		\
	pkcs7.c			\
	pkcs7-attrs.c		\
	pkcs7-crypt.c pkcs7_int.h \
	privkey.c		\
	privkey_pkcs8.c		\
	privkey_pkcs8_pbes1.c	\
	privkey_openssl.c	\
	hostname-verify.c	\
	sign.c			\
	verify.c		\
	x509.c x509_dn.c	\
	x509_int.h		\
	x509_write.c		\
	name_constraints.c	\
	verify-high.c		\
	verify-high2.c		\
	verify-high.h		\
	x509_ext.c		\
	email-verify.c		\
	pkcs7-output.c		\
	virt-san.c		\
	virt-san.h		\
	spki.c			\
	x509_ext_int.h		\
	tls_features.c		\
	krb5.c krb5.h		\
	ip.c ip.h ip-in-cidr.h  \
	supported_exts.h ocsp.h

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_SHARED_LIBRARIES := libnettle p11-kit libtasn1
LOCAL_SRC_FILES := $(call libgnutls_filter_sources,$(libgnutls_x509_la_SOURCES))
LOCAL_SRC_FILES += ocsp.c ocsp_output.c
LOCAL_MODULE := libgnutls_x509
LOCAL_CFLAGS := $(libgnutls_common_CFLAGS)
include $(BUILD_STATIC_LIBRARY)
