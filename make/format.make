## formatting makerules

ALL_SOURCE_FILES = \
	$(shell fd ".*\.h"   -- src)       \
	$(shell fd ".*\.c"   -- src)

ALL_TRACKED_FILES = \
	$(shell git ls-files -- src | rg ".*\.h")         \
	$(shell git ls-files -- src | rg ".*\.c")

ALL_MODIFIED_FILES = \
	$(shell git ls-files -m -- src)


format-all: $(ALL_SOURCE_FILES)
	clang-format -i $^

format: $(ALL_TRACKED_FILES)
	clang-format -i $^
	#$(GENIE) format

q qformat: $(ALL_MODIFIED_FILES)
	clang-format -i $^
