# VCPKG Ports for GTlab and module development

This repository contains are private vcpkg ports to simplify module developement,
even without devtools available.

The following sections decribe, how to create a new port for this registry.
For in-detail information, please read https://learn.microsoft.com/en-us/vcpkg/produce/publish-to-a-git-registry.

## 1. Create the code for the new port

First, create an empty directory `ports/<portname>`. 

Every port needs 3 files:
 - `vcpkg.json`: Contains metadata (version, name ...) and build dependencies
 - `portfile.cmake`: The build steps to  build the package. It typically contains steps to download the source,
                    configure, compile, install and fixup the build.
- optional `usage`: Contains instruction how to consume this package from cmake.

These need to be implemented in the newly generated directory.

As an example, see the port genh5, which also contains steps to patch the source code.

## 2. Test the port build

From the root directory, run

```
vcpkg install <portname> --overlay-ports=ports
```

This will first get and compile all dependencies and finally compile the port _portname_.

In case of an error, adapt the port files, and test again until it compiles and no warnings occur.

## 3. Register port to the registry

The following steps require some git magic and need to be executed in the correct order!

- 1. Fix potential formatting errors of the `vcpkg.cmake` file

     `vcpkg format-manifest ports/<portname>/vcpkg.json`

- 2. Create a commit with the new port
     
     `git add ports/<portname>/* && git commit`

- 3. Add the port to the registry

     `vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version --all --verbose`

     This will create a new version file `versions/?-/<portname>.json` and updates `baseline.json`

- 4. It is recommended to update the previous commit with the new registered version entries. 
     To do so, add the new file and __amend the git commit !__

     ```
     git add baseline.json versions/<path>-/<portname>.json
     git commit --amend
     ```

> **_NOTE:_**  Step 3 and 4 are crucial and must be executed such that vcpkg knows the port and its versions!



