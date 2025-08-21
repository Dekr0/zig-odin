const std = @import("std");

pub fn main() !void {
    const out = std.io.getStdOut().writer();
    try out.print("Running Wwise Teller...\n", .{});
    try out.print("Exited Wwise Teller\n", .{});
}

test "fake unit test"
{
    std.debug.print("Running fake unit test...", .{});
    try std.testing.expect(true);
}
