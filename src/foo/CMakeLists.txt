# Create a library.
set(LIB_NAME foo)
add_library(${LIB_NAME})

set(HEADER_PATH ${PROJECT_SOURCE_DIR}/include/${LIB_NAME})

# Set header paths.
target_include_directories(${LIB_NAME}
    # Set a private header path.
    # For the files in the current folder, developers only need to use `foo.h` to include the `include/foo/foo.h` file.
    PRIVATE
        ${HEADER_PATH}
    # Set a public header path.
    # For other users, they need to use `foo/foo.h` to include the `include/foo/foo.h` file.
    # It can prevent name conflicts caused by multiple libraries using header files with the same name.
    PUBLIC
        ${PROJECT_SOURCE_DIR}/include
)

# Set source files.
target_sources(${LIB_NAME}
    PUBLIC
        # Use the private header path to specify a header file.
        ${HEADER_PATH}/${LIB_NAME}.h
    PRIVATE
        ${LIB_NAME}.cpp
        private_${LIB_NAME}.h
        private_${LIB_NAME}.cpp
)

###########################################################################################################

if(GTest_FOUND)
    set(TEST_NAME ${LIB_NAME}_tests)

    # Create a private test.
    add_executable(${TEST_NAME})

    # Set the private header path.
    target_include_directories(${TEST_NAME}
        PRIVATE
            $<TARGET_PROPERTY:${LIB_NAME},INCLUDE_DIRECTORIES>
    )

    # Set test files.
    target_sources(${TEST_NAME}
        PRIVATE
            private_${TEST_NAME}.cpp
    )

    # Link libraries.
    target_link_libraries(${TEST_NAME}
        PRIVATE
            # GoogleTest.
            ${GTEST_LIB}
            # Public tested libraries.
            ${LIB_NAME}
            # Private tested libraries.
            $<TARGET_PROPERTY:${LIB_NAME},LINK_LIBRARIES>
    )

    # Add the test with CTest.
    gtest_discover_tests(${TEST_NAME})
endif()