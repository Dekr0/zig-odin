# Chapter 1

## `zig init`

- `zig init` will create the following files:
    - `src` directory with two files, `main.zig` and `root.zig`.
        - Each `.zig` file is a separate Zig module.
        - In Zig, a build system is embedded inside the lanage itself.

### Entry Point for Application and Library

- By convention, `main.zig` module is where a main function, which is the 
entrypoint of a program lives. `main()` function is mandatory to build an 
executable program in Zig.
- For library, by convention, `root.zig` is the root source file of a library.

### Build System

- `build.zig` represents a build script written in Zig, and it will be executed 
when calling `zig build`.

### Dependency System

- `build.zig.zon` is a JSON-like file. It describes a project, and also, declare 
a set of dependencies of a project that it want to fetch from the internet.
- There are two ways of include an external Zig library:
    - manually build and install the library in OS, and link that library at the 
    build step of a project, or
    - no additional step is required if an external Zig library is available 
    on known Git repository hosting platform.

## First Look of Syntax

### `!` on Function

- `!` indicate a function might return an error.
```zig
pub fn main() !void {

}
```
- When writing a function that might return an error, then, one is forced to:
    - either add `!` to the return type of this function and make it clear that 
    this function might return an error, or
    - explicitly handle this error inside this function.

### `try`

- `try` in Zig work differently in a traditional sense.
- When `try` executes an expression that might return error, and if this 
expression returns a valid value, `try` will do nothing.
- When `try` executes an expression that might return error, and if this 
expression returns an error, `try` will unwrap the error value, then it returns 
this error from the function and also prints the current stack trace to `stderr`.

