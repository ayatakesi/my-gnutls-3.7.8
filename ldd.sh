#!/bin/sh
# Determine the dynamically linked dependencies of a program.

# Copyright (C) 2006-2021 Free Software Foundation, Inc.
# Written by Bruno Haible <bruno@clisp.org>, 2006.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Usage: ldd.sh program

LC_ALL=C objdump -p "$1" 2>/dev/null | sed -n -e 's,^  NEEDED *\([^ ].*\)$,\1,p'
