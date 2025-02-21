CXX			:= g++
CXX_FLAGS 	:= -std=c++23
BIN			:= bin
SRC			:= src
INCLUDE_LOCAL := include

LIB_LOCAL	:=
LIB_LOCAL_D	:=

EXECUTABLE 	 := main
EXECUTABLE_D := main_d
EXECUTABLE_S := main_s
EXECUTABLE_SD := main_sd

#CCOPT = -O2 -pthread -qrtti -qtempinc -qstaticinline 
#CCOPT_D = -g -pthread -qrtti -qtempinc -qstaticinline 
CCOPT = $(CXX_FLAGS) -O2 -fPIC
CCOPT_D = $(CXX_FLAGS) -ggdb -fPIC

MPLDEFS = -D__NUMBER_FIELD_ID__ -DSYSV_SEM -DCOM_GNU
MPLDEFS_D = -D__NUMBER_FIELD_ID__ -DSYSV_SEM -DCOM_GNU -D_DEBUG -DDEBUG_TRACE -DDEBUG_LEVEL_FATAL -DDEBUG_LEVEL_1 \
                       -DDEBUG_LEVEL_2 -DDEBUG_LEVEL_3 -DDEBUG_LEVEL_4 -DDEBUG_LEVEL_5 \
                       -DDEBUG_LEVEL_6 

CFLAGS   = $(CCOPT) $(MPLDEFS)
CFLAGS_D = $(CCOPT_D) $(MPLDEFS_D)

BOOST_INCLUDE := "C:\boost\include\boost-1_87"
BOOST_LIB	:= c:\boost\lib

BOOST_SUFIX := mgw14-mt-x64-1_87.a
BOOST_EXTLIB := """$(BOOST_LIB)\libboost_system-$(BOOST_SUFIX)""" \
	"""$(BOOST_LIB)\libboost_filesystem-$(BOOST_SUFIX)"""

BOOST_SUFIX_D := mgw14-mt-d-x64-1_87.a
BOOST_EXTLIB_D := """$(BOOST_LIB)\libboost_system-$(BOOST_SUFIX_D)""" \
	"""$(BOOST_LIB)\libboost_filesystem-$(BOOST_SUFIX_D)"""

BOOST_SUFIX_S := mgw14-mt-s-x64-1_87.a
BOOST_EXTLIB_S := """$(BOOST_LIB)\libboost_system-$(BOOST_SUFIX_S)""" \
	"""$(BOOST_LIB)\libboost_filesystem-$(BOOST_SUFIX_S)"""

BOOST_SUFIX_SD := mgw14-mt-sd-x64-1_87.a
BOOST_EXTLIB_SD := """$(BOOST_LIB)\libboost_system-$(BOOST_SUFIX_SD)""" \
	"""$(BOOST_LIB)\libboost_filesystem-$(BOOST_SUFIX_SD)"""


INC_PATH = -I$(BOOST_INCLUDE) -I$(INCLUDE_LOCAL)

LIB_PATH = -L$(BOOST_LIB) -L$(LIB_LOCAL) $(BOOST_EXTLIB)
LIB_PATH_D = -L$(BOOST_LIB) -L$(LIB_LOCAL_D) $(BOOST_EXTLIB_D)
LIB_PATH_S = -L$(BOOST_LIB) -L$(LIB_LOCAL) $(BOOST_EXTLIB_S)
LIB_PATH_SD = -L$(BOOST_LIB) -L$(LIB_LOCAL_D) $(BOOST_EXTLIB_SD)


# build targets
default:
	@echo "Usage   : make <target>"

clean:
	-rm $(BIN)/*

$(BIN)/$(EXECUTABLE): $(SRC)/*.cpp
	$(CXX) $(CFLAGS) $(INC_PATH) $^ -o $@ $(LIB_PATH)

$(BIN)/$(EXECUTABLE_D): $(SRC)/*.cpp
	$(CXX) $(CFLAGS_D) $(INC_PATH) $^ -o $@ $(LIB_PATH_S)

$(BIN)/$(EXECUTABLE_S): $(SRC)/*.cpp
	$(CXX) $(CFLAGS) $(INC_PATH) $^ -o $@ $(LIB_PATH_S)

$(BIN)/$(EXECUTABLE_SD): $(SRC)/*.cpp
	$(CXX) $(CFLAGS_D) $(INC_PATH) $^ -o $@ $(LIB_PATH_SD)


debug: $(BIN)/$(EXECUTABLE_D)
release: $(BIN)/$(EXECUTABLE)
srelease: $(BIN)/$(EXECUTABLE_S)
sdebug: $(BIN)/$(EXECUTABLE_SD)

all: clean debug release
