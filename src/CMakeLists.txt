# Create the main program.
add_executable(${PROJECT_NAME})

# Set source files.
target_sources(${PROJECT_NAME}
    PRIVATE
        main.cpp
)

# Process libraries.
add_subdirectory(foo)

# Link libraries.
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        foo
)