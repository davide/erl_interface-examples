# http://www.xs4all.nl/~evbergen/nonrecursive-make.html

include ../BuildConfig.mk

TARGET=gcc
BIN_EXT=

ERL_INTERFACE_LIBRARY_BINDING=-L$(ERL_INTERFACE_DIR)/lib -lerl_interface -lei

### Build flags for all targets
#
CF_ALL          = -g -Wall
LF_ALL          = 
LL_ALL          = -lpthread

### Build tools
# 
CC              = ../ccd-gcc
CPP_COMPILER    = g++
INST		= ../install
COMP            = $(CC) $(CF_ALL) $(CF_TGT) -o $@ -c $<
LINK            = $(CC) $(LF_ALL) $(LF_TGT) -o $@ $^ $(LL_TGT) $(LL_ALL)
COMPLINK        = $(CC) $(CF_ALL) $(CF_TGT) $(LF_ALL) $(LF_TGT) -o $@ $< $(LL_TGT) $(LL_ALL)
CPP_COMPLINK    = $(CPP_COMPILER) $(CF_ALL) $(CF_TGT) $(LF_ALL) $(LF_TGT) -o $@ $< $(LL_TGT) $(LL_ALL)
ARCH            = ar rcs $@ $^
ERL_COMP	= $(ERLC) $(ERLC_OPTIONS) $^

### Standard parts
#
include $(EXAMPLES_DIR)/Rules.mk
