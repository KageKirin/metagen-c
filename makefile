# makefile for metagen-cpp

all: build
	zig build
	cd build && cmake -G Ninja .. && cmake --build .

build:
	mkdir build

clean:
	rm -rf build
	rm -rf zig-out
	rm -rf zig-cache

format:
	clang-format -i src/*.cpp #src/*.h
