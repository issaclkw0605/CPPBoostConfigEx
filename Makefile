CXX			:= g++
CXX_FLAGS 	:= -std=c++20 -ggdb
BOOST_FLAGS := -libboost_system-mgw14-mt-d-x64-1_87.a -libboost_filesystem-mgw14-mt-d-x64-1_87.a

BIN			:= bin
SRC			:= src
INCLUDE		:= include
BOOST_INCLUDE := "C:\boost\include\boost-1_87"

LIBRARIES	:=
BOOST_LIB	:= "c:\boost\lib"
EXECUTABLE 	:= main

all: $(BIN)/$(EXECUTABLE)

run: clean all
	clear
	./$(BIN)/$(EXECUTABLE)

$(BIN)/$(EXECUTABLE): $(SRC)/*.cpp
	$(CXX) $(CXX_FLAGS) -I$(BOOST_INCLUDE) -I$(INCLUDE) $^ -o $@ -L$(BOOST_LIB) $(LIBRARIES) """c:\boost\lib\libboost_system-mgw14-mt-d-x64-1_87.a""" """c:\boost\lib\libboost_filesystem-mgw14-mt-d-x64-1_87.a"""

clean:
	-rm $(BIN)/*
