CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

TARGET = $(BIN_DIR)/client

SOURCES = $(SRC_DIR)/main.c \
          $(SRC_DIR)/mystrfunctions.c \
          $(SRC_DIR)/myfilefunctions.c

OBJECTS = $(OBJ_DIR)/main.o \
          $(OBJ_DIR)/mystrfunctions.o \
          $(OBJ_DIR)/myfilefunctions.o

all: $(TARGET)

$(TARGET): $(OBJECTS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(TARGET)

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
	rm -f $(TARGET)
	rm -f test.txt

rebuild: clean all

.PHONY: all clean rebuild
