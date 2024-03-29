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
gnutls_save_LOCAL_PATH := $(LOCAL_PATH)
libgnutls_common_CFLAGS := -O2 -DHAVE_CONFIG_H -I$(LOCAL_PATH)
libgnutls_filter_sources = $(filter-out %.h,$(1))

include $(LOCAL_PATH)/lib/Android.mk $(LOCAL_PATH)/gl/Android.mk

# All of the modules (including gnutls's gnulib.. ugh) required to
# build libgnutls_emacs.so have now been defined.  Now, restore
# LOCAL_PATH.

LOCAL_PATH := $(gnutls_save_LOCAL_PATH)

# Define the static library module libgnutls_static.  This should not
# be linked to; it is only used to build libgnutls.
include $(CLEAR_VARS)

include $(BUILD_STATIC_LIBRARY)

# Define the shared library module libgnutls.
include $(CLEAR_VARS)
LOCAL_WHOLE_STATIC_LIBRARIES := libgnutls_x509 libgnutls_auth	\
  libgnutls_ext libgnutls_alg libgnutls_extras libgnu_gnutls	\
  libgnutls_unistring libgnutls_crypto libgnutls_accelerated

LOCAL_LDFLAGS := -no-undefined
LOCAL_CFLAGS := $(libgnutls_common_CFLAGS)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/gl $(LOCAL_PATH)/lib/includes \
  $(LOCAL_PATH)/lib $(LOCAL_PATH)/lib/minitasn1			\
  $(LOCAL_PATH)/lib/unistring
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/lib/includes

# Import sources from lib/Makefile.am.

libgnutls_LA_SOURCES = abstract_int.h debug.h compress.h cipher.h			\
  buffers.h errors.h gnutls_int.h dtls.h handshake.h num.h				\
  algorithms.h dh.h kx.h hash_int.h cipher_int.h db.h auth.h				\
  hello_ext.h handshake-defs.h x509_b64.h sslv2_compat.h datum.h mpi.h pk.h		\
  record.h inih/ini.h constate.h global.h tls-sig.h mem.h session_pack.h		\
  str.h str_array.h state.h x509.h crypto-backend.h srp.h auth/srp_kx.h			\
  auth/srp_passwd.h file.h supplemental.h crypto.h random.h system.h locks.h		\
  mbuffers.h ecc.h pin.h fips.h priority_options.h secrets.h stek.h			\
  cert-cred.h pkcs11_int.h pkcs11x.h vko.h range.c record.c compress.c			\
  debug.c cipher.c gthreads.h handshake-tls13.c mbuffers.c buffers.c			\
  handshake.c errors.c dh.c kx.c cipher-cbc.c priority.c hash_int.c			\
  cipher_int.c session.c db.c x509_b64.c hello_ext.c auth.c sslv2_compat.c		\
  datum.c session_pack.c mpi.c pk.c cert-cred.c global.c constate.c anon_cred.c		\
  pkix_asn1_tab.c gnutls_asn1_tab.c mem.c fingerprint.c tls-sig.c ecc.c			\
  alert.c privkey_raw.c atomic.h system/certs.c system/threads.c			\
  system/fastopen.c system/sockets.c str-iconv.c					\
  system.c profiles.c profiles.h inih/ini.c str.c str-unicode.c str-idna.c		\
  state.c cert-cred-x509.c file.c supplemental.c random.c crypto-api.c crypto-api.h	\
  privkey.c pcert.c pubkey.c locks.c dtls.c system_override.c crypto-backend.c		\
  verify-tofu.c pin.c tpm.c fips.c safe-memfuncs.c atfork.c atfork.h			\
  randomart.c name_val_array.h system-keys.h urls.c urls.h prf.c auto-verify.c		\
  dh-session.c cert-session.c handshake-checks.c dtls-sw.c dh-primes.c			\
  openpgp_compat.c crypto-selftests.c							\
  crypto-selftests-pk.c secrets.c extv.c extv.h hello_ext_lib.c hello_ext_lib.h		\
  ocsp-api.c										\
  stek.c cert-cred-rawpk.c iov.c iov.h system/ktls.c system/ktls.h vko.c		\
  system/keys-dummy.c tls13/encrypted_extensions.c tls13/encrypted_extensions.h		\
  tls13/certificate_request.c tls13/certificate_request.h				\
  tls13/certificate_verify.c tls13/certificate_verify.h					\
  tls13-sig.c tls13-sig.h tls13/finished.c tls13/finished.h				\
  tls13/key_update.c tls13/key_update.h tls13/hello_retry.c				\
  tls13/hello_retry.h tls13/session_ticket.c tls13/session_ticket.h			\
  tls13/certificate.c tls13/certificate.h tls13/early_data.c tls13/early_data.h		\
  tls13/post_handshake.c tls13/psk_ext_parser.c tls13/psk_ext_parser.h			\
  tls13/anti_replay.c tls13/anti_replay.h pkcs11.c pkcs11x.c				\
  pkcs11_privkey.c pkcs11_write.c pkcs11_secret.c pkcs11_int.c				\
  srp.c psk.c gnutls.asn pkix.asn libgnutls.map

LOCAL_LDFLAGS := --no-undefined
LOCAL_MODULE := gnutls
LOCAL_SRC_FILES := $(addprefix lib/,$(filter %.c,$(libgnutls_LA_SOURCES)))
LOCAL_SHARED_LIBRARIES := libz libgmp
include $(BUILD_SHARED_LIBRARY)

# Import required modules.
$(call import-module,libnettle)
$(call import-module,libhogweed)
$(call import-module,libtasn1)
$(call import-module,p11-kit)
