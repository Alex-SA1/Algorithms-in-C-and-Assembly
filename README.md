<h2 style="text-align: center">
Algorithms in C + Assembly 
</h2>
> **Motivation:** I made this repository to understand better multi-module programming with a module written in a high level programming language (C) and another module written in a low level programming language (Assembly) and also, to practice problem solving in assembly.

---

<h3 style="text-align: center">
Multi-module Programming (C + Assembly)
</h3>
When writing a multi-module program using more than one programming language you have to take in consideration some compatibility aspects. In the following part of the article I will talk about the theory behind a fully-working program which has at least two modules among which some are written in C (a high level programming language) and others in Assembly (a low level programming language) using nasm (assembler and disassembler for the Intel x86 architecture) on 32 bits.

**Calling Convetion**

The steps for a calling convetion are taken in consideration automatically by compiler when working with high level languages, but when we want to implement a function in a low level language (ex. Assembly) and call it, for example, from a high level language, we have to pay attention to the calling convetion that we are working with because there are some specific steps to follow .

When we write a function in Assembly and call it from a C program , we have to implement manually some steps so that, after linking all modules, the program works perfectly fine.

The default calling convetion for C programs is CDECL and the main features for this convetion are:

- function arguments are passed by pushing them on the stack from right to left
  example:
  for the following function

```c
void function(int a, int b, int c);
```

the parameters will be pushed to the stack in the following order (we assume that "push x" puts the element x at the top of the stack):

```c
push c
push b
push a
```

or for the function

```c
printf("%d", a)
```

```c
push a
push "%d"
```

- the caller (module that calls a function) is responsible for cleaning the stack after the function is completely executed (ex: If the C program calls a function implemented in an Assembly module, the C module is the one that has to clean the stack, to pop the arguments from the stack. In this case, this step is did automatically by the compiler and the programmer has to do nothing.)
- the assembly function name has to start with the underscore character ( \_ ) when is called from a C program
- if the assembly function returns integer values or memory addresses, it have to be put into the **eax** register
- registers **eax, ecx, edx** are saved by the caller and he is responsible for restoring the values, if they are modified while executing the callee function
- all other registers are saved by the callee (their value at the end of the callee function have to be same with their value from the beginning of the callee function)
