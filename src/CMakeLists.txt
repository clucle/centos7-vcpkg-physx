cmake_minimum_required(VERSION 3.10)

project(VcpkgPhysX)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNDEBUG")
set(THREADS_PREFER_PTHREAD_FLAG ON)

add_executable(${PROJECT_NAME} main.cpp)

find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)

find_library(dl NAMES dl PATH /usr/lib/x86_64-linux-gnu/libdl.so)
target_link_libraries(${PROJECT_NAME} PRIVATE ${dl})

# PhysX does not have a find_package setup therefore we have to find it manually
set(_VCPKG_INSTALLED_DIR "/opt/app/vcpkg/installed")
set(VCPKG_TARGET_TRIPLET "x64-linux")
include(SelectLibraryConfigurations)

include_directories("${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include")

find_library(PhysXPvdSDK_LIBRARY_RELEASE NAMES PhysXPvdSDK_64 PhysXPvdSDK_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" NO_DEFAULT_PATH REQUIRED)
find_library(PhysXPvdSDK_LIBRARY_DEBUG NAMES PhysXPvdSDK_64 PhysXPvdSDK_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug" NO_DEFAULT_PATH REQUIRED)
select_library_configurations(PhysXPvdSDK)

find_library(PhysXExtensions_LIBRARY_RELEASE NAMES PhysXExtensions_64 PhysXExtensions_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" NO_DEFAULT_PATH REQUIRED)
find_library(PhysXExtensions_LIBRARY_DEBUG NAMES PhysXExtensions_64 PhysXExtensions_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug" NO_DEFAULT_PATH REQUIRED)
select_library_configurations(PhysXExtensions)

find_library(PhysXFoundation_LIBRARY_RELEASE NAMES PhysXFoundation_64 PhysXFoundation_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" NO_DEFAULT_PATH REQUIRED)
find_library(PhysXFoundation_LIBRARY_DEBUG NAMES PhysXFoundation_64 PhysXFoundation_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug" NO_DEFAULT_PATH REQUIRED)
select_library_configurations(PhysXFoundation)

find_library(PhysXCommon_LIBRARY_RELEASE NAMES PhysXCommon_64 PhysXCommon_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" NO_DEFAULT_PATH REQUIRED)
find_library(PhysXCommon_LIBRARY_DEBUG NAMES PhysXCommon_64 PhysXCommon_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug" NO_DEFAULT_PATH REQUIRED)
select_library_configurations(PhysXCommon)

find_library(PhysX_LIBRARY_RELEASE NAMES PhysX_64 PhysX_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" NO_DEFAULT_PATH REQUIRED)
find_library(PhysX_LIBRARY_DEBUG NAMES PhysX_64 PhysX_static_64 PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug" NO_DEFAULT_PATH REQUIRED)
select_library_configurations(PhysX)

if(WIN32 OR APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE ${PhysXPvdSDK_LIBRARY} ${PhysXExtensions_LIBRARY} ${PhysXFoundation_LIBRARY} ${PhysXCommon_LIBRARY} ${PhysX_LIBRARY})
else()
    target_link_libraries(${PROJECT_NAME} PRIVATE -Wl,--start-group ${PhysXPvdSDK_LIBRARY} ${PhysXExtensions_LIBRARY} ${PhysXFoundation_LIBRARY} ${PhysXCommon_LIBRARY} ${PhysX_LIBRARY} -Wl,--end-group)
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_EXTENSIONS OFF)

install (TARGETS ${PROJECT_NAME} DESTINATION bin)

