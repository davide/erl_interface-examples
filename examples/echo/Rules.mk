# Standard things

sp 		:= $(sp).x
dirstack_$(sp)	:= $(d)
d		:= $(dir)


## Subdirectories, in random order
#
#dir	:= $(d)/test
#include		$(dir)/Rules.mk
#


# Local variables

OBJS_$(d)	:= $(d)/erl_comm.o \
		   $(d)/echo.o \
   		   $(d)/main.o
DEPS_$(d)	:= $(OBJS_$(d):%.o=%.d)

TGTS_$(d)	:= $(d)/$(TARGET)/echo.exe
ERL_TGTS_$(d)	:= $(d)/echo.beam

CLEAN		:= $(CLEAN) $(OBJS_$(d)) $(DEPS_$(d)) \
		   $(TGTS_$(d)) $(ERL_TGTS_$(d))


# Local rules

$(OBJS_$(d)):	CF_TGT := -I$(d) -I$(ERL_INTERFACE_DIR)/include
$(ERL_TGTS_$(d)):  ERLC_OPTIONS	:= -o $(d)

TGT_BIN		:= $(TGT_BIN) $(TGTS_$(d)) $(ERL_TGTS_$(d))

$(TGTS_$(d)):	TGT_DIR := $(d)/$(TARGET)
$(TGTS_$(d)):	CF_TGT := 
$(TGTS_$(d)):	LL_TGT := $(S_LL_INET) $(ERL_INTERFACE_LIBRARY_BINDING) -lwsock32
$(TGTS_$(d)):	$(OBJS_$(d))
		mkdir -p $(TGT_DIR)
		$(LINK)

ERL_TGTS_$(d):	ERLC_OPTIONS := -o $(d)

# Standard things

-include	$(DEPS_$(d))

d		:= $(dirstack_$(sp))
sp		:= $(basename $(sp))
