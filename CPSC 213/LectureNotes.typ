//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "Course: CPSC 213"
#let lecture_num = "4"
#let topic = "Numbers and Memory"
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

*Learning Objectives*
- Evaluate and write Java expressions using bitwise operators (&, |, <<, >>, and >>>)
- Determine when sign extension is unwanted and eliminate it in Java- Evaluate and write C expressions that include type casting and the addresing operators (& and \*)
_Extending an integer:_ Increasing the numver of bytes used to store it, \ 
byte b = -6; stored as 1111101 (1 byte) \ 
int i = b; stored as ???????11111010 (4-bytes)
- Signed extension: used in _signed_ data types
  - Everything is signed in Java
  - Copy first bit (sign) to extended bits 
  - C is more complicated but assume types are signed by default
- Zero extension: used in unsigned data types, set all extended bits to zero \
#underline()[Truncation:]
- Truncating an integer: reducing the number of bytes used to store it \
  - int i = -6; stored as 11....11010 
  - byte b = i; stored as 11...11010 (trucated down to 2 bytes)
  consider 256, 100000000 -> 00000000 we get 0, consider signed 128, ...01000000 -> 1000000 (becomes -128)\
- To avoid truncation warning from Java, cast
  - byte b = (byte) i;
#underline()[Bitwise Logic Operators (no Shifts)]
_Operates on bitstrings bit by bit with no carrying_ \
(AND) 1011 & 1100 $->$ 1000 (i.e. 1 lets data through, 0 blocks it) \
(OR) 1011 | 1100 $->$ 1111 \
(XOR) 1011 ^ 1100 $->$ 0111 \
(NOT) 1011 $->$ 0100 \
_Java promotes operands to int - In Java, all bitwise logic operators are performed on ints_ $->$ meaning we convert to a 32 bit string before performing operations \
*iClicker* What is the value of i after this JAva statement executes? \
int i = 0xff8b0000 & 0x00ff0000
_answer_ 0x008b0000 \
mask: pattern of bits that decides which bits are preserved and which ones are cleared (f $->$ perserve data, 0 $->$ clear data)\
#underline()[Bit Shift OPerations in C/Java] \
a << b:
- Shifts all bits in a to the left b times,
- The empty bits on the right are always filled with zero \
a >> b:
- shifts all bits in a to the right b times
- What fills the empty bits on the left?
  - C: if a is unsigned, zero-extends, otherwise sign-extends
  - Java: operator >> sign-extends, operator >>> zero-extends /
_Application:_ Shifting multiplies/divides by power of 2 \ a << b = a $times 2^b$ \
a >> b = $a/ 2^b$ \ 
Example: 
- 22 in binary is 00010110 $arrow$ 11 is 00001011 $arrow$ shifted to the right once, i.e. $22/2^1$
- 44 is 00101100 (22 shifted left once, $22 times 2^1$)
- 88 is 01011000 (22 shifted left twice, $22 times 2^2$) \
_Works for negative numbers too, if using sign-extended shift_ 
- -22 is 11101010 $arrow$ -11 is -22 shifted right once, $-22/2^1$, we pad on the left side with a 1 (to perserve sign)
- When we shift left, we pad on the right with a 0, dont need to worry about perserving the most significant bit \
*iClicker* What is the value of i after this Java statement executes? \
_in Java we default with signed integers (>> sign-extends, NOT >>>, 0 extends)_
\ 
int i = 0x8b << 16; $arrow$ promote 0x8b (a byte) to an integer,(2 bytes) \
0x8b $arrow$ 0x0000008b
