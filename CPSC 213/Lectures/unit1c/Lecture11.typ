//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "11"
#let topic = "More on Dynamic Array Access"
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

*Prologue: Why Struct Alignment and Offsets Matter* \
- Alignment affects:
  - Correctness when accessing memory directly
  - Performance
  - Interpobility
*Structs:*
- Structs can be declared as members of other structs _(note: pointers are 4 bytes on 32 byte systems)_
- interesting example:
  ```
  struct Z {
    int i;
    struct Z* z;
    int j;
  }
  ```
  In memory, struct Z points to another struct Z on the heap, this is a linked list.
  *Padding*
  - We need to make sure our structs are aligned
  - In module 1, member variables are aligned by their size
  - For structs, the struct is aligned to its largest member variable
  - The size of a struct must be a multiple of its Alignment

```
struct X {
  char a; # base
  char b; # offset 1
  int i; # cant put an int at offset of 2 since 2 % 4 != 0
}

struct Y {
  char a; #base, waste 3 bytes
  int i; # offset 4
  char b; # offset 9 
  # size of struct must be multiple of its alignment, aligned to the largest of their members' alignment 
  # but must be a multiple of 4, so we pad by another 3 s.t. 12 % Y.size = 0
}
```
struct design effects performance, when we design structs without the offset in mind, there is more memory to traverse
```
#Assume 8-byte addressing
#What is the offset of j?
struct D {
  int e;
  int f;
}
struct X {
  int i;
  struct D* d;
  int j;
}
# with 8-byte addressing, the size of d is 8-bytes, offset of d is 4, but then d is not aligned, so we pad by another 4, then the offset of d is 8, its size it 8, so j is offset by 16

```
- Array of structs i.e. struct S a[42] ; allocates a bunch of memory upfront 
- Array of pointers to structs i.e. struct S\* b[42] ; results in a load needed for each pointer