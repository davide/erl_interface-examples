# External stuff

ERL_INTERFACE_DIR=c:/erl5.7.1/lib/erl_interface-3.6.1
VC_DIR=c:/Progra~1/VS9.0/VC
SRC_DIR=../src

# Standard things

.SUFFIXES:
.SUFFIXES:	.c .o

all:		targets


# Subdirectories, in random order

dir	:= $(SRC_DIR)/complex
include		$(dir)/Rules.mk
dir	:= $(SRC_DIR)/echo
include		$(dir)/Rules.mk

# General directory independent rules

%.beam:		%.erl
		$(ERL_COMP)

%.o:		%.c
		$(COMP)

%.o:		%.cpp
		$(COMP)

%:		%.o
		$(LINK)

%:		%.c
		$(COMPLINK)


# The variables TGT_*, CLEAN and CMD_INST* may be added to by the Makefile
# fragments in the various subdirectories.

.PHONY:		targets
targets:	$(TGT_BIN) $(TGT_SBIN) $(TGT_ETC) $(TGT_LIB)

.PHONY:		clean
clean:
		rm -f $(CLEAN)

.PHONY:		install
install:	targets 
		$(INST) $(TGT_BIN) -m 755 -d $(DIR_BIN)
		$(CMD_INSTBIN)
		$(INST) $(TGT_SBIN) -m 750 -d $(DIR_SBIN)
		$(CMD_INSTSBIN)
ifeq ($(wildcard $(DIR_ETC)/*),)
		$(INST) $(TGT_ETC) -m 644 -d $(DIR_ETC)
		$(CMD_INSTETC)
else
		@echo Configuration directory $(DIR_ETC) already present -- skipping
endif
		$(INST) $(TGT_LIB) -m 750 -d $(DIR_LIB)
		$(CMD_INSTLIB)


# Prevent make from removing any build targets, including intermediate ones

.SECONDARY:	$(CLEAN)

