##Change here to your project name##
TARGET = main

VECTORS = vector.o
STARTUP = ./startup_stm32f40xx.s

FP_FLAGS	?= -msoft-float
ARCH_FLAGS	= -mthumb -mcpu=cortex-m4 $(FP_FLAGS)

###############################################################################
# Executables

PREFIX		?= arm-none-eabi
CC		:= $(PREFIX)-gcc
LD		:= $(PREFIX)-gcc
OBJCOPY		:= $(PREFIX)-objcopy
OBJDUMP		:= $(PREFIX)-objdump

###############################################################################
# Source files

LDSCRIPT	= $(TARGET).ld
OBJS		+= $(TARGET).o
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


SRCC := main.c \
	aes.c 
#SRCS := $(STARTUP)
SRCS := Fs_aes.s \
	mul_mat_vec_4.s
OBJC := $(patsubst %.c, %.o, $(SRCC))
OBJS := $(patsubst %.s, %.o, $(SRCS))
OBJECTS := $(patsubst %.c, %.o, $(SRCC))
OBJECTS += $(patsubst %.s, %.o, $(SRCS))

all: elf bin list
elf: $(TARGET).elf
bin: $(TARGET).bin
list: $(TARGET).list

images: ${TARGET}.images

$(TARGET).images: $(TARGET).bin $(TARGET).list $(TARGET).map

${TARGET}.elf ${TARGET}.map: $(OBJECTS)
	$(Q)$(LD) $(LDFLAGS) $(VECTORS) $(ARCH_FLAGS) $(OBJECTS) $(ELMOASMFUNCTIONS) $(LDLIBS) -o ${TARGET}.elf

${TARGET}.bin: ${TARGET}.elf
	$(Q)$(OBJCOPY) -Obinary ${TARGET}.elf ${TARGET}.bin

${TARGET}.list: ${TARGET}.elf
	$(Q)$(OBJDUMP) -S ${TARGET}.elf > ${TARGET}.list


#Rule to compile OBJECTS.
${OBJC} : %.o : %.c
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) -c $^ -o $@

${OBJS} : %.o : %.s
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) -c $^ -o $@


clean:
	rm -f $(OBJECTS) ${TARGET}.list ${TARGET}.bin ${TARGET}.d ${TARGET}.elf


