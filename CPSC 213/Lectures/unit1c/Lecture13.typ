
//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "CPSC 213"
#let lecture_num = "13"
#let topic = "Instance variables and dynamic allocation"
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
Cannot free a memory address that has not been allocated, consider the situation in which we alloacte 10 bytes of memory and then change the pointer to the base address. When we try to deallocate the pointer, we get an invalid free.
*Avoiding Memory Problems in C*
- Where is the memory allocated?
- Where is the memory freed?
- Avoid the program clases
  - If possible, restrict dynamic allocation/free to single procedure
  - If possible, dont write prcodures that return pointers
  - If possible, use local variables instead
  - Local variables are allocated on call and freed on return, automatically 
  - Engineer for memory management
  - define rules for which procedure is responsible for deallocation
  - use explicit reference counting if multiple potential deallocators
  - define rules for which pointers can be stored in data structures 
  - use coding conventions and documentation to ensure rules are followed
*In C*
- Local variables are automatically freed
  - _In a week we will see how this works at a machine level_
*Strings in C*
- an array of characters
- the end of a string is indicated by the first 0 (null) in the array
- so, every string has a 
  - max length (length of array - 1), a.k.a string size
  - determined by position of the first null ("\\0")

*Problems with explicit free*
- Pass pointer as argument to function during another function call, free after. If we use the pointer after its been freed, we will seg fult as it is now a dangling-pointer.

*Reference counting*
- At any point in time we need to track how many references are contained within each block, when there are no references we can free. 
  - initialize the reference count to 1 (the caller has a reference)
  - any procedure that stores a reference (starts using object)
  - never call free directly (object is freed when count goes to zero)

*Implementatuion of rcMalloc, rcKeep, rcFree*
```
void* rc_malloc (int n) {
  // Allocate 8 bytes at the beginning of the array to store the number of referebces
  int *ref_count = malloc (n + 8);
  *ref_count = 1;
  return ((void*) ref_count) + 8;
}

void rc_keep_ref (void* p) {
  // when we want to increment/decrement the number of references, we access the first 8 bytes
  int *ref_count = p - 8;
  (*ref_count) ++;
}
void rc_free_ref (void* p) {
  int *ref_count = p - 8; 
  (*ref_count) --;
  if (*ref_count == 0)
  free (ref_count);
}
```
When a reference is a parameter
  - The caller has a reference and maintains it for the duration of the call

