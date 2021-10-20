# makefile for metagen-cpp

all:
	zig build

clean:
	rm -rf zig-out
	rm -rf zig-cache

format:
	clang-format -i src/*.c #src/*.h
