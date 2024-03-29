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

# Static libgnutls_ext module.
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../gl $(LOCAL_PATH)/../includes \
  $(LOCAL_PATH)/.. $(LOCAL_PATH)/../unistring

# Import sources from Makefile.am.
libgnutls_ext_la_SOURCES = max_record.c \
	server_name.c signature.c safe_renegotiation.c \
	max_record.h server_name.h srp.h \
	session_ticket.h signature.h safe_renegotiation.h \
	session_ticket.c srp.c heartbeat.c heartbeat.h \
	status_request.h status_request.c dumbfw.c dumbfw.h \
	ext_master_secret.c ext_master_secret.h etm.h etm.c \
	supported_versions.c supported_versions.h \
	post_handshake.c post_handshake.h key_share.c key_share.h \
	cookie.c cookie.h \
	psk_ke_modes.c psk_ke_modes.h pre_shared_key.c pre_shared_key.h \
	supported_groups.c supported_groups.h \
	ec_point_formats.c ec_point_formats.h \
	early_data.c early_data.h \
	record_size_limit.c record_size_limit.h \
	client_cert_type.c client_cert_type.h \
	server_cert_type.c server_cert_type.h \
	cert_types.h \
	compress_certificate.c compress_certificate.h

LOCAL_SRC_FILES := $(call libgnutls_filter_sources,$(libgnutls_ext_la_SOURCES)) \
  srtp.c alpn.c
LOCAL_SHARED_LIBRARIES := libtasn1
LOCAL_MODULE := libgnutls_ext
LOCAL_CFLAGS := $(libgnutls_common_CFLAGS)
include $(BUILD_STATIC_LIBRARY)
