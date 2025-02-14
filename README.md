 <h2>
 <p align="center">
  Algorithms in C + Assembly (32-bit)
 </p>
 </h2>
 
> **Motivation:** 
> I made this repository to understand better multi-module programming with a module written in a high level programming language (C) and another module written in a low level programming language (Assembly) and also, to practice problem solving in assembly.

---

<h3>
<p align="center">
Multi-module Programming (C + Assembly) on 32 bits
</p>
</h3>

When writing a multi-module program using more than one programming language you have to take in consideration some compatibility aspects. In the following part of the article I will talk about the theory behind a fully-working program which has at least two modules among which some are written in C (a high level programming language) and others in Assembly (a low level programming language) using nasm (assembler and disassembler for the Intel x86 architecture) on 32 bits.

**Calling Convention**

The steps for a calling convention are taken in consideration automatically by compiler when working with high level languages, but when we want to implement a function in a low level language (ex. Assembly) and call it, for example, from a high level language, we have to pay attention to the calling convention that we are working with because there are some specific steps to follow .

When we write a function in Assembly and call it from a C program , we have to implement manually some steps so that, after linking all modules, the program works perfectly fine.

The default calling convention for C programs is CDECL and the main features for this convention are:

- function arguments are passed by pushing them on the stack from right to left
  example:
  for the following function

```c
void function(int a, int b, int c);
```

the parameters will be pushed on the stack in the following order (we assume that "push x" puts the element x on the top of the stack):

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
- the name of the function implemented in Assembly has to start with the underscore character ( \_ ) when is called from a C program
- if the assembly function returns integer values or memory addresses, these have to be put into the **eax** register
- registers **eax, ecx, edx** are saved by the caller and he is responsible for restoring the values, if they are modified while executing the callee function
- all other registers are saved by the callee (their value at the end of the callee function have to be same with their value from the beginning of the callee function)


**Call Code / Entry Code / Exit Code in C + Assembly multi-module projects**

*Call code* represents first set of steps that have to be realized when a function is implemented in Assembly language and called from a C module. All these steps are automatically  did by the C compiler and the programmer only has to write the function prototype. 

In the following part I will take an example and analyze the steps that are did "behind the scenes" by the C programming language.

*example*
```c
// prototype of the function (wrote by the programmer) 
// function is implemented in Assembly language
void function(int n, int array[]);
```
- saving the volatile resources (registers: eax, ecx, edx)
- assuring that the stack is aligned and ready for adding new elements
- pushing the arguments of the function on the stack according to CDECL convention
- making the function call and saving on the stack the return address (the value of the current instruction - where the program has to return after executing the function instructions) (the current instruction is stored in register eip)

*Entry code* represents the second set of steps that have to be realized when a function is implemented in Assembly language and called from a C module. All these steps are implemented by the programmer in the body of the function.

Steps that have to be realized:
- creating a new **stack frame** for the function
	1. saving on the stack the value of **ebp** register
	1. updating the value of **ebp** with the value of **esp**
- *optional step:* allocating space for local variables (if is needed the space will be allocated by subtracting from esp the number of bytes wanted)
- saving the nevolatile registers

*Exit code* represents the last set of steps that have to be realized when a  function is implemented in Assembly language and called from a C module so that the entire program works fine. These steps are implemented by the programmer in the body of the function.

Steps that have to be realized:
- restoring the values of nevolatile registers
- *if local variables were allocated:* free the space allocated for local variables
- restoration of the stack frame
- going to the return address and eliberating the function arguments from the stack (at this step the programmer only has to use the instruction **ret** which does these actions)



**Run a multi-module (C + Assembly) program**

There are a few ways to assemble / compile and link the modules and in the following part I will present the method that I use.

*Requirements:*
- C compiler (I use gcc compiler from mingw - download link: [https://sourceforge.net/projects/mingw/](https://sourceforge.net/projects/mingw/ "https://sourceforge.net/projects/mingw/"))
- nasm assembler (can be found in the folder asm_tools from this repository: [asm_tools](https://github.com/Alex-SA1/Algorithms-in-C-and-Assembly/tree/main/asm_tools "asm_tools"))

*Steps (bash code):*
-   assemble the file that contains the function implemented in Assembly language

```bash
nasm -f win32  -o path\to\project\folder\module.o path\to\project\folder\module.asm
```

- compile the file that contains the module implemented in C

```bash
gcc -c -o path\to\project\folder\main.o path\to\project\folder\main.c
```

- build the final executable by linking and compiling together all .o files (an .o file is a compiled program object - object file)

```bash
gcc -o path\to\project\folder\program path\to\project\folder\main.o path\to\project\folder\module.o
```

- run the program

```bash
// change directory to the project folder and run the program
program.exe
```



