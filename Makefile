CXX			:= g++
CXX_FLAGS 	:= -std=c++23
BIN			:= bin
SRC			:= src
INCLUDE		:= include

LIB_LOCAL	:=
LIB_LOCAL_D	:=

EXECUTABLE 	 := main
EXECUTABLE_D := main_d

#CCOPT = -O2 -pthread -qrtti -qtempinc -qstaticinline 
#CCOPT_D = -g -pthread -qrtti -qtempinc -qstaticinline 
CCOPT = $(CXX_FLAGS) -fPIC
CCOPT_D = $(CXX_FLAGS) -ggdb -fPIC


MPLDEFS = -D__NUMBER_FIELD_ID__ -DSYSV_SEM -DCOM_GNU
MPLDEFS_D = -D__NUMBER_FIELD_ID__ -DSYSV_SEM -DCOM_GNU -D_DEBUG -DDEBUG_TRACE -DDEBUG_LEVEL_FATAL -DDEBUG_LEVEL_1 \
                       -DDEBUG_LEVEL_2 -DDEBUG_LEVEL_3 -DDEBUG_LEVEL_4 -DDEBUG_LEVEL_5 \
                       -DDEBUG_LEVEL_6 


BOOST_INCLUDE := "C:\boost\include\boost-1_87"
BOOST_LIB	:= c:\boost\lib


BOOST_SUFIX := mgw14-mt-x64-1_87.a
BOOST_EXTLIB := """$(BOOST_LIB)\libboost_system-$(BOOST_SUFIX)""" \
	"""$(BOOST_LIB)\libboost_filesystem-$(BOOST_SUFIX)"""

BOOST_SUFIX_D := mgw14-mt-d-x64-1_87.a
BOOST_EXTLIB_D := """$(BOOST_LIB)\libboost_system-$(BOOST_SUFIX_D)""" \
	"""$(BOOST_LIB)\libboost_filesystem-$(BOOST_SUFIX_D)"""

# build targets
default:
	@echo "Usage   : make <target>"

clean:
	-rm $(BIN)/*

$(BIN)/$(EXECUTABLE): $(SRC)/*.cpp
	$(CXX) $(CCOPT) -I$(BOOST_INCLUDE) -I$(INCLUDE) $^ -o $@ -L$(BOOST_LIB) $(LIB_LOCAL) $(BOOST_EXTLIB)

$(BIN)/$(EXECUTABLE_D): $(SRC)/*.cpp
	$(CXX) $(CCOPT_D) -I$(BOOST_INCLUDE) -I$(INCLUDE) $^ -o $@ -L$(BOOST_LIB) $(LIB_LOCAL_D) $(BOOST_EXTLIB_D)


debug: $(BIN)/$(EXECUTABLE_D)
release: $(BIN)/$(EXECUTABLE)
all: clean debug release


#run: clean all
#	clear
#	./$(BIN)/$(EXECUTABLE)

#$(BIN)/$(EXECUTABLE): $(SRC)/*.cpp
#	$(CXX) $(CCOPT_D) -I$(BOOST_INCLUDE) -I$(INCLUDE) $^ -o $@ -L$(BOOST_LIB) $(LIBRARIES) $(BOOST_EXTLIB)

