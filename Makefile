SHELL = bash
PackagePath = $(shell pwd)

LIBRARY_TEXTIO = lib/libBUTool_TextIO.so
LIBRARY_TEXTIO_SOURCES = $(wildcard src/*.cc)
LIBRARY_TEXTIO_OBJECT_FILES = $(patsubst src/%.cc,obj/%.o,${LIBRARY_TEXTIO_SOURCES})

INCLUDE_PATH = -Iinclude
LIBRARY_PATH = -Llib

INSTALL_PATH ?= ./install

CPP_FLAGS = -std=c++11 -g -O3 -rdynamic -Wall -MMD -MP -fPIC ${INCLUDE_PATH} -Werror -Wno-literal-suffix

CPP_FLAGS +=-fno-omit-frame-pointer -Wno-ignored-qualifiers -Werror=return-type -Wextra -Wno-long-long -Winit-self -Wno-unused-local-typedefs  -Woverloaded-virtual

LINK_LIBRARY_FLAGS = -Xlinker "--no-as-needed" -shared -fPIC -Wall -g -O3 -rdynamic ${LIBRARY_PATH} -Wl,-rpath=${PackagePath}/lib

.PHONY: all _all clean _cleanall build _buildall

default: build
clean: _cleanall
_cleanall:
	rm -rf obj
	rm -rf bin
	rm -rf lib

all: _all
build: _all
buildall: _all
_all: ${LIBRARY_TEXTIO}

${LIBRARY_TEXTIO}: ${LIBRARY_TEXTIO_OBJECT_FILES}
	g++ ${LINK_LIBRARY_FLAGS}  ${LIBRARY_TEXTIO_OBJECT_FILES} -o $@

install: all
	install -m 775 -d ${INSTALL_PATH}/lib
	install -b -m 775 ./lib/* ${INSTALL_PATH}/lib

obj/%.o : src/%.cc
	mkdir -p $(dir $@)
	mkdir -p {lib,obj}
	g++ ${CPP_FLAGS} -c $< -o $@

-include $(LIBRARY_OBJECT_FILES:.o=.d)