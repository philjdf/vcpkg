include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "Abseil currently only supports being built for desktop")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO abseil/abseil-cpp
    REF be1e84b988fceabcea4fc9e93f899539f0c81901
    SHA512 555fe5c5c2d1cb0bfaf357421617372cb3f92e6d8b5b103b40554a03f1424a004aec949fdefe834250286bbe6a9d4294abf8a3f71fe2594fc803b67b6eff63aa
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/unofficial-abseil TARGET_PATH share/unofficial-abseil)

file(GLOB_RECURSE HEADERS ${CURRENT_PACKAGES_DIR}/include/*)
foreach(FILE ${HEADERS})
    file(READ "${FILE}" _contents)
    string(REPLACE "std::min(" "(std::min)(" _contents "${_contents}")
    string(REPLACE "std::max(" "(std::max)(" _contents "${_contents}")
    file(WRITE "${FILE}" "${_contents}")
endforeach()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/abseil RENAME copyright)
