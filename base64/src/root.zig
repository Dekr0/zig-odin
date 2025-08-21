// Base64
// Encoding (three bytes window):
// 1. Group three bytes (24 bits) into four groups of 6 bits.
// 2. For each 6 bits in a group, use this 6 bits to index a character from 
// the base64 scale.
// 3. If there are less than three bytes in the window, pad the remaining 
// missing bits with 0. If there are padding that can form a group of 6 bits, 
// use character `=` (padding group) instead of indexing from the base64 scale.
// Example:
// E1. a = 0110_0001
//     1. Initial grouping | 011000 | 01 |
//     2. Padding | 011000 | 01xxxx | xxxxxx | xxxxxx |
//     3. Indexing | Y | Q | = | = |
//     4. YQ==
// E2. bd = 0110_0010_0110_0100
//     1. Initial grouping | 011000 | 100110 | 0100 |
//     2. Padding | 011000 | 100110 | 0100xx | xxxxxx |
//     3. Indexing | Y | m | Q | = |
//     4. YmQ= 
// E3. hpz = 0110_1000_0111_0000_0111_1010
//     1. Initial grouping | 011010 | 000111 | 000001 | 111010
//     2. Indexing | a | H | B | 6 |
//     3. aHB6
// Decoding:
// 1. For each byte, zero out its two most significant bits, and use both its six 
// bits value and two most significant bits of next byte to create a decode byte.
// 2. If the next byte is `=`, the decoding process is complete.
const std = @import("std");

const Base64Table = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" ++ 
                    "abcdefghijklmnopqrstuvwxyz" ++ 
                    "0123456789+/";

const Base64Error = error
{
    InputLengthTooSmall,
    OutOfRange,
};

fn charAt(i: usize) Base64Error!u8
{
    if (i >= Base64Table.len)
    {
        return Base64Error.OutOfRange;
    }
    return Base64Table[i];
}

pub fn encodeSize(s: []const u8) !usize
{
    if (s.len < 3)
    {
        return 4;
    }
    const numGroups: usize = try std.math.divCeil(usize, s.len, 3);
    return numGroups * 4;
}

pub fn decodeSize(s: []const u8) !usize
{
}

test "indexing base64 table (good)"
{
    const char = try charAt(28);
    try std.testing.expect(char == 'c');
}

test "fuzz indexing base64 table"
{
    try std.testing.expectError(Base64Error.OutOfRange, charAt(64));
}

test "get base64 encoding size"
{
    try std.testing.expect(try encodeSize("a") == 4);
    try std.testing.expect(try encodeSize("ab") == 4);
    try std.testing.expect(try encodeSize("abc") == 4);
    try std.testing.expect(try encodeSize("abde") == 8);
}
