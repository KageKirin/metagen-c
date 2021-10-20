FetchContent_Declare(
    xxHash
    GIT_REPOSITORY "https://github.com/Cyan4973/xxHash"
    GIT_TAG "dev"
)

FetchContent_MakeAvailable(xxHash)
FetchContent_GetProperties(xxHash)
