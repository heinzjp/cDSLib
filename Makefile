# ====== Configurable Variables ======
PROJECT_NAME = cDSLib

#Directories
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build
EXAMPLES_DIR = examples
TESTS_DIR = tests
LIB_INSTALL_DIR = /usr/local/lib
INCLUDE_INSTALL_DIR = /usr/local/include

# Compiler settings
CC = gcc
CFLAGS = -Wall -Wextra -Iinclude -fPIC
LDFLAGS = -shared


SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC_FILES))
LIBRARY = $(BUILD_DIR)/lib${PROJECT_NAME}.so

all: $(LIBRARY) examples

# Make build dir
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Link objects into shared library
$(LIBRARY): $(OBJ_FILES)
	$(CC) $(LDFLAGS) $(OBJ_FILES) -o $(LIBRARY)

examples: $(LIBRARY)
	$(CC) $(EXAMPLES_DIR)/example.c -o $(BUILD_DIR)/example -I$(INCLUDE_DIR) -L$(BUILD_DIR) -l$(PROJECT_NAME)

install: $(LIB)
	sudo cp $(LIBRARY) $(LIB_INSTALL_DIR)
	sudo cp $(INCLUDE_DIR)/*.h $(INCLUDE_INSTALL_DIR)
	sudo ldconfig

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean examples install
