<#
.SYNOPSIS
    Build the project with CMake.
.DESCRIPTION
    This script will run the following commands:
    ```
    mkdir -p build
    cd build
    cmake -DBUILD_TESTS=ON ..
    cmake --build .
    ```
#>
[CmdletBinding()]
param()

New-Item -Name 'build' -ItemType 'Directory' -Force
Set-Location -Path 'build'

Start-Process -FilePath 'cmake' -ArgumentList '-DBUILD_TESTS=ON', '..' -NoNewWindow -Wait
Start-Process -FilePath 'cmake' -ArgumentList '--build', '.' -NoNewWindow -Wait