# makefile for metagen-cpp

all: build
	cd build && cmake -G Ninja .. && cmake --build .

build:
	mkdir build

clean:
	rm -rf build

format:
	clang-format -i src/*.cpp #src/*.h
