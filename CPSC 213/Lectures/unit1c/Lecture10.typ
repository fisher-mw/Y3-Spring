//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "10"
#let topic = "Instance variables and Dynamic Allocation"
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

_Recap:_
- *What C does that Java doesn't*
  - Static arrays, Array access using pointer dereferencing, pointer arithmetic
- *What Java does that C doesn't*
  - Type-safe dynamic allocation automatic array-bounds checking

*Instance Variables*\ _Question:_ How does the machine support many independent "instances" of data?
- Variables that are an instance of a _class_ or a _struct_
  - Created dynamically (usually)
  - Many instances of the same class/struct can co-exist
- Java vs C 
  - Java: Objects are instances of non-static variables of a class
  - C: structs are named variable groups, or one of their instances
- Accessing an instance variable
  - Requires a reference/pointer to a particular object/struct
  - Then the variable name chooses a variable in that object/struct
*Structs in C*
- A struct is a collection of variables of arbitrary type (no methods)
  - Allocated and accessed together 
  - No private member variables
- Declaration
  - Similar to declaring a Java class without methods
  - static: struct D d0;
  - dynamic: struct D\* d1;
- Access:
  - static: d0.e = d0.f 
  - dynamic: d1->e = d1->f \#dereference d1->f, store it into the place that d1->e lives
*Struct Allocation*
- Static structs are allocated by the compiler
- Dynamic structs are allocated at runtime
  - the sturct pointer may be static or dynamic 
  - the struct itself is allocated with a call to malloc
- Runtime allocation od dynamic struct
```
void foo() {
  d1 = malloc(sizeof(struct D));
}
```
Static vs Dynamic access of structs follows the same pointer dereference structure that we saw in arrays. \
- Struct members
  - Base address in register (start of struct)
  - Static (constant) offset (bytes from start of srtruct)
  - access memory at base plus static offset
  - equivalent to access to array element with static index (ld p(rs), rd)
