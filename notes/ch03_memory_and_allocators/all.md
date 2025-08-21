## Memory Spaces

- As a refresher, ther are three type of (physical?) memory spaces:
    - Global data section;
    - Stack;
    - Heap;

## Compile Time Known Vs. Runtime Known

- **One** strategy that Zig decides the stored location of a piece of data is 
via investigating if that piece of data is known at compile-time or at runtime.
- Some piece of data are known at compile time. Zig compiler can determine the 
exact value of that piece of data or the exact size / length of that piece of 
data. The latter one is more important because that determines whether if it's 
known at compile time since the exact value does not really necessary but 
knowing it can make the process more clear.
- Therefore, if the **value** of a piece of data is known at compile time, then, Zig 
compile automatically knows the size / length. Otherwise, this piece of data is 
knonw at compile time if and only if its size / length is **fixed**.
- Any type, or any struct declaration, that includes a data member without an 
explicit fixed size, make this type a type that does not have a known fixed size 
at compile time.

## Global Data Section

- Global data section stores the following data:
    - literal value, for example, `"this is a string"`, `10`, `true`
