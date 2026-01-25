//  Course Notes Template
// Customize the variables below for each lecture/topic

#let course = "Math 302: Homework Two"
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

*Q1: Let $Omega$ be a sample space and $PP$ be a probability measure. Prove that there cannot exist events $E, F$ that satisfy* \
#align(center)[$ \ PP(E\\F)=2/5, PP(E union F) = 1/2, "and" PP((E sect F)^c) = 3/4$] \
Proof: \
$PP((E sect F)^c) + PP(E sect F) = 1$ #h(2em) by def. of probability measure \
$PP(E sect F) = 1/4$ \ 
(1)  show that $(E sect F^c) "and" (E sect F) "are disjoint"$ 
 \
$(E sect F^c) sect (E sect F)$ \
$(E sect E) sect (F^c sect F)$ #h(1.7em) by associative and commutative property \
$(E sect emptyset) $ #h(7em) by idempotent and complement \ $ = emptyset$ \ $therefore$ (1) \
(2) show that $(E sect F^c) union (E sect F) subset (E union F)$ \
$(E sect F^c) union (E sect F) = E sect (F^c union F)$ \
$E union U = E$ \
$E subset (E union F)$ \
$therefore (2) $


$PP(E sect F^c) + PP(E sect F) <= P(E union F)$ #h(2em) by (1) and (2) \
$2/5 + 1/4  lt.eq.not 1/2$ \
$qed "There cannot exist events" E,F "that satisfy the given conditions"$ \
#line(length:100%)
*Q2: We roll a fair six-sided die until the first 1 comes up. What is the probabilty that the number of tosses is odd?* \ 
Success = {a 1 is rolled} #h(2em) Failure = {not 1}  #h(2em)\ _trials are independent and probability of success is p for all trials _ \ 
Therefore, $X~"Geom"(p)$\
We are interested in odd tosses only, so: $ P("roll is odd") = sum ^infinity_(n=0) P(2n+1)= sum ^infinity_(n=0)(1-p)^((2n+1)-1)p=p times sum ^infinity_(n=0) (1-p)^(2n) , "let" alpha = (1-p)^2 $ \ 
$ P("roll is odd") = p times sum^infinity_(n=0) alpha^n = p times 1/(1-alpha)= p/(1-(1-p)^2)= 1/(2-p)$ \
$p = 1/6$\
$P$(1 is rolled on an odd roll) = $6/11$ \
#line(length: 100%)
*Q3: Given a sample space $Omega$ and a probability measure $PP$, two events $A,B subset.eq Omega$ are said to be independent if $PP(A sect B)= PP(A)PP(B)$.* \
#h(2em) *Assume that the events $E_1,E_2$ are independent. \
#h(2em) a) Prove that the events $E^c_1, E^c_2$ are also independent.* \ 
$ P(E^c_1) = 1-P(E_1) "and" P(E^c_2) = 1 - P(E_2)  "by definition of" PP $ \
$ P(E^c_1) times P(E_2^c) = 1 - P(E_1) - P(E_2) + P(E_1) P(E_2) #h(2em)"(1)" $ \
$ P((E_1 union E_2)^c) = 1 - P(E_1 union E_2) "by definition of" PP $ \ 
$ P(E_1 union E_2)=P(E_1)+P(E_2) - P(E_1 sect E_2) "by inclusion-exclusion" $ \
$ P((E_1 union E_2)^c) = 1 - P(E_1)-P(E_2) + P(E_1 sect E_2)) $ \
$ = P(E^c_1)  P(E^c_2) - P(E_1)P(E_2) + P(E_1 sect E_2) "by substitution with (1)" $ \
$ P((E_1 union E_2)^c) =  P(E^c_1)  P(E^c_2) - P(E_1 sect E_2) + P(E_1 sect E_2) "since" E_1 "and" E_2 "are independent" $ \
$ P(E_1^c sect E_2^c) = P(E^c_1) times P(E^c_2) $ \
$ qed E_1^c "and" E_2^c$ are independent

