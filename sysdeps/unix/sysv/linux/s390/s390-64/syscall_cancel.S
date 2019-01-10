/* Cancellable syscall wrapper.  Linux/s390x version.
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

#include <sysdep.h>

/* long int __syscall_cancel_arch (int *cancelhandling,
				   __syscall_arg_t nr,
				   __syscall_arg_t arg1,
				   __syscall_arg_t arg2,
				   __syscall_arg_t arg3,
				   __syscall_arg_t arg4,
				   __syscall_arg_t arg5,
				   __syscall_arg_t arg6)  */

ENTRY (__syscall_cancel_arch)
	stmg	%r6, %r15, 48(%r15)
	cfi_offset (6, -112)
	cfi_offset (7, -104)
	cfi_offset (8, -96)
	cfi_offset (9, -88)
	cfi_offset (10, -80)
	cfi_offset (11, -72)
	cfi_offset (12, -64)
	cfi_offset (13, -56)
	cfi_offset (14, -48)
	cfi_offset (15, -40)
	aghi	%r15,-160
	cfi_def_cfa_offset (320)

	.globl __syscall_cancel_arch_start
	.type  __syscall_cancel_arch_start,@function
__syscall_cancel_arch_start:
	l	%r0,0(%r2)
	tmll	%r0,4
	jne	1f
	lgr	%r1,%r3
	lgr	%r2,%r4
	lgr	%r3,%r5
	lgr	%r4,%r6
	lg	%r5,320(%r15)
	lg	%r6,328(%r15)
	lg	%r7,336(%r15)
	svc	0

	.globl __syscall_cancel_arch_end
	.type  __syscall_cancel_arch_end,@function
__syscall_cancel_arch_end:
	lg	%r4,272(%r15)
	lmg	%r6,%r15,208(%r15)
	cfi_remember_state
	cfi_restore (15)
	cfi_restore (14)
	cfi_restore (13)
	cfi_restore (12)
	cfi_restore (11)
	cfi_restore (10)
	cfi_restore (9)
	cfi_restore (8)
	cfi_restore (7)
	cfi_restore (6)
	cfi_def_cfa_offset (160)
	br	%r4

1:
	cfi_restore_state
	brasl	%r14, __syscall_do_cancel
END (__syscall_cancel_arch)
libc_hidden_def (__syscall_cancel_arch)
