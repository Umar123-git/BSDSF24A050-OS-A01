CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib

TARGET = $(BIN_DIR)/client_static
TARGET_DYNAMIC = $(BIN_DIR)/client_dynamic
LIBRARY = $(LIB_DIR)/libmyutils.a
SHARED_LIBRARY = $(LIB_DIR)/libmyutils.so

LIB_OBJECTS = $(OBJ_DIR)/mystrfunctions.o \
              $(OBJ_DIR)/myfilefunctions.o

PIC_OBJECTS = $(OBJ_DIR)/mystrfunctions_pic.o \
              $(OBJ_DIR)/myfilefunctions_pic.o

MAIN_OBJECT = $(OBJ_DIR)/main.o

all: $(TARGET) $(TARGET_DYNAMIC)

$(TARGET): $(MAIN_OBJECT) $(LIBRARY)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(TARGET)

$(TARGET_DYNAMIC): $(MAIN_OBJECT) $(SHARED_LIBRARY)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(TARGET_DYNAMIC)

$(LIBRARY): $(LIB_OBJECTS)
	@mkdir -p $(LIB_DIR)
	ar rcs $(LIBRARY) $(LIB_OBJECTS)

$(SHARED_LIBRARY): $(PIC_OBJECTS)
	@mkdir -p $(LIB_DIR)
	$(CC) -shared -o $(SHARED_LIBRARY) $(PIC_OBJECTS)

$(OBJ_DIR)/main.o: $(SRC_DIR)/main.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/main.c -o $(OBJ_DIR)/main.o

$(OBJ_DIR)/mystrfunctions.o: $(SRC_DIR)/mystrfunctions.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/mystrfunctions.c -o $(OBJ_DIR)/mystrfunctions.o

$(OBJ_DIR)/myfilefunctions.o: $(SRC_DIR)/myfilefunctions.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/myfilefunctions.c -o $(OBJ_DIR)/myfilefunctions.o

$(OBJ_DIR)/mystrfunctions_pic.o: $(SRC_DIR)/mystrfunctions.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -fPIC -c $(SRC_DIR)/mystrfunctions.c -o $(OBJ_DIR)/mystrfunctions_pic.o

$(OBJ_DIR)/myfilefunctions_pic.o: $(SRC_DIR)/myfilefunctions.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -fPIC -c $(SRC_DIR)/myfilefunctions.c -o $(OBJ_DIR)/myfilefunctions_pic.o

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(LIBRARY) $(SHARED_LIBRARY)
	rm -f $(TARGET) $(TARGET_DYNAMIC)
	rm -f test.txt

rebuild: clean all

.PHONY: all clean rebuild install
install: all
	@mkdir -p /usr/local/bin /usr/local/share/man/man3
	sudo cp $(TARGET) /usr/local/bin/client
	sudo cp man/man3/*.3 /usr/local/share/man/man3/
	sudo mandb
