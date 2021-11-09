add_executable(metagen
    main.c
)

target_compile_features(metagen
    PUBLIC
    c_std_23
)

target_include_directories(metagen
    PUBLIC ../xxHash
)

target_link_libraries(metagen
    xxHash
)
