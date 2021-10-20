# makefile for metagen-cpp

regular-build: build
	cd build && \
	cmake -G Ninja .. && \
	cmake --build .

zig-build:
	zig build


all: \
	regular-build \
	linux \
	macos \
	windows \
	zig-build

build:
	mkdir build

clean:
	rm -rf build
	rm -rf build-linux
	rm -rf build-macos
	rm -rf build-windows
	rm -rf zig-out
	rm -rf zig-cache

format:
	clang-format -i src/*.cpp #src/*.h


build-linux:
	mkdir build-linux

linux: build-linux
	cd build-linux && \
	CC="zig cc -target x86_64-linux" CXX="zig c++ -target x86_64-linux" cmake -G Ninja .. && \
	CC="zig cc -target x86_64-linux" CXX="zig c++ -target x86_64-linux" cmake --build .


build-macos:
	mkdir build-macos

macos: build-macos
	cd build-macos && \
	CC="zig cc -target x86_64-macos" CXX="zig c++ -target x86_64-macos" cmake -G Ninja .. && \
	CC="zig cc -target x86_64-macos" CXX="zig c++ -target x86_64-macos" cmake --build .


build-windows:
	mkdir build-windows

windows: build-windows
	cd build-windows && \
	CC="zig cc -target x86_64-windows" CXX="zig c++ -target x86_64-windows" cmake -G Ninja .. && \
	CC="zig cc -target x86_64-windows" CXX="zig c++ -target x86_64-windows" cmake --build .
