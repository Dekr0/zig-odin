## Reader and Writer Pattern

- Every IO operation in Zig is made through either a `GenericReader` or a `
GenericWriter`.
- These two data types come from the `std.io` module of the Zig standard library.
- `GenericReader` offer tools to read data from an external source.
- `GenericWriter` offer tools to write data to an external source.
- Usually, these instances of these two data types are created from a file 
file descriptor. More specifically, through the `writer()` and `reader()` 
methods of a file descriptor.
- Some common methods about `GenericReader` and `GenericWriter` (For complete 
documentation, read `Reader.zig` and `Writer.Zig` in the standard library).
    - `GenericReader`
        - `readAll()` read data from an external source until it fills a 
        particular array (i.e., a buffer).
        - `readAtLeast()` attempt to read at least `n` bytes of data from an 
        external source. That external source might have less than `n` bytes. 
        Thus, it's not guaranteed that the result will be precisely `n` bytes.
        - `readUnitlDelimiterOrEof()` attempt to read as many bytes of data as 
        possible from an external source until it reaches `EOF`, or it reaches 
        a specified delimiter.
        - `readAllAlloc` try to read all bytes from an external source. If it 
        run out of space at some point during the reading process, it uses the 
        provided allocator to allocate more space so that it can continue to 
        read the remain bytes. This methods return a slice to an array that 
        containing all the bytes read.

## File Descriptor

- The equivalent of `FILE` type in C is `File` type in Zig. The type definition 
is in `std.fs` of the Zig library.

## The Standard Output

- To obtain access of `stdout`, `getStdOut()` function from the `std.io` module 
is required.
