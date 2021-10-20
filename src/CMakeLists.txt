add_executable(metagen
    main.c
)

target_compile_features(metagen
    PUBLIC
    c_std_23
)
