##
## University of Bristol – Open Access Software Licence
## Copyright (c) 2016, The University of Bristol, a chartered
## corporation having Royal Charter number RC000648 and a charity
## (number X1121) and its place of administration being at Senate
## House, Tyndall Avenue, Bristol, BS8 1TH, United Kingdom.
## All rights reserved
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions
## are met:
##
## 1. Redistributions of source code must retain the above copyright
## notice, this list of conditions and the following disclaimer.
##
## 2. Redistributions in binary form must reproduce the above
## copyright notice, this list of conditions and the following
## disclaimer in the documentation and/or other materials provided
## with the distribution.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
## FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
## COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
## INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
## (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
## SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
## HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
## STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
## ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
## OF THE POSSIBILITY OF SUCH DAMAGE.
##
## Any use of the software for scientific publications or commercial
## purposes should be reported to the University of Bristol
## (OSI-notifications@bristol.ac.uk and quote reference 2668). This is
## for impact and usage monitoring purposes only.
##
## Enquiries about further applications and development opportunities
## are welcome. Please contact elisabeth.oswald@bristol.ac.uk
##

##
## This file was based on files that are part of the libopencm3 project. See below for licecning information.
##
## Copyright (C) 2009 Uwe Hermann <uwe@hermann-uwe.de>
## Copyright (C) 2010 Piotr Esden-Tempski <piotr@esden.net>
## Copyright (C) 2011 Fergus Noble <fergusnoble@gmail.com>
##
## This library is free software: you can redistribute it and/or modify
## it under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This library is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Lesser General Public License for more details.
##
## You should have received a copy of the GNU Lesser General Public License
## along with this library.  If not, see <http://www.gnu.org/licenses/>.

# Remove to display makefile output
Q		:= @

BINARY = runtime
VECTORS = vector.o

FP_FLAGS	?= -msoft-float
ARCH_FLAGS	= -mthumb -mcpu=cortex-m0 $(FP_FLAGS)

###############################################################################
# Executables

PREFIX		?= arm-none-eabi
CC		:= $(PREFIX)-gcc
LD		:= $(PREFIX)-gcc
OBJCOPY		:= $(PREFIX)-objcopy
OBJDUMP		:= $(PREFIX)-objdump

###############################################################################
# Source files

LDSCRIPT	= $(BINARY).ld
OBJS		+= $(BINARY).o
ELMOASMFUNCTIONS = ../elmoasmfunctions.o


###############################################################################
# C flags

CFLAGS += -Os -g
CFLAGS += -Wextra -Wshadow -Wimplicit-function-declaration
CFLAGS += -Wredundant-decls -Wmissing-prototypes -Wstrict-prototypes
CFLAGS += -fno-common -ffunction-sections -fdata-sections

###############################################################################
# C & C++ preprocessor common flags

CPPFLAGS	+= -MD
CPPFLAGS	+= -Wall -Wundef

###############################################################################
# Linker flags

LDFLAGS		+= --static -nostartfiles
LDFLAGS		+= -T$(LDSCRIPT)
LDFLAGS		+= -Wl,-Map=$(*).map
LDFLAGS		+= -Wl,--gc-sections

###############################################################################
# Used libraries

LDLIBS		+= -Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group

###############################################################################
###############################################################################
###############################################################################

all: elf bin list
elf: $(BINARY).elf
bin: $(BINARY).bin
list: $(BINARY).list

images: $(BINARY).images

$(BINARY).images: $(BINARY).bin $(BINARY).list $(BINARY).map

$(BINARY).bin: $(BINARY).elf
	$(Q)$(OBJCOPY) -Obinary $(BINARY).elf $(BINARY).bin

$(BINARY).list: $(BINARY).elf
	$(Q)$(OBJDUMP) -S $(BINARY).elf > $(BINARY).list

$(BINARY).elf $(BINARY).map: $(OBJS) $(LDSCRIPT)
	$(Q)$(LD) $(LDFLAGS) $(VECTORS) $(ARCH_FLAGS) $(BINARY).s $(OBJS) $(ELMOASMFUNCTIONS) $(LDLIBS) -o $(BINARY).elf

$(BINARY).o: $(BINARY).c
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) -o $(BINARY).o -c $(BINARY).c

clean:
	$(Q)$(RM) $(BINARY).o $(BINARY).d $(BINARY).elf $(BINARY).bin $(BINARY).list $(BINARY).map
