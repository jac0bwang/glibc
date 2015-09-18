/* Architecture specific code for pthread cancellation handling.
   Copyright (C) 2019 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#ifndef _NPTL_CANCELLATION_PC_CHECK
#define _NPTL_CANCELLATION_PC_CHECK

#include <sigcontextinfo.h>

/* Check if the program counter (PC) from ucontext CTX is within the start and
   then end boundary from the __syscall_cancel_arch bridge.  Return TRUE if
   the PC is within the boundary, meaning the syscall does not have any side
   effects; or FALSE otherwise.  */
static bool
ucontext_check_pc_boundary (void *ctx)
{
  /* Both are defined in syscall_cancel.S.  */
  extern const char __syscall_cancel_arch_start[1];
  extern const char __syscall_cancel_arch_end[1];

  uintptr_t pc = sigcontext_get_pc (ctx);
  return pc >= (uintptr_t) __syscall_cancel_arch_start
	 && pc < (uintptr_t) __syscall_cancel_arch_end;
}

#endif
