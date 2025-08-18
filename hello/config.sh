build() {
    # Default
    # Zig compiler will search for a zig module named `build.zig` inside the 
    # current directory, which is a build script of a project.
    # Then, the compiler will essentially execute a `zig run` over this build 
    # script, to compile and execute this build script, which in turn, will 
    # compile and build entire project.
    zig build
    # A `zig-out` is created in the root of project directory.
}

build_exe() {
    # Build binary executable
    # It doesn't work well as projects grow in size and complexity.
    # It fails when zig compiler cannot find a `main()` function delcared in 
    # somewhere, a compilation error will be raised.
    zig build-exe src/main.zig

    # Other Zig build alternate:
    # zig build-lib
    # zig build-obj
    # They produce a portable C ABI libary, or, into object files, respectively.
}

run() {
    zig run src/main.zig
}
