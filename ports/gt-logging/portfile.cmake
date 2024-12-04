string(REPLACE "." "-" DASHED_VERSION "${VERSION}")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dlr-gtlab/gt-logging
    REF "${DASHED_VERSION}"
    SHA512 a4d231b9fb1ee1b67d22ec2bda5f302a968feafcac4ef00a3fc18182a37d75f8b27e05636e65a9c350a6c07218aebce8384cd568b7fa151b7035c527d7bf14a8  # This is a temporary value. We will modify this value in the next section.
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DCMAKE_INSTALL_BINDIR="bin"
)

vcpkg_cmake_install()


vcpkg_cmake_config_fixup(PACKAGE_NAME "GTlabLogging" CONFIG_PATH "lib/cmake/GTlabLogging")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/include/logging/cmake")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/README.md")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)