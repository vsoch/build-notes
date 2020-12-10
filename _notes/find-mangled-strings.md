---
title: Finding Mangled Strings
categories: binary
tags: [binary]
maths: 1
toc: 1
---

{% include toc.html %}

I've been reading about these "mangled strings" that are left behind by compilers as a hint
to the functions that are needed, and I wanted to give a shot at actually seeing them.
Based on [this thread](https://www.linuxquestions.org/questions/programming-9/gcc-and-why-is-there-strings-in-the-binary-927240/) I'm deriving my own example. First, let's start with a file
to compile:

```cpp
#include <stdio.h>


class Car {
public:
	Car() { }
	
	virtual void Honk() = 0;
};


class RedCar : public Car {
public:
	RedCar() { }
	
	virtual void Honk();
};


void RedCar::Honk() {
	printf( "Honk!\n" );
}


int main( int argc, char *argv[] ) {
	RedCar mycar;
	mycar.Honk();
	return 0;
}
```

We then can create a Makefile that handles:

1. compiling the cpp file
2. linking
3. stripping

```makefile
CC = g++
CFLAGS = -Wall -fno-rtti -Os -fdata-sections -ffunction-sections # -Wall -O2
TARGET = car
 
all: $(TARGET).stripped

$(TARGET).stripped: $(TARGET)
	strip -o $(TARGET).stripped $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) -Wl,-O,-s,--gc-sections $(TARGET).o -o $(TARGET)
 
$(TARGET).o: $(TARGET).cpp
	$(CC) $(CFLAGS) -c $(TARGET).cpp -o $(TARGET).o

clean:
	$(RM) $(TARGET) $(TARGET).stripped $(TARGET).o
```

And then for the final stripped output, we can run:

```bash
$ strings car.stripped 
/lib64/ld-linux-x86-64.so.2
libc.so.6
puts
__stack_chk_fail
__cxa_finalize
__libc_start_main
GLIBC_2.4
GLIBC_2.2.5
_ITM_deregisterTMCloneTable
__gmon_start__
_ITM_registerTMCloneTable
5z	 
=1	 
AWAVI
AUATL
[]A\A]A^A_
Honk!
;*3$"
GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
.shstrtab
.interp
.note.ABI-tag
.note.gnu.build-id
.gnu.hash
.dynsym
.dynstr
.gnu.version
.gnu.version_r
.rela.dyn
.rela.plt
.init
.plt.got
.text
.fini
.rodata
.eh_frame_hdr
.eh_frame
.init_array
.fini_array
.data.rel.ro
.dynamic
.data
.bss
```

This is getting us somewhere! In the above we see what looks like metadata, along
with library versions, compilers, and function names. The forum mentions using something
called "sstrip" for a more aggressive stripping, but it doesn't seem to be installed by default.
These files can be found under [the examples folder](https://github.com/vsoch/build-notes/examples/find-mangled-strings/) if you want to try them out. Please submit a PR if you want to extend this example, or give better context.

<hr>

{% bibliography --cited %}
