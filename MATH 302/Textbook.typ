//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "Math 302"
#let lecture_num 
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

  #text(size: 14pt)[Textbook #lecture_num]

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
*Section 1.1* \
#underline()[Definitions:] \
*_Sample point_* := possible outcome, usually denoted $omega$. e.g. $omega = (1,3)$ decodes "first die 1, second die 3" when considering rolling two 4-sided dice. \
*_Sample space_* := the set of all sample points, denoted $ Omega$, $Omega = {(1,1),(1,2),(1,3)...,(4,4)} = {1,2,3,4} times {1,2,3,4} = {1,2,3,4}^2$ where $times$ denotes the cartesian product. Produces a new set of all ordered pairs of elements in the sets. \ 
_More generally_, consider "rolling" $n$, $k$-sided dice. Then the sample space would be $Omega = {1,2,3,...,k}^n$ \ 
_Fact:_ $|A^d| = |A|^d$ (note: |B| = cardinality of B), the number of ways of picking d elements from set A of size n wutg replacement, when the order in which they are picked matters is $n^d$ \ 
*_Event_* $:=$ a subset of $Omega$. Can often be described with words, e.g. A = {Dice show the same number} = ${(1,1),(2,2),(3,3),(4,4)}$ \
*_Probability measure (or probability distribution)_*: $P:F arrow [0,1] "for event" \A in F, P(A) = "probability Event A occurs"$ \ 
#underline()[Uniform distribution on finite set $Omega$] \ 
The uniform distribution P on a finite set $Omega$ is defined via: For all $omega in Omega, P({omega}) = 1/(|Omega|)$ i.e. the probability of any one specific sample point (under a uniform distribution) is 1/the sample size \
_Fact:_ if P is uniform on a finite $Omega$ and $A subset.eq "then" P(A) = (|A|)/(|Omega|)$ i.e. the probability of event A occuring equals the number of sample points in A (cardinality) divided by the number of sample points in the sample space \ 
*_Set union_:* The union of $A_1,A_2,...: union.big_(i=1)^infinity A_i:={a:a " belongs to at least of of "A_1,A_2,...}$ \
*_Set intersection and pairwise disjointness_:* Disjoint iff $A \u{2229} B = emptyset$, we say that $A_1,A_2,A_3,.. "are pairwise disjoint if for all " i != j "the sets" A_i,A_j "are disjoint, i.e." A \u{2229} B = emptyset$ \
#underline()[Definition of a Probability measure] \ 
$P "is called a probability measure on" Omega "if it satisfies (i)-(iii)":$
- (i) $0 <= P(A) <= 1 ",for any" A subset.eq Omega$
- (ii) $P(Omega) = 1$
- (iii) if $A_1,A_2,A_3,...$ are pairwise disjoint, then for all $n in NN union {infinity}, P(union.plus.big_(i=1)^n A_i)= Sigma_(i=1)^n P(A_i)$ (note: $union.plus.big$ denotes a disjoint union, i.e. the sets involved have no elements in common $arrow$ we combine all elements in $A "and" B$ but the sets are mutually exclusive ) \
*Section 1.2* Basic combinitorics \
_Clear example:_ How many two-digit numbers are there with distinct digits (first digit may be zero)? \
10 (possibilites for the first digit) $times$ 9 (remaining possibilites for the second digit) = 90 \
_Fact_ there are $n!$ ways of ordering $n$ distinct elements \
In the above examples, we see that there are 10 possibilities for the first, 9 for the second, if we continued there would be 8...so on and so forth (order matters). Notice that $n("number of digits") = 10$, we pick 2 digits.  $(n-1) times (n-2) times ... (n-k)$ if we wanted to find the number of ways to pick $k$ distinct digits. This formula is generalized by $(n)_k=n!/((n-k)!)$ \
Similarly, if we were interested in all the possible ways
