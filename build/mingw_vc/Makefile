# http://www.xs4all.nl/~evbergen/nonrecursive-make.html

include ../BuildConfig.mk

TARGET=mingw_vc
BIN_EXT=.exe

ERL_INTERFACE_DIR=c:/erl5.7.1/lib/erl_interface-3.6.1
VC_DIR=c:/Progra~1/VS9.0/VC
ERL_INTERFACE_LIBRARY_BINDING=-L$(ERL_INTERFACE_DIR)/lib -lerl_interface -lei -L$(VC_DIR)/lib

### Build flags for all targets
#
CF_ALL          = -g -Wall
LF_ALL          = 
LL_ALL          = -lwsock32

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
