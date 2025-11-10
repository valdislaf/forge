cmake_minimum_required(VERSION 3.24)
project(ForGE LANGUAGES Fortran C)

find_package(glfw3 CONFIG REQUIRED)

add_executable(forge forge.f90)
target_link_libraries(forge PRIVATE glfw opengl32)
include(GNUInstallDirs)
install(TARGETS forge RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

