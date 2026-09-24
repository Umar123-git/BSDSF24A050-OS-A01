CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib

TARGET = $(BIN_DIR)/client_static
LIBRARY = $(LIB_DIR)/libmyutils.a

LIB_OBJECTS = $(OBJ_DIR)/mystrfunctions.o \
              $(OBJ_DIR)/myfilefunctions.o

MAIN_OBJECT = $(OBJ_DIR)/main.o

all: $(TARGET)

$(TARGET): $(MAIN_OBJECT) $(LIBRARY)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(TARGET)

$(LIBRARY): $(LIB_OBJECTS)
	@mkdir -p $(LIB_DIR)
	ar rcs $(LIBRARY) $(LIB_OBJECTS)

$(OBJ_DIR)/main.o: $(SRC_DIR)/main.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/main.c -o $(OBJ_DIR)/main.o

$(OBJ_DIR)/mystrfunctions.o: $(SRC_DIR)/mystrfunctions.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/mystrfunctions.c -o $(OBJ_DIR)/mystrfunctions.o

$(OBJ_DIR)/myfilefunctions.o: $(SRC_DIR)/myfilefunctions.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/myfilefunctions.c -o $(OBJ_DIR)/myfilefunctions.o

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(LIBRARY)
	rm -f $(TARGET)
	rm -f test.txt

rebuild: clean all

.PHONY: all clean rebuild
