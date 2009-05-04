# http://www.xs4all.nl/~evbergen/nonrecursive-make.html

### Build flags for all targets
#
CF_ALL          = -g -Wall
LF_ALL          = 
LL_ALL          =

### Build tools
# 
CC              = ./build/ccd-gcc
CPP_COMPILER    = g++
INST		= ./build/install
ERLC		= erlc
COMP            = $(CC) $(CF_ALL) $(CF_TGT) -o $@ -c $<
LINK            = $(CC) $(LF_ALL) $(LF_TGT) -o $@ $^ $(LL_TGT) $(LL_ALL)
COMPLINK        = $(CC) $(CF_ALL) $(CF_TGT) $(LF_ALL) $(LF_TGT) -o $@ $< $(LL_TGT) $(LL_ALL)
CPP_COMPLINK    = $(CPP_COMPILER) $(CF_ALL) $(CF_TGT) $(LF_ALL) $(LF_TGT) -o $@ $< $(LL_TGT) $(LL_ALL)
ARCH            = ar rcs $@ $^
ERL_COMP	= erlc $(ERLC_OPTIONS) $^

### Standard parts
#
include Rules.mk
