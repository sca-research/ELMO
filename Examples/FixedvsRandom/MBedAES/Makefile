##
## This file is part of the libopencm3 project.
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


 V = 1
ifneq ($(V),1)
Q		:= @
NULL		:= 2>/dev/null
endif

BINARY = MBedAES

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
ELMOASMFUNCTIONS = ../../elmoasmfunctions.o


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
	$(Q)$(LD) $(LDFLAGS) vector.o $(ARCH_FLAGS) $(OBJS) $(ELMOASMFUNCTIONS) $(LDLIBS) -o $(BINARY).elf

$(BINARY).o: $(BINARY).c
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) -o $(BINARY).o -c $(BINARY).c

clean:
	$(Q)$(RM) $(BINARY).o $(BINARY).d $(BINARY).elf $(BINARY).bin $(BINARY).list $(BINARY).map
