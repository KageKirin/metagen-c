add_library(xxHash
    xxHash/xxhash.c
    xxHash/xxhash.h
)

target_compile_features(xxHash
    PUBLIC
    c_std_23
)
