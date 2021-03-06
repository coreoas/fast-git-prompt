NAME = git-glimpse
BUILD_DIR = ./bin
SRC_DIR = ./src
DEST_DIR = /usr/local/bin/

CC = cc
INCLUDES = -I$(SRC_DIR)
LIBS = libgit2
CFLAGS += -std=c99 -W -Wall -pedantic -O2 -D'BINNAME="$(NAME)"'
LDFLAGS +=

ifneq ($(LIBS),)
	CFLAGS += $(shell pkg-config --cflags $(LIBS))
	LDFLAGS += $(shell pkg-config --libs $(LIBS))
endif

SRCS = $(wildcard src/*.c)
OBJS = $(SRCS:.c=.o)

all: $(BUILD_DIR)/$(NAME)

$(BUILD_DIR)/$(NAME): $(OBJS)
	@$(CC) $(OBJS) $(LDFLAGS) -o $@

$(BUILD_DIR)/%.o: $(SRC_PATH)/%.c
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@


.PHONY: clean
clean:
	rm -f $(OBJS) $(BUILD_DIR)/$(NAME)

.PHONY: install
install: $(BUILD_DIR)/$(NAME)
	install $(BUILD_DIR)/$(NAME) $(DEST_DIR)

.PHONY: uninstall
uninstall:
	rm $(DEST_DIR)/$(NAME)
