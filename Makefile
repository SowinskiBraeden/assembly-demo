ASM      = as  # GNU Assembler
LD       = gcc # GCC Linker
LD_FLAGS = -nostartfiles

SRC = factorial.s
OBJ = factorial.o
OUT = factorial

all: $(OUT)

$(OBJ): $(SRC)
	$(ASM) $(SRC) -o $(OBJ)

$(OUT): $(OBJ)
	$(LD) $(LD_FLAGS) $(OBJ) -o $(OUT)

run: all
	./$(OUT)

clean:
	rm -f $(OBJ) $(OUT)
