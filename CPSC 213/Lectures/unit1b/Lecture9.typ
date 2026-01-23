//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "9"
#let topic = "Static vs. Dynamic Arrays"
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
*Dynamic Arrays - Java vs. C* \
_Java_
- Array variables stores reference to array allocated dynamically with 'new' statement
_C_
- array variables can store static arrays or pointers to arrays that are allocated dynamically with call to 'malloc' (returns staring address of block of bytes) library procedure.
- Can store int bst[10]; or int \*bptr = &bst[0]; (pointer to base)
- int \*bdyn = malloc(10 \* size(int)), does not tell us where the base is
- C perfors *no array bounds checking*
  - Out-of-bounds access maipulates memory that is not part of array
  - Performance is faster, but source of vulnerability
*Dynamic Allocation in C*
- Dynamic allocation with call to 'malloc'
- Return address of a block of bytes with no associated type or initialization 
  - Element type and dereferencing determines how the data is interpreted 
- We do not know where the array is going to be stored, array size is known but storage allocated at runtime is unknown 
- At runtime static allocation is the same, memory already exists, no alloaction step needed, stored in static memory
*The only difference is the pointer to the base of the array*
\ We implement with directives
- The directive for the pointer address is: 
  - b: .long b_data \#malloc result
  .pos 0x3000

*iClicker*
- What is the minimum number of memory load operations required to execute this line of code
  - b[a[2]] = a[b[2]] $arrow.l$ code this 
*Working with Pointers in C*
- Pointers are declared as:
  - type \*varname;
- Pointers may be accessed as:
  - varname[0] or \*varname
  - varname[i] or \*(varname+i)
- The address of a variable can be obtained with:
  - type a;
  - type \*ptr = &a;
*Pointer arithmetic*
- Since pointers store memory addresses, when we do arethmitec on them we get new addresses specified by the type of arithemtic 
  - i.e. subtracing two pointers of the same type gives the number of elements of that type between the address (notice it is not the number of bytes, since we know the type of the pointer we use it to compute the offset, thus getting the elements and not the number of bytes)

