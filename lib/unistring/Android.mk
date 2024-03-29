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

# Static libgnutls_unistring module.
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../gl $(LOCAL_PATH)/../includes \
  $(LOCAL_PATH)/.. $(LOCAL_PATH)/../unistring

# Import source files from Makefile.am.
libunistring_la_SOURCES = unictype/categ_C.c unictype/categ_Cc.c	\
  unictype/categ_Cf.c unictype/categ_Cn.c unictype/categ_Co.c		\
  unictype/categ_Cs.c unictype/categ_L.c unictype/categ_LC.c		\
  unictype/categ_Ll.c unictype/categ_Lm.c unictype/categ_Lo.c		\
  unictype/categ_Lt.c unictype/categ_Lu.c unictype/categ_M.c		\
  unictype/categ_Mc.c unictype/categ_Me.c unictype/categ_Mn.c		\
  unictype/categ_N.c unictype/categ_Nd.c unictype/categ_Nl.c		\
  unictype/categ_No.c unictype/categ_P.c unictype/categ_Pc.c		\
  unictype/categ_Pd.c unictype/categ_Pe.c unictype/categ_Pf.c		\
  unictype/categ_Pi.c unictype/categ_Po.c unictype/categ_Ps.c		\
  unictype/categ_S.c unictype/categ_Sc.c unictype/categ_Sk.c		\
  unictype/categ_Sm.c unictype/categ_So.c unictype/categ_Z.c		\
  unictype/categ_Zl.c unictype/categ_Zp.c unictype/categ_Zs.c		\
  unictype/categ_and.c unictype/categ_and_not.c				\
  unictype/categ_byname.c unictype/categ_longname.c			\
  unictype/categ_name.c unictype/categ_none.c				\
  unictype/categ_of.c unictype/categ_or.c				\
  unictype/categ_test.c unictype/combiningclass.c			\
  unictype/pr_default_ignorable_code_point.c				\
  unictype/pr_join_control.c unictype/pr_not_a_character.c		\
  uninorm/canonical-decomposition.c					\
  uninorm/compat-decomposition.c uninorm/composition.c			\
  uninorm/decompose-internal.c uninorm/decomposition.c			\
  uninorm/decomposition-table.c uninorm/nfc.c uninorm/nfd.c		\
  uninorm/nfkc.c uninorm/nfkd.c uninorm/u16-normalize.c			\
  uninorm/u32-normalize.c uninorm/u8-normalize.c unistr/u16-cpy.c	\
  unistr/u16-mbtouc-unsafe.c unistr/u16-mbtouc-unsafe-aux.c		\
  unistr/u16-mbtoucr.c unistr/u16-to-u8.c unistr/u16-uctomb.c		\
  unistr/u16-uctomb-aux.c unistr/u32-cpy.c				\
  unistr/u32-mbtouc-unsafe.c unistr/u32-to-u8.c				\
  unistr/u32-uctomb.c unistr/u8-check.c unistr/u8-cpy.c			\
  unistr/u8-mbtouc-unsafe.c unistr/u8-mbtouc-unsafe-aux.c		\
  unistr/u8-mbtoucr.c unistr/u8-to-u16.c unistr/u8-to-u32.c		\
  unistr/u8-uctomb.c unistr/u8-uctomb-aux.c

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_SRC_FILES := $(call libgnutls_filter_sources,$(libunistring_la_SOURCES))
LOCAL_MODULE := libgnutls_unistring
LOCAL_CFLAGS := $(libgnutls_common_CFLAGS)
include $(BUILD_STATIC_LIBRARY)
