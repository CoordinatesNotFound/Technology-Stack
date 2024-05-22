# Web Assembly

> [WebAssembly | MDN](https://developer.mozilla.org/en-US/docs/WebAssembly)





## 0 Background: The Interactive Web

- Web's Origin

  - 1989, Berners-Lee invented Web

- Pursuit for Interactivity

  - Early web: 'book-like', using HTTP, limiting interactivity
  - 1995, Javascript invented
  - 1996, plugins (e.g. Flash, Java Applets), utilizing proprietary technology via an extensibility API to render interactive elements within a static web, needed to be installed by users
  - 2000, smart phones and tablets arrived, plugins failed to function well on mobile devices

- Limits of Javascript

  - Requires an interpreter to translate a file before the code runs
    - When a modern browser receives JavaScript code in the original text form, the ECMAScript engine’s Just-In-Time (JIT) compiler compiles the code into bytecode as the interpreter translates and implements the code.
    - JIT compilers improve performance and efficiency compared to only using an interpreter. This compilation happens during run time as opposed to ahead of time (AOT).
  - Although optimizations such as JIT compilers aid in JavaScript’s impressive execution speeds, the process of code execution is complex. Therefore, even though optimizations can be implemented, Javascript suffers in execution speed and performance predictability compared to compiled languages.

  - JavaScript lacked the ability to advance browsers with features such as low-level networking, multithreaded code, graphics, and streaming video codecs. This limitation affected applications where performance is critical, such as video editing, CAD, and AI.

- Improvement

  - Javascript diversified with UI framework (e.g. React, Angular) and backend capability (e.g. Node.js)

  - Javascript execution engines streamlined to reach near native speeds

  - HTML5 targeted capabilities toward app-like experiences in browsers without the need for plugins.

    > The only way to bring a new language to the web is for the language to be compiled into JavaScript. While many languages target JavaScript, no matter how technically advanced the compilers are, all suffer because JavaScript was never designed to be a compilation target.

- The asm.js Project

  - Introuction: Mozilla introduced asm.js in 2013 to approach how runtime performance could be improved by optimizing JavaScript ahead-of-time (AOT).
    - To review, as a high-level and interpreted language, JavaScript code must be loaded into the browser. Then, JIT compilers form the code into bytecode as the interpreter simultaneously translates and executes the code. Optimization of JavaScript occurs while the code executes.
    - The asm.js project developed a way to optimize some of the JavaScript code before loading into the browser, which results in a more efficient execution.
    - asm.js requires another Mozilla project, Emscripten, to function. Emscripten converts C or C++ code into bytecode through an LLVM, which in turn compiles to asm.js before running in a JavaScript engine. This process allowed code to render in browsers with near native performance.
  - asm.js Compilation Process
    - asm.js remains JavaScript code, but is a strict subset with different rules to increase efficiency. 
    - Asm.js only allows number type data structures and does not support other types, such as string or boolean. The code stores and references all data from a heap, which replaces global variables and other data structures, removing the need for garbage collection or dynamic types.
  - While the asm.js project successfully proved how JavaScript could be used as a compilation target and how to enhance JavaScript’s performance AOT, asm.js served as a proof of concept and has been deprecated.





## 1 Introducing Web Assembly



### 1.1 Definition of Web Assembly

- Web Assembly
  - WebAssembly is an instruction-set architecture with low-level bytecode that runs on web browsers. 
  - WebAssembly serves as a compilation target for higher-level languages including C++, Rust, C, and Go. 



### 1.2 Design Goals of Web Assembly

- Design Goals
  - Be fast, efficient, and portable — WebAssembly code can be executed at near-native speed across different platforms by taking advantage of [common hardware capabilities](https://webassembly.org/docs/portability/#assumptions-for-efficient-execution).
  - Be readable and debuggable — WebAssembly is a low-level assembly language, but it does have a human-readable text format (the specification for which is still being finalized) that allows code to be written, viewed, and debugged by hand.
  - Keep secure — WebAssembly is specified to be run in a safe, sandboxed execution environment. Like other web code, it will enforce the browser's same-origin and permissions policies.
  - Don't break the web — WebAssembly is designed so that it plays nicely with other web technologies and maintains backwards compatibility.



### 1.3 Key Concepts of Web Assembly

- Module
  - Represents a WebAssembly binary that has been compiled by the browser into executable machine code. A Module is stateless and thus, like a Blob, can be explicitly shared between windows and workers (via postMessage()). A Module declares imports and exports just like an ES module.
- Memory
  - A resizable ArrayBuffer that contains the linear array of bytes read and written by WebAssembly's low-level memory access instructions.
- Table
  - A resizable typed array of references (e.g. to functions) that could not otherwise be stored as raw bytes in Memory (for safety and portability reasons).
- Instance
  - A Module paired with all the state it uses at runtime including a Memory, Table, and set of imported values. An Instance is like an ES module that has been loaded into a particular global with a particular set of imports.





## 2 Language-Specific Toolchains



### 2.1 C/C++ with Emscripten

[Compiling a New C/C++ Module to WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly/C_to_Wasm)



### 2.2 Rust

[Compiling from Rust to WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly/Rust_to_Wasm)



### 2.3 AssemblyScript
- AssemblyScript 

  - acts as a stricter variant of TypeScript which compiles to WebAssembly. TypeScript is a popular superset of JavaScript that adds optional static typing.

  - Advantages
    - The advantages of WebAssembly, such as predictable performance, security, and small payload, are desirable to JavaScript and TypeScript developers.
    - In common with Rust and C++, AssemblyScript is built on the LLVM toolchain, using the Binaryen tooling that was developed alongside Emscripten. The AssemblyScript runtime performs garbage collection through reference counting. It also provides a JavaScript-like standard library, which includes strings, arrays, and a (limited) date API.

  - AssemblyScript is a nascent language, with current users considered early adopters. Despite being such a young technology, there are already a number of interesting applications ‘in the wild’.



