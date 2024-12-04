string(REPLACE "." "-" DASHED_VERSION "${VERSION}")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dlr-gtlab/genh5
    REF "${DASHED_VERSION}"
    SHA512 573c0a9c68f1a2e6de1a39232802f692dc00757cf101fa35addae70d088f711a5138d1d912e2b71313d08278ff83eb8c6f6db300ca582ba5ac214a0d723baee0  # This is a temporary value. We will modify this value in the next section.
    HEAD_REF master
    PATCHES fix-hdf5version.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DCMAKE_INSTALL_BINDIR="bin"
)

vcpkg_cmake_install()


vcpkg_cmake_config_fixup(PACKAGE_NAME "GenH5" CONFIG_PATH "lib/cmake/GenH5")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/README.md")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)