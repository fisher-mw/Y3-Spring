//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "5"
#let topic = "Static Scalars and Arrays"
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

*Prologue: How does a simple computer acgtually execute arithmetic on variables stored in memory?*

_Note from last class:_ In Java, 0x8b is an int because all integer literals are int by default, it is never a byte unless you caste it to a byte (byte) 0x8b. This means it will have leading zero's unless explciityly caste. Also everything is signed in Java. When we have a byte caste to an int, we promote by looking at the leading bit and padding to the left (either 1 or 0). 
1. Understand the literal 0x8b
2. Apply existing casting (byte)
3. Java promotes the byte to an int before <<
4. Apply the left shift << 16 (if we were to shift $>=$ 32 (greater than an int), we would shift all the 1 bits out and be left with 0) \
*Making Use of Bit Operations (Zero Extension)*
- How can we get zero-extension instead of sign-extension in Java?
- _Answer_ use bit operations (int i = b & 0xFF), means clear the first 3 bytes, and perseve the last bit 
- Note: The result is different, since we sign extended (-6) and then cleared, we have a leading 0 and therefore a positive number. In this case if byte b = -6, it gets converted to 250.
_Example: if we want to mask 0x34567845, and we want to perserve 56, then & 0x00FF0000 will get us 0x00560000_ $->$ could also use 0xFF0000 since Java will add the leading zero's

*Moral:* At the machine level, what does C = A + B look like? \
- *Develop a model of computation:* reflect what the machine actually does when a program runs, by examining C, bit-by-bit (compare to Java as we go)
- *The processor:* design a simple instruction set, based on what we need to compute C programs, similar to real instruction set (MIPS)
- *The language:* we will act as compiler to translate C into machine language, bit by bit, put the bits together, edit, run, debug
Recap (121): CPUs execute insturctions, not C or Java. Execution proceeds in stages: 
- Fetch: load next instruction from memory
- Decode: figure out from the instruction what needs to be done
- Execute: do what the instruction specifies
CPU insturctions are usually very simple:
- Read (load) a value from memory
- Write (store) a value to memory
- Add/subtract/AND/OR/etc.
- Shift a number
- Control flow (unit 1d)
- and so on...
Some of these steps will be executed by an ALU (Arithmetic Logic Unit) \
*Static vs. Dynamic Computation* \
- Execution
  - Parameterized by input values unknown at complilation
  - Producing output values that are unknownable at complilation
- Things that are determined by compuler are called _static_ 
- Things that are determined during executoion are called _dynamic_
_Question_: "Is this determined at compile time or during execution?" \
*The Processor (CPU)* \
- Implements a set of insturctions- Each instruction is implemented using logic gates
  - Built from transitors
- Instructions design philosophies:
  - RISC: fewer and simple instructions make processor design simpler
  - CISC: having more types of unstructions (and more complex instructions) allows for shorter/simpler program code and simpler compilers
- RISC/CISC are NOT about speed, it is about the interface you give the user (the person who is creating the compiler), for CISC its easier for the programmer to design a compiler (they do not have to build multiplication out of addition for instance)
*First Proposed Instruction: ADD*
- Say we propose and instruction that does: $C := A + B$
  - Where A, B and C are stored in memory
- Instruction parameters: addresses of A, B, C
  - Each address is 32-bits
- Instruction is encoded as set of bits (stored in memory),
  - Operation name (e.g. add)
  - Address for A,B,C
_Example:_ 01 0011 0101 0011 1100 (where the leading 01 denotes the operation (e.g., add)) \
*Problems with Memory Access* \
- Accessing memory is slow
  - ~100 CPU cycles for every memory access
  - Fast programs avoid accessing memory when possible
- Big instructions are costly
  - Memory addresses are big (so instructions using them are big)
  - Big instructions lead to big programs
  - Reading instructions from memory is slow 
  - Large instructions use more CPU resources
* General Purpose Registers*
- Register file 
  - Small, fast memory stored in CPU itself
  - Roughly single cycle access
- Registers
  - Each register named by a number (e.g., 0-7)
  - Size: architecture's common integer (32 or 64 bits)
*Instructions Using Registers* \
Modifies our ADD instruction design:
- Memory instructions hangle ONLY memory 
 - Load data from memory into register
  - Store data from register into memory (slow)
- Other instructions access data in Registers
  - Small and fast
ADD MUST access data in registers, it DOES NOT go into memory, instead it targets the location in a register where the data is stored and possibly a destination. A better design would be to store the result in A (i.e. C = A + B) \
*Moral:* 01 0 1 2 $->$ 01 is the operation, 0 is the value in register 0, 1 is the value in register 1, 2 is where we store the value.