\ 
#h(2em)* b) If, in addition, $PP(E_1) = 1/2 "and" PP(E_2)=1/3$, Prove that $ PP(E_1 union E_2) = 2/3 $* $ P(E_1 union E_2) = P(E_1) + P(E_2) - P(E_1 sect E_2) $ \
$ = P(E_1) + P(E_2) - P(E_1)P(E_2) #h(2em) "since" E_1 "and" E_2 "are independent" $  \
$ = 1/2 +1/3 - 1/2 times 1/3 = 5/6 - 1/6 = 2/3 $
#h(2em)*c) Let $E_3$ be a third event where  $PP(E_3) = 1/4$, such that all 3 events are independent. Prove that: \ $ 17/24 <= PP(E_1 union E_2 union E_3) <= 19/24 $* \ 
$ P(E_1 union E_2 union E_3) = P(E_1) + P(E_2) + P(E_3) \ #h(16em)- P(E_1 sect E_2) - P(E_2 sect E_3) - P(E_1 sect E_3) \ #h(6em) + P(E_1 sect E_2 sect E_3) \ = 1/2 + 1/3 + 1/4 - 1/6 - 1/12 - 1/8 +  P(E_1 sect E_2 sect E_3) \ = 15/24 + P(E_1 sect E_2 sect E_3) #h(2em) (1) $ Now we must find the bounds on $I = P(E_1 sect E_2 sect E_3)$. Since we cannot say the events are jointly independent, let $A = E_1 sect E_2 = 4/24,$ and $B = E_2 sect E_3 = 2/24$, then \
$ P(B sect E_3) <= P(E_1 sect E_2 sect E_3) <= P(A sect E_1) \ P(B sect E_3) <= 4/24 " and " P(A sect E_1)<= 2/24 $ Since $P(E_1), P(E_3) <= 1$ by definition of a probability measure \
$therefore 2/24 <= P(E_1 sect E_2 sect E_3) <= 4/24$ #h(2em) substitute into (1)\


$qed 17/24 <= P(E_1 union E_2 union E_3) <= 19/24 $ \
#line(length: 100%) \
*Q4: Eight rooks are placed randomly on a chess board (8x8). What is the probability that none of the rooks can capture any of the other rooks?* \
_On an 8x8 chess board, the only valid arangement of rooks such that no two of the rooks can capture any of the others is if they are placed on the main and off diagonal._ \
$P(A="8 rooks are randomly placed on diagonals") = (|A|)/(|Omega|)$ \ 
Since order matters, there are 8! ways to arrange the rooks on either diagonal. Since we have two diagonals, $|A|=2 times 8!$ \
For $|Omega|$, there are 64 squares on the chess board, and we have to pick eight, one for each rook. Since order matters we get $(64)_8$. \
$P(A)= (2 times 8!)/(64)_8$ \
#line(length: 100%) 
*Q5: A fair six-sided die is rolled repeatedly. \ #h(2em) (a) Given an expression for the probability that the first five rolls give a four at most two times.*\ 
We can roll a four 0, 1, or 2 times in 5 rolls. This means the probability of at most two fours in five rolls is denoted as the sum of these events. $ P(A) = P({"No fours"}) + P({1 "four"}) + P({2 "four"}) \
= (1-p)^(5)+(1-p)^4p+(1-p)^3 p^2\ 
"where" p = "roll a four" = 1/6 $\ 
#h(2em) *(b) Calculate the probability that the first two does not appear before the fifth roll *\ The probability that the first two does not appear before the fifth roll is simply $(5/6)^4$, we are calculating the probability that we do not roll a two 4 times, after that the rest of the possible events are rolling a two or not rolling a two, of which we have a probability of 1. \ #h(2em) *(c) Calculate the probability that the first six appears before the twentieth roll, but not before the fifth roll* \
We first need to consider the case in which we roll a 6 before the 20th roll, this case includes the probability that we roll a six before the first 5 rolls. To get the probability that the first six appears between these bounds, we need to subtract the probability that we roll a six in the first 4 rolls from the probability that we roll a six in the first 19 rolls. \
Let A = {first six appears before the twentieth roll, but not before the fifth roll}$ P(A) = P({"roll a six before 20th roll"}) - P({"roll a six before 5th roll"}) \ 
P({"roll a six before 20th roll"}) = 1 - P({"no 6 in first 20 rolls"}) \
= 1 -(5/6)^19 \ P({"roll a six before 5th roll"})= 1-(5/6)^4 \ 
P(A) = 1- (5/6)^19-(1-(5/6)^4) = (5/6)^4-(5/6)^19 $ \
#line(length:100%) 
*Q6: The statement "some days are snowy" has 16 letters (treating different appearances of the same letter as distinct). Pick one of them uniformly at random (i.e. each with equal probability). Let $X$ be the length of the word to which the letter which was chosen belongs. Determine $PP[X=k] "for" k in {3,4,5}$ * \ 
Letters are picked uniformly at random. Let $A_1={"letters in 3 letter words"}$, $A_2={"letters in 4 letter words"}$, $A_3={"letters in 5 letter words"}$, and $Omega = {"ways to randomly pick one letter from the sentence"}$.\
$ P(X=3) = (|A_1|)/(|Omega|) = 3/16 \ 
P(X=4)= (|A_2|)/(|Omega|) = 8/16 \ 
 P(X=4)= (|A_3|)/(|Omega|) = 5/16 $ \
 Notice that the probability that, if we pick a letter uniformly at random, the letter _is_ in a word in the sentence, we get the sum of these probabilities. Intuitively, the probability of doing so should be 1. And indeed, $3/16 + 8/16 + 5/16 = 1$. 




 