include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CaptainCrowbar/rs-core-lib
    REF c8cc47225be74b06de96c1bb51ab908b9af1a59f
    SHA512 a4c765bb4ee20667c758287958e5d867bf3f49a684ccdee9efe79887fc123c6b51aba45dc622beb5004e1b9c57c000e4eed70b1fba4569e0e0d7e7e08f1fbc08
    HEAD_REF master
)

file(INSTALL ${SOURCE_PATH}/rs-core DESTINATION ${CURRENT_PACKAGES_DIR}/include FILES_MATCHING PATTERN "*.hpp")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/rs-core-lib RENAME copyright)