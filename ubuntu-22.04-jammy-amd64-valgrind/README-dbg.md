# Debug image

Sometimes we'll get an error that's most easily reproduced in the
valgrind docker image. [citation needed]

The `build-dbg` and `dbg` shell provide some symbols and debugging
tools to fix that. Emacs is provided, as are some of the source packages.

You may need to se source directories with the `set substitute-path`
command.

e.g.:

```
pillow@2f7a4ea5c959:/Pillow/oss-fuzz-tests$ gdb python
GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from python...
(gdb) b _imagingft.c:922
No source file named _imagingft.c.
Make breakpoint pending on future shared library load? (y or [n]) y
Breakpoint 1 (_imagingft.c:922) pending.
(gdb) r f.py DejaVuSans-24-8-stripped.ttf
Starting program: /vpy3/bin/python f.py DejaVuSans-24-8-stripped.ttf
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Breakpoint 1, font_render (self=0x7ffff70e9780, args=<optimized out>) at src/_imagingft.c:922
922         if (!bitmap.buffer) {
...
0x00007ffff6fe4d6a in FT_Bitmap_Convert (library=<optimized out>, source=source@entry=0x7fffffffdff0, target=target@entry=0x7fffffffe020, alignment=alignment@entry=1) at ./src/base/ftbitmap.c:633
633 ./src/base/ftbitmap.c: No such file or directory.
(gdb) set substitute-path ./src /usr/src/freetype-2.11.1+dfsg/src/
(gdb) f
#0  0x00007ffff6fe4d6a in FT_Bitmap_Convert (library=<optimized out>, source=source@entry=0x7fffffffdff0, target=target@entry=0x7fffffffe020,
    alignment=alignment@entry=1) at ./src/base/ftbitmap.c:633
633             FT_Int  val = *ss;

```
