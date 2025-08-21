const std = @import("std");

pub fn build(b: *std.Build) void
{
    // Define a module
    // The name of a module can be different from the name of a package as a 
    // whole.
    // Build.addModule returns a pointer to a module, which can be discarded.
    // However, this module itself still exist. It also has been registered in 
    // the graph. 
    // Consumer will still be able to access this module via its name even that 
    // pointer is discarded.
    _ = b.addModule("unwise", .{
        .root_source_file = b.path("src/root.zig")
    });

    // Define an executable
    // Let says this package not
}
