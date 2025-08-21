const std = @import("std");

pub fn parseWwiseSoundBank(path: []const u8) !void
{
    const stdout = std.io.getStdOut().writer();
    stdout.print("Parsing wwise sound bank {s}...\n", .{ path }) catch {};
    stdout.print("Wwise sound bank parser is yet to be implemented");
    stdout.print("Parsed wwise sound bank {s}\n", .{ path }) catch {};
}
