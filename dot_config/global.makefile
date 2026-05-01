CXX = g++
CXXFLAGS = -Wall -std=c++17
SRCS = $(wildcard *.cpp)
PROGS = $(SRCS:.cpp=.exe)

all: $(PROGS)

%.exe: %.cpp
	-$(CXX) $(CXXFLAGS) $< -o $@
