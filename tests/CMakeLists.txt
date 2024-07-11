set(TEST_NAME public-test)

# Create a public test.
add_executable(${TEST_NAME})

# Set test files.
target_sources(${TEST_NAME}
    PRIVATE
        foo_test.cpp
)

# Link the corresponding libraries.
target_link_libraries(${TEST_NAME}
    PRIVATE
        foo
)

# Link GoogleTest.
target_link_libraries(${TEST_NAME}
    PRIVATE
        ${GTEST_LIBS}
        ${GMOCK_LIBS}
)

# Add the test with CTest.
gtest_discover_tests(${TEST_NAME})