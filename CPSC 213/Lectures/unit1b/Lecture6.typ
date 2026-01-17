//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "6"
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

_1 register holds 4 bytes, there are 8 registers, at any given time we only have access to 32 bytes of data before we have to fetch again_ \
*Moral:* Data moves, then computation happens \
_Should be able to explain: how a register-based CPU moves data between memory and registers, and how arithmetic on memory values is carried out using simple instructions_
*Special Purpose Registers* \
- A special-purpose register can only be used for certain purposes
    - May not be accessible by all instructions (e.g., cant be used as an argument for an add instruction)
    - May have special meaning or be treated specially by the CPU
- Example: PC(Program Counter) $->$ address of the next instruction to execute, IR (instruction Register): instruction that has just been loaded from memory _load and fetch are possible because of these registers_
*Instruction Set Architecture (ISA) $->$ there is the RISC and CISC*
- ISA is formal interface to a processor implementation
    - defines the instructions the processor implements (add, subtruct, logic operators, memory access, control flow)
    - defines the format of each instruction
- Instruction format   
    - Sequence of bits: opcode and operand values
    - all represented as numbers
- Assembly language (every machine instruction exists in assemby instruction ):
    - Symbolic (textual) representation of machine code
*Representing Instruction Semantics* 
- RTL: simple, convenient pseudo language to describe Semantics
    - easy to read and write
- Syntax
    - each line is of the form LHS $<-$ RHS
    - LHS is memory or register that receives a values- RHS is constant, memory, register or expression on two registers
    - m[a] is memory in address a (m means memory)
    - r[i] is a register with number i (r means register)
- Need to store memory from address a into a register before we can perform any instructions
*Valid Instructions*
- memory reads and writes will always be seperate from arithmetic
    - r[0] $<-$ r[1] + m[r[2]] is not valid for that reason 
- only one memory access per instruction
    - m[r[1]] $<-$ m[r[2]] is not valid for that reason
- cannot store literal value 
    - r[1] $<-$ m[0x1234] would require another instructions that some CISC implementations may support
_Class activity_
- r[0] $arrow.l$ 10 \// register 0 recieves value 10
- r[1] $arrow.l$ 0x1234\// register 1 recieves value 0x1234
- r[2] $arrow.l$ m[r[1]] \// register 2 recieves the value located at 0x1234 in memory
- r[2] $arrow.l$ r[0] + r[2] \// register 2 value gets replaces by value in register 1 + register 2
- m[r[1]] $arrow.l$ r[2] \// load value in register 2 into location stored in register 1 (0x1234) in memory 