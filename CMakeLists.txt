# Set the minimum CMake version.
cmake_minimum_required(VERSION 3.20.0)

# Set the project name and the language.
set(PROJECT_NAME cpp-sample)
project(${PROJECT_NAME} LANGUAGES CXX)

# Add the `cmake` folder to the list of CMake module folders.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
# Inject CMake scripts.
include(hello)

# Set the C++ version to C++20.
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set output folders.
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

option(BUILD_TESTS "Build unit tests" OFF)

if(BUILD_TESTS)
    # Find GoogleTest.
    find_package(GTest)

    if(GTest_FOUND)
        # Enable testing.
        enable_testing()

        set(GTEST_LIB GTest::gtest GTest::gtest_main)
        set(GMOCK_LIB GTest::gmock GTest::gmock_main)

        # Delay test discovery until just prior to test execution.
        set(CMAKE_GTEST_DISCOVER_TESTS_DISCOVERY_MODE PRE_TEST)

        # Process public tests.
        add_subdirectory(tests)
    endif()
endif()

# Process source files after enabling testing.
add_subdirectory(src)