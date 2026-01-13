//  Course Notes Template
// Customize the variables below for each lecture/topic
#import "@preview/zebraw:0.6.1": *
#show: zebraw
#let course = "CPSC 330"
#let lecture_num = "3"
#let topic = "Decision Trees"
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

*Big Picture and Motivation* \
We want to learn a mapping function from labeled data so that we can predict labels of unlabeled data. \
#underline()[*Decision Trees*] \
As tree grows the decision boundary becomes more complex (note, the number of parameters dictate the shape of the decision boundary (i.e. line in $R^2 "and plane in " R^3$))
*Generalization*
- Point of model is not to learn everything we can from available data, interesting part is to learn the right amount s.t. the decision function can be applied to new data \
_Model complexity and training error_
- As model complexity increases, the training error goes down. \
*Traning error vs. Generalization error* \
- Given a model $M$, in ML, people usually talk about two kinds of errors of $M$
  1. Error on training data
  2. Error on entire distribution, we are interested in this but we do not have access to the entire distribution
  ```
  # Train a DummyRegressor model 

from sklearn.dummy import DummyRegressor # Import DummyRegressor 

X = housing_df.drop(columns = ['id', 'date', 'zipcode', 'price'])
y = housing_df['price']

# Create a class object for the sklearn model.
dummy_regr = DummyRegressor()

# fit the dummy regressor
dummy_regr.fit(X,y)

# score the model 
dummy_regr.score(X,y)
  ```
  \ \
*Splitting the Data* \
```
# Split the data 
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=123)
```
- Shuffle data first. If the data is ordered, when we split the data we will get an unrepresentative sample split between training and testing.
- We MUST hide the test data from the model
*Error*
- We use a validation set, a data set where we have access to target values, we validate our model by testing it on the validation set, error should be low if model is trained correctly.
- Can typically expect $E_"train" < E_"validation" < E_"test" < E_"deployment"$
- Choose depth that gives the best validation score
*Cross-validation*
- Might be unlucky with training/testing split (leads to data that does not represent your population)
- Dataset might be small, leads to small training/validation set
- _Low reliability of validation score_
Still lock test data away, split the training data into $k$ folds, each fold splits training and testing differently, train $k$ models on the respective psudeo testing sets, average the error across all folds.
```
from sklearn.model_selection import cross_val_score, cross_validate

dt = DecisionTreeRegressor(max_depth=9, random_state=123)
cv_scores = cross_val_score(dt, X_train, y_train, cv=10)
cv_scores
```
- Use "cross_validate(df_train,X_train,Y_train, cv = k, return_train_score = True)" for a more comprehensive result
- No shuffling in cross validation 
