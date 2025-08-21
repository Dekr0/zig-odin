## Declaration: `const` and `var`

- The specific type of `const` can be inferred (compe-time type?).
- Type must be specified when declaration use `var`.

## No Such a Thing is Unused, Variable Must Be Mutate

- When a declaration is made, it's must be used.
- It can be discarded using `_`. However, it cannot be used anymore after it's 
discarded.
```zig
const a = 15;
_ = a;

// This will result a compilation error.
var b = a;
```
- When a variable is declared, it must be mutated in some way of form within a 
block / scope.
- Otherwise, zig compiler will suggest to use `const` instead.

## Fixed Size Array

- Use `_` to let compiler to determine the size of an array.

## Creating Slice Using Array Selection

- Slice is essentially a pointer to specific location of an array with an 
additional field with type `usize` to keep track of count.
- Notice that slice is not a fixed size array. So, operation `**` and `++` does 
not work on slice and fixed array together.
- Some slices are compile time based, and some other slices are runtime based.
- Slice is type of `*[usize]T` where fixed size array is type of `[usize]T`?
- Whether if a slice created using array selection is mutable depends on whether 
if the targeting array is mutable.

## String

- Zig string is C-string but take a modern and safe approach to manage and use 
strings.
- A zig string is essentially an array of `u8` values. Since zig string is an 
array, length of a string can be easily obtained.
- Zig assume all strings are UTF-8 encoded.

## Accessing Data of String

- There are two ways:
    - sentienl-terminated array (type of `*const [n:0]u8`)
    - a slices of `u8` values

### Sentinel Terminated Array

- It's a normal array with a "sentinel value" at the last index / element of the 
array.
- Since it's a normal array, it has field to keep track of its length.
- `*const [n:0]T` where `n` indicates length of a array, and `0` is the 
eqivalent `NULL` in C.
- A string literal usually takes the form of sentinel terminated array, which is
a pointer to a null-terminated array of bytes but with the length of the string.

### Slice

```zig
const str: []const u8 = "A string value";
try stdout.print("{any}\n", .{@TypeOf(str)}); // []const u8
```
- Can one use similiar experession for other type?
- What's difference between slices using `[..]` and this form of declaration 
statmenet?

## A Better Look @ the Object Type

- What's difference between declare slice using `[..]` and using `&`.
```zig
const simple_array = [_]i32{1, 2, 3, 4};
const simple_array_slices = simple_array[0..];

std.debug.print("{} {}", .{@TypeOf(&simple_array), @TypeOf(simple_array_slices});
```
- How can one obtain type of `[..]` using `&`?
