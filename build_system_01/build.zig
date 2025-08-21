const std = @import("std");

pub fn build(b: *std.Build) void
{
    if (b.args) |args| // this should be used for passing argument for run step.
    {
        if (std.mem.eql(u8, args[0], "shortHand")) 
        {
            buildShortHand(b);
        }
        else if (std.mem.eql(u8, args[0], "fineGrain"))
        {
            buildFineGrain(b);
        }
    } 
    else
    {
        buildShortHand(b);
    }
}

fn buildShortHand(b: *std.Build) void
{
    std.debug.print("Running `buildShortHand`...\n", .{});

    // Enable cross compilation instead of hard code compilation
    // The actual value of these two are specified by the following:
    //     `-Dtarget=[string]`
    //     `-Dcpu=[string]`
    //     `-Doptimize=[enum]`
    const target = b.standardTargetOptions(.{});
    std.debug.print("Use target {any}...\n", .{ target.result.os.tag });
    const mode = b.standardOptimizeOption(.{});
    std.debug.print("Use build mode {any}...\n", .{ mode });

    // Create a target object as an executable file.
    const exe = b.addExecutable(.{
        // name of the binary file defined by this target object
        .name = "wwise_teller", 

        // Specify the root Zig module of a project. That is the Zig module 
        // that contains the entrypoint of an application (e.g. `main()`), or 
        // the main API of a library.
        // All Zig modules that compose a project are automatically discovered 
        // from the `@import` inside this `.root_source_file`.
        // 
        // Build.path Relative to the source root
        .root_source_file = b.path("src/main.zig"), 

        // Specify the target computer architecture of this binary file
        // For supported OS, run `zig targets`.
        .target = target, // Old version of zig is `b.host`; Otherwise, `b.graph.host`
        
        // Four build modes:
        // - `Debug`, mode that produces and includes debugging information in 
        // the output of the build process.
        // - `ReleaseSmall`, mode that tries to produce a binary file that is 
        // small in size.
        // - `ReleaseFast`, mode that tries to optimize code, in order to 
        // produce a binary file that is as fast as possible.
        // - `ReleaseSafe`, mode that tries to make code as safe as possible, by 
        // including safeguards when possible.
        .optimize = mode,

        .version = .{
            .major = 0, .minor = 0, .patch = 0
        }
    });
    std.debug.print("Created target object `{s}` as an executable file.\n", .{
        exe.name
    });

    // Explicitly install the target objects created in a build script.
    // Otherwise, they will be discarded at the end of the build process.
    b.installArtifact(exe);
    std.debug.print("Installed artifact target object using `{s}`\n", .{
        exe.name
    });
    std.debug.print("and add it to the dependencies of top level install.\n", .{});

    // The following will tell Zig run the binary file specified by a target 
    // object after build.
    // Create a run artifact using a target object.
    const runArti = b.addRunArtifact(exe);
    std.debug.print("Created run artifact using `{s}`.\n", .{ exe.name });
    // Define a new build step. This will be available when run `zig build --help`
    // or `zig build <step-name>`
    const runStep = b.step("run", "Run the project");
    std.debug.print("Created build step {s}.\n", .{ runStep.name });
    // Specify this build step depends on a run artifact of a target object.
    runStep.dependOn(&runArti.step);
    std.debug.print("Define {s} as a dependency build step `{s}`.\n", .{
        exe.name, runStep.name
    });

    // A test target object will include `test` blocks in all Zig modules across 
    // a project.
    // It builds only the source code present inside these `test` blocks.
    const testExe = b.addTest(.{
        .name = "wwise_teller_unit_tests",
        .root_source_file = b.path("src/main.zig"),
        .target = target
    });
    std.debug.print("Created test target object `{s}\n`", .{ testExe.name });
    b.installArtifact(testExe);
    std.debug.print("Created install step using test target object `{s}`\n", .{
        testExe.name
    });
    std.debug.print("and add its to the dependencies of top level install\n", .{});

    const testArti = b.addRunArtifact(testExe);
    std.debug.print("Created a run artificat using test target object `{s}`\n.", .{
        testExe.name
    });
    const testStep = b.step("test", "Test the project");
    std.debug.print("Created build step {s}.\n", .{ runStep.name });
    testStep.dependOn(&testArti.step);
    std.debug.print("Define {s} as a dependency build step `{s}`.\n", .{
        testExe.name, testStep.name
    });
}

fn buildFineGrain(b: *std.Build) void
{
    std.debug.print("Running `buildFineGrain`...\n", .{});

    const target = b.standardTargetOptions(.{});
    std.debug.print("Use target {any}...\n", .{ target.result.os.tag });
    const mode = b.standardOptimizeOption(.{});
    std.debug.print("Use build mode {any}...\n", .{ mode });
    
    // This create a new `LibExeObjStep` behind the scene?
    const exe = b.addExecutable(.{
        .name = "wwise_teller",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = mode,
        .version = .{
            .major = 0, .minor = 0, .patch = 0
        }
    });

    const compileStep = b.step("compile", "Compile Step");
    std.debug.print("Created compile step.\n", .{});
    compileStep.dependOn(&exe.step);
    std.debug.print("Set {s} as dependency of build step `{s}`.\n", .{
        exe.name, compileStep.name
    });

    // Create a new `InstallArtifactStep` that copies the compilation result of 
    // `exe` (created from `Build.addExecutable`) to `$prefix/bin`
    const installArti = b.addInstallArtifact(exe, .{});
    std.debug.print("Created install step.\n", .{});
    // Ensure `installArti` is called when the top level install step is called
    // (`zig build install`).
    b.getInstallStep().dependOn(&installArti.step);
    std.debug.print(
        \\Set newly created install step as dependecy of top level install step.
    , .{});
    std.debug.print("\n", .{});
}

// Evertime the build process of a project is invoked, by calling `zig build`, 
// a new directory named `zig-out` is created in the root directory of a 
// project.

// Use `zig build --help` to see all possible build steps and other information 
// specified by `build.zig`.
