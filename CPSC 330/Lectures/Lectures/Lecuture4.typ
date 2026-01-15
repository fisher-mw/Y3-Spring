#import "@preview/zebraw:0.6.1": *
#show: zebraw
#let course = "CPSC 330"
#let lecture_num = "4"
#let topic = "Fitting the data"
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
*Overfitting* \
- Avoid overfitting, when we make the model too complex (overfit to the data), we loose generalization. The model becomes very good at predicting the type of data it was trained on, but it generalizes poorly to new data.
\
*Bias vs variance tradeoff*
- The fundemental trade-off is also called the vias/variance tradeoff in supervised machine learning.
_Bias:_ the tendency to consistently learn the same thing (high bias corresponds to underfitting) \
_Variance_: the tendency to learn random things irrespective of the real signal (corresponds to overfitting), typical of complex systems.

*iClicker* \ 
_Def:_ Hyperparameter $->$ any parameter that can be set to define part of the ML process (any parameter we may introduce to tune our model)
- $k$-fold cross validation calls fit $k$ times
- We do not use cross-validation to get the best hyperparameters for the model, it gives you the score for the model (averaged over $k$ folds). It is often used in tuning for the best hyperparameters.
- If the mean train accuracy is much higher than the mean cross-validation accuracy it is likely to be a case of overfitting.
- When working with a small dataset, pick a high $k$ for cross-validation
- When doing 10-fold CV on a Decision Tree of depth 1, the resulting trees will be more similar to each other than when doing 10-fold CV on Decision Tree of depth 5. We call this high bias. _Note: subset is from the original distribution, we learn the most obvious rule in depth 1 (so it will be the same)_
\
* $K$-nearest neighbors*
- For $k = 1$ the accuracy is 100% on the training set (a data point will always classify itself correctly) _very poor accuracy on test set_
\ \ *Pros vs. Cons*: 
\ _Pros_
- Easy to understand/interpret
- Simple hyperparmeters ($k$)
- Can learn complex functions given enough data
_Cons_ \
- Can be potentially be VERY slow during prediction time, especially when the training set is very large.
- Often not that great test accuracy compared to the modern approaches.
- It does not work well on datasets with many features or where most feature values are 0 most of the time (sparse datasets).
*Curse of dimensionality*
- Affects all learners but especially bad for nearest-neighbour. 
- $k$-NN usually works well when the number of dimensions $d$ is small but things fall apart quickly as $d$ goes up.
- If there are many irrelevant attributes, $k$-NN is hopelessly confused because all of them contribute to finding similarity between examples. 
- With enough irrelevant attributes the accidental similarity swamps out meaningful similarity and $k$-NN is no better than random guessing.  
*Support Vector Machines (SVM) with RBF kernel*
- Similarity based algorith, uses most important vectors to make classification.
- (Closest boundary vectors to important classification (close samples to boundary))
- Weight points closer to boundary more heavily 
Key hyperparameters of SVM (rbf)
- gamma
- C