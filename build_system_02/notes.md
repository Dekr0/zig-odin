## Build Graph

- The source code in `build.zig` will describe a **build graph**, instead of 
performing the build immediately.
- The types and functions in `std.build` can be viewed as constructs of DSL for 
defining a build graph.

## Zig Package

- A Zig package can expose to consumers.
- In a Zig package, it can contains the following:
    - Zig Module
    - Static Libraries
    - Dynamic Libraries
    - Object Files
    - Full Executables
    - Source Files (Zig, C, C++, etc.)
    - Generated File during build time

## `build.zig.zon`

- This file type is the equivalent to `package.json` in Node or pyproject.toml in 
Python, or `go.mod` in Go, etc.
- It's a data structure that declares the package name and some other metadata, 
including dependencies in a project.
- In this file, files, that make up a project, must be listed in there. Any files 
that are not listed will be deleted after the package is downloaded as an 
dependencies.
