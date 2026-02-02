
//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "9"
#let topic = "Struct Allignment"
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

*Go over iClicker 1c.8, 1c.9*

*Dynamic Allocation and Responsibility*
Learning goals:
- Compare Java dynamic allpcation and C's explicit-delete approach by identifying relative stengths and weaknesses
- Identify and correct dangling-pointer and memory leak bugs in C caused by improper use of free()
```
void* malloc(unsigned long n);
```
void\* is a pointer to _anything_, malloc gives you a block of memory in the heap
- returning typse is void\*
- cannot be derferences directly

*Memory Deallocation* \
Wise management of memory requires deallocation 
- In Java we have Grabage collection: memroy is dellocated when no longer in use
- Requires keeping track of every reference to an object
In C:
- Dynamic memory must be deallocated explicitly by calling free
- Memory is deallocated immediately, no checks if it's still in use

*Memory Heap*\
- The heap is a large section of memory from which malloc allocates objects
_What malloc and free do?_
- Organization of memory
  - Statically allocatedL code, static data
- malloc/free
  - Implemented in library
  - Manage a chunk of memory called the heap
  - Keep track of whats allocated or free
- malloc
  - find a free chunk of memory of appropriate size
  - mark it allocated
  - return pointer to it (keeping track of its size)
- free
  - use pointer to determine allocated size
  - mark references memory as available

*Issues with Explicit Deallocation* \
- Does not change what x points to
- Does not change any other pointers pointing to that memory
- Does not change or erase data in the freed memory

Suppose we decouple allocation and deallocation, issues arise:
- A call to the create function without a free call will result in too much memory allocation
- Calls to destroy could deallocate memory we still need
- Dangling-pointers 