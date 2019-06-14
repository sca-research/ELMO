##Change here to your project name##
TARGET = BS_maskedAES

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

LDSCRIPT	= $(TARGET).ld
OBJS		+= $(TARGET).o
ELMOASMFUNCTIONS = elmoasmfunctions.o


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


SRC := ./
OBJ := ./

TARGET = BS_maskedAES
SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))

all: elf bin list
elf: $(TARGET).elf
bin: $(TARGET).bin
list: $(TARGET).list

images: ${TARGET}.images

$(TARGET).images: $(TARGET).bin $(TARGET).list $(TARGET).map

${TARGET}.elf ${TARGET}.map: $(OBJECTS) $(LDSCRIPT)
	$(Q)$(LD) $(LDFLAGS) $(VECTORS) $(ARCH_FLAGS) $(OBJECTS) $(ELMOASMFUNCTIONS) $(LDLIBS) -o ${TARGET}.elf

${TARGET}.bin: ${TARGET}.elf
	$(Q)$(OBJCOPY) -Obinary ${TARGET}.elf ${TARGET}.bin

${TARGET}.list: ${TARGET}.elf
	$(Q)$(OBJDUMP) -S ${TARGET}.elf > ${TARGET}.list


#Rule to compile OBJECTS.
${OBJ}/%.o : ${SRC}/%.c
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) -c $< -o $@

clean:
	rm -f aes_*.o aes_*.d bs.d bs.o ${TARGET}.o ${TARGET}.list ${TARGET}.bin ${TARGET}.d ${TARGET}.elf


