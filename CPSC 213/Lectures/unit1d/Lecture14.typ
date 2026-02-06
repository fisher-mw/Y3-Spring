
//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "14"
#let topic = "Control flow"
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

*Explicit free advantages*
- In Java, JVM is constantly running keeping track of memory allocation/deallocation, in C the onous is on the programmer, but we dont have the background task that expends compute.
- Reference counting: mitigates dangling-pointers
- Should we ignore deallocation in Java programs?
  - Memory leaks can still occur
  - When garbage collector fails to reclaim unneeded objects
  - its a signigicant problem for long-running programs where garbage accumulates
  - Java only reclaims unreachable objects

 *Prologue*
- Explain the role of the program counter register for normal execution and for branch execution
 Linear execution: At any moment, the CPU executes exactly one instruction. _Note:_ linear in time, non-sequential in memory

 *Loops*
- We can use pointers to step through memory, consider:
 ```
 int s = 0;
 int *p;
 int a[] = {...}

void foo() {
  p = a; # set p to the base of a
  while (p < a + 10) { # comparing addresses
    s+= *p++; # s = *p + s, then increment address of p
  }
}
 ``` 
 note:
  ```
  s+= *p++ is the same as
  s+=*p;
  p++;
  ```
  