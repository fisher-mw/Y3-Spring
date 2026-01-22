//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "7"
#let topic = "Static vs Dynamic "
#let date = datetime.today().display()

// Page setup
#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
  numbering: "1",
)

#set text(
  font: "New Computer Modern",
  size: 12pt,
)

#set par(
  justify: true,
  leading: 0.65em,
)

// Heading styles
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => block(
  above: 1.5em,
  below: 1em,
  text(size: 16pt, weight: "bold", it.body),
)

// Theorem-like environments
#let theorem(title: none, body) = block(
  width: 100%,
  inset: 10pt,
  radius: 4pt,
  fill: rgb("#e8f4f8"),
  stroke: rgb("#0077be") + 1pt,
)[
  #text(weight: "bold", fill: rgb("#0077be"))[
    Theorem#if title != none [ (#title)]
  ]
  #body
]

#let definition(title: none, body) = block(
  width: 100%,
  inset: 10pt,
  radius: 4pt,
  fill: rgb("#f0f8e8"),
  stroke: rgb("#4a7c2e") + 1pt,
)[
  #text(weight: "bold", fill: rgb("#4a7c2e"))[
    Definition#if title != none [ (#title)]
  ]
  #body
]

#let example(body) = block(
  width: 100%,
  inset: 10pt,
  radius: 4pt,
  fill: rgb("#fff8e8"),
  stroke: rgb("#d4a520") + 1pt,
)[
  #text(weight: "bold", fill: rgb("#d4a520"))[Example]
  #body
]

#let note(body) = block(
  width: 100%,
  inset: 10pt,
  radius: 4pt,
  fill: rgb("#f8f8f8"),
  stroke: rgb("#666666") + 1pt,
)[
  #text(weight: "bold")[Note: ]#body
]

// Title
#align(center)[
  #text(size: 18pt, weight: "bold")[#course]

  #text(size: 14pt)[Lecture #lecture_num: #topic]

  #text(size: 10pt, style: "italic")[#date]

  #line(length: 100%, stroke: 0.5pt)
]

#v(1em)

#let ip(..args) = $lr(angle.l #args.pos().join($,$) angle.r, size: #50%)$

#let cvec(..args) = $mat(delim: "[", align: #right, #args.pos().join($ ; $))$

// #let matright(..aa) = math.mat(delim: "(", ..aa
//   .pos()
//   .map(row => row.map(y => {
//     y
//     [$&$]
//   })))

#let matright(..aa) = math.mat(
  ..aa
    .pos()
    .map(row => row.map(y => {
      y
      v(8mm)
    })),
)

// ============================================================
// Your notes start here
// ============================================================

_Variables may be static at compile time, but changed during runtime by user input_
- In Java
  - static data members are allocated to a class, not an object
  - they can store built-in scalar types or references to arrays/objects
- In C
  - global variables and any other variable declared static
  - they can be static scalars, arrays or structs, or pointers
Complier knows the memory address of _every_ static variable
*Static Variable Allocation*
- Allocation is assigning a memory location (address) to a variable
  - When: at compile time before the program starts running
  - How: the compiler chooses a fixed address. That address is embedded in the generated machine code.
example: int a; $<-$ assign memory location to a, a = 0; $<-$ store 0 at assigned memory location for a (no variables in machine code, just memory locations (variable names are an abstraction)) \
*Satic Variable Access*
- No memory allocation is done at runtime, speeds up execution as all the memory is accounted.
- Loads and stores are done at runtime (with fixed compiler-chose addresses)
- Static variables exist before execution begins, address are constants know to the compiler
*Static Array Access -- What is Dynamic?*
- The base address of the array is known at compile time
- The size of each element is known at compile time
- The index value that we care about is known at runtime 
  - In our simple model, we want to do one memory access per Instruction
  - Multiply the index by the size of the data type and add it to the base memory address (base + offset) $->$ offset is dependent on index, determined at runtime
_example_: b[a] = a; \
r[1] $<-$ 0x1000 \//address of $a$ \
r[2] $<-$ m[r[1]] \
r[3] $<-$ 0x2000 \// base address of $b$ \ 
m[r[3]+r[2] $times$ 4] $<-$ r[2] \// compute offset
\ *Load and store instructions* \
- Immediate: opperand value obtained from instruction itself
- Register operand is register value; register stores operand value
- Base + offset: operands are register number and optional offset; register stores memory address (via offset) of value; offset o=px4
- Indexed: operands are two register numbers; registers store base address and index of value

