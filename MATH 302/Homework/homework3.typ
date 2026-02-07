
#let course = "Math 302: Homework Three"
#let lecture_num = "___"
#let topic = "______"
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

*Q1: In a small town, there are three bakeries. Each of the bakeries bakes twelve cakes per day.
Bakery 1 has two different types of cake, bakery 2, three different types, and bakery 3 four different types. Every bakery bakes equal amounts of cakes of each type (i.e., Bakery 1 bakes six cakes of each of the two types it makes, Bakery 2 bakes four cakes of each of the three types it makes). You randomly walk into one of the bakeries, and then randomly buy two cakes. *\
#h(2em) 
*(a) What is the probabilty that you will buy two cakes of the same type?* \
The probability that we select two cakes of the same type is condition on what bakery we walk into, since the frequencies of the cakes and how many types there are differ for each bakery. Let $A={"Select two cakes of same type"} "and "B_i = {i^("th") " bakery"}$. Using the total probabilty formula, behold:
$ P(A) = P(A|B_1)P(B_1)+P(A|B_2)P(B_2)+P(A|B_3)P(B_3) \
= k_1 times binom(m_1, 2)/(binom(N,2))1/b + k_2 times binom(m_2, 2)/(binom(N,2))1/b + k_3 times binom(m_3, 2)/(binom(N,2))1/b \ 
= (k_1 times binom(m_1, 2) + k_2 times binom(m_2, 2) + k_3 times binom(m_3, 2))/(binom(N,2)N) $ 
Once we enter any of the bakeries, we are given a counting problem, constrained by the number of types ($k_i$), the number of cakes of each type ($m_i$), total number of cakes ($N$) in the bakery that we are in, and ($b$), the number of bakeries in question. 

\
#h(2em)*(b) Suppose you have bought two different types of cake. Given this, what is the probability that you went to bakery 2?* \
Let $A'={"Select two different types of cake"}$, note, $P(A')=1-P(A)$ as two different types of cake is the direct complement of selecting two of the same types of cakes. We will be using this fact to substitute work from the previous question into this computation.
$ P(B_2|A') = (P(B_2)P(A'|B_2))/P(A')  \ 
P(B_2) = 1/b \
P(A'|B_2) = "select two different cakes from bakery two"\
P(A'|B_2)= 1 - P(A|B_2) \
=1-binom(m_2,2)/binom(N,2) \ 
P(A') = 1 - P(A) \ "By substitution from above and previous question, behold:"\
P(B_2|A')= 1/b times (1 - P(A|B_2))/(1-P(A)) = 1/b times (1-binom(m_2,2)/binom(N,2)) times
1/(1-(k_1 times binom(m_1, 2) + k_2 times binom(m_2, 2) + k_3 times binom(m_3, 2))/(binom(N,2)N)) $
