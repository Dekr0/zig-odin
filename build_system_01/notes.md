## Resources

- For up to date Zig build system, check Zig official documentation. This comes 
in handy when tutorial that is use a version Zig that is behind the master.

## How Zig Source Code Is Built?

- In the simplest form, Zig source code is compiled into binary instruction 
using a Zig compiler.
- The compilation (build) process in Zig contains three components:
    - Zig modules that contains source code;
    - Library files (dynamic / static);
    - Compiler flags that tailors the build process to specific needs.
- There's no header file as a component like C and C++ since `@import` and Zig 
compiler cover this. This enter into the scene when linking C code / C library.
- Build process is orignated and described by a build script.
- For most cases, Zig will look for a Zig file called `build.zig` at the root of 
a project.
- Build script is normally organized around **target project**.
- A **target** is simply something to be built, or in other words, something Zig 
compiler need to build.
- There are four types of target objects:
    - An executable.
    - A shared library (`.so` or `.dll`).
    - A static library (`.a` or `.libe`).
    - An executable file that executes only unit tests.

## `build()` function

- This function will create a **directed acyclic graph** of `std.build.Step` 
**nodes**. Each `STEP` will then execute a part of a build process.
- Each `Step` has a set of dependencies that need to be made **before** the step 
itself is made.
- A specific *named* stesp can be invoked by calling `zig build <step-name>`.
    - `install` is one of the predefined steps.
- A `Step` can be created using `std.Build.step("<step-name>", 
"<step-description>");`.
