set(TEST_NAME public_tests)

# Create a public test.
add_executable(${TEST_NAME})

# Set test files.
target_sources(${TEST_NAME}
    PRIVATE
        foo_tests.cpp
)

# Link libraries.
target_link_libraries(${TEST_NAME}
    PRIVATE
        # GoogleTest.
        ${GTEST_LIB}
        # Tested libraries.
        foo
)

# Add the test with CTest.
gtest_discover_tests(${TEST_NAME})