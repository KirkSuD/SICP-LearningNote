# My SICP study note

Useful links:

* <https://sicp.readthedocs.io/en/latest/>

## Chapter 1: Building Abstractions with Procedures

### LISP

LISt Processing  
atoms, lists  
Scheme, common LISP  
Lisp procedure as Lisp data

### 1.1 Elements of Programming

3 mechanism to form complex ideas:

* *primitive expresssions*, language
* *means of combination*, compound expressions
* *means of abstraction*, compound objects as units

programming = deal with "procedures" & "data"  
this chapter: numerical data only,  
  focus on rules for building procedures.  
later chapter: compound data
in scheme, integer == real number, 3 == 3.0

### 1.1.1 Expressions

primitive expression  
primitive procedure  
compound expression  
combinations  

    ==> (+ 1 2)
    3
(operator operands)  
apply procedure to arguments  
**Prefix notation**  
arbitrary number of arguments  
arbitrary depth of nesting  
pretty-printing  
Read-Eval-Print Loop, **REPL**

### 1.1.2 Naming and Environment

In Scheme, we *define* a variable:

    ==> (*define* size 2)  
    size
    ==> size  
    2
**Every expression has a value.**  
Quip: "Lisp programmers know the value of everything but the cost of nothing."  
**Global environment** tracks variables' name-object pairs.

### 1.1.3 Evaluating Combinations

**The general evaluation rule** evaluates a combination:

1. Evaluate the subexpressions of the combination.
2. Apply the procedure(leftmost subexpression, operator)
   to arguments(other subexpressions, operands).

The evaluation rule is recursive in nature.

"Perculate values upward" form of the evaluation rule is
 an example of a general kind of process known as *tree accumulation*.
Primitive expressions are numerals, built-in operators, others.  

The environment provides a context in which evaluation takes place.  
*define* is an exception to the general evaluation rule, obviously.  
Exceptions to the general evaluation rule are called **special forms**,
each special form has its own evaluation rule.

*Syntactic sugar*: special syntactic forms that can be written in a formal way.

### 1.1.4 Compound Procedures

Some quick small notes are given in the book here:

* Numbers / arithmetic operators = primitive data / procedures
* Nesting of combinations combines operators.
* The *define*

**procedure definitions**: give compound operation a name, refer to it as a unit.

    ==> (define (square x) (* x x))
    square

This is a **compound procedure**.

The general form of a procedure definition is

    (define (<name> <formal parameters>) <body>)

Explanation:

    (define (<procedure name> <parameters' names>) <body: expression(s)>)

### 1.1.5 The Substitution Model for Procedure Application

The 2 evaluation models for evaluating a combination whose operator is a compound procedure:

1. **Applicative-order evaluation**: Evaulate arguments then apply procedure to them.
2. **Normal-order evaluation**:
Fully expand procedure definition until primitive operators left only,
then perform the evaluation.

Most interpreters use **applicative-order evaluation** due to the efficiency and simpleness.  
However, it has limitations.

*Delayed evaluation* provides "intermediate grounds" between 2 orders.  
*Call-by-need evaluation* avoids multiple evaluations used in
strict *normal-order evaluation*.  
A method akin to *normal-order evaluation* deals with "infinite data structures".

### 1.1.6 Conditional Expressions and Predicates

*case analysis* in Lisp: **cond**, a special form.

The general form of a conditional expression:

    (cond (<p1> <e1>)
          (<p2> <e2>)
          ...
          (<pn> <en>)
          (else  <e>) )

Explanation:
**cond**'s arguments are pairs of expresssions (<*p*> <*e*>) called clauses.  
*p* = predicate / *e* = consequent expressions  
**cond** walk clauses in sequence, eval *p*,
 if true(non-*nil* in Lisp) is returned, return *e*.  
If no *p* is true, and there is no (else <*e*>), return false(*nil* in Lisp);
else, return *e* in (else <*e*>).

The word *predicate* is used for procedures and expresssions that return true or false.  

*if* is a restricted type of conditional when only 2 cases are considered,
the general form of *if*:

    (if <predicate> <consequent> <alternative>)

Explanation:  
Evaluate <*predicate*>, if it evaluates to a true value(non-*nil*), return <*consequent*>;
else, return <*alternative*>.  
Similar to the 3-operand operater "<*predicate*>*?*<*consequent*>*:*<*alternative*>"
and Python's "<*consequent*> *if* <*predicate*> *else* <*alternative*>".

Note a difference between *cond* and *if* in Scheme:
*cond*'s *e* can be multiple expresssions,
*if*'s <*consequent*> and <*alternative*> can only be single expressions.

*Logical composition operators* for constructing compound predicates:

* **and**:  arbitrary number of arguments,
if all true, the value of *and* is true; else, false.
* **or**:   arbitrary number of arguments,
if all false, the value of *or* is false; else, true.
* **not**:  a single argument, true -> false, false -> true.

Examples:

    (define (abs x)
      (cond ((> x 0) x)
            ((= x 0) 0)
            ((< x 0) (- x))))
    (define (abs x)
      (cond ((< x 0) (- x))
            (else x)))
    (define (abs x) (if (< x 0) (- x) x) )
    (and (> x 5) (< x 10))
    (define (>= x y)
        (or (> x y) (= x y)))
    (define (>= x y)
        (not (< x y)))

#### Exercise 1.1-1.3

File: SICPex1.1.rkt, SICPex1.2.rkt, SICPex1.3.rkt

### 1.1.7 Example: Square Roots by Newton's Method

File: SICPch1.1.7.rkt

function (sqrt)     |procedure (Newton's Method)
--------------------|------------------------------
what-is (property)  |how-to-do
declarative         |imperative/procedual knowledge

#### Exercise 1.4-1.6

File: SICPex1.4.rkt, SICPex1.5.rkt, SICPex1.6.rkt

### 1.1.8 Procedures as Black-Box Abstractions

*sqrt* program = a *cluster* of procedures  
*decomposition* of problem -> subproblems

Regard the procedure *square* as a "black box", use it as a *module*.  
*How* it works doesn't matter, it's seen as an **abstraction of procedure**,
called **procedual abstraction**.

Fig 1.2 Procedual decomposition of the *sqrt* program

A procedual definition should suppress detail,
be able to be used without knowing how it's implemented.

#### Local names

A procedure's meaning is independent of the parameter names, obviously.  
Thus, the parameter names are local to the procedure's body.

A procedure's formal parameter is a **bound variable**;
the procedure **binds** its formal parameters.

A variable is **bound in an expression** if the meaning of the expression is unchanged
when the variable is consistently renamed throughout the expression.
Otherwise, it's **free** in that expression.

The set of expressions for which a binding defines a name is called the **scope** of that name.  
Rename a bound variable to a free one = **capture** the free variable

#### Internal definitions and block structure

Currently, only one name isolation:
a procedure's formal parameters are local to the body of the procedure.

Localize auxiliary subprocedures, hide them inside.  
Internal definitions are local to the procedure.  
Nesting of definitions are called **block structure**.

The discipline of making internal definitions' variables which are already
given by the enclosing procedure / the environment *free* is called **lexical scoping**.

### 1.2 Procedures and the Processes They Generate

Some explanation about *procedure* and *processe*.

### 1.2.1 Linear Recursion

File: SICPch1.2.1.rkt

recursive, needed memory growth = O(n) => a **linear recursive process**  
only keep track of constant vars  O(1) => a **linear iterative process**  
(state can be summarized by a fixed number of *state variables*
with a fixed rule for updating variables, and, maybe an end test)  

See the contrast in another way:  
iterative: data stored in fixed vars, can be resumed if given after pause (*register* only)  
recursive: data stored in the chain of *deferred operations* (needs *stack*)

procedure vs. process:  
procedures generate processes,  
recursive procedure means the syntactic fact;  
recursive process means how the process evolves.

A **tail-recursive** interpreter execute an *iterative process*
that is described by a *recursive procedure* in constant space.

#### Exercise 1.7-1.8

File: SICPex1.7.rkt, SICPex1.8.rkt

### 1.2.2 Tree Recursion

File: SICPch1.2.2.rkt

Another common pattern of computation: **tree recursion**.  
*Time* complexity is proportional to the number of *nodes*,  
*space* complexity is proportional to the *depth* of the tree.

#### Exercise 1.9

File: SICPex1.9.rkt

### 1.2.3 Orders of Growth

You know... the **O(n)**

#### Exercise 1.10

File: SICPch1.2.2.py  
ex1.10 is in SICPch1.2.2.py.

O(n^m) explanation:
<https://cs.stackexchange.com/questions/7105/time-complexity-for-count-change-procedure-in-sicp>

### 1.2.4 Exponentiation

File: SICPch1.2.4.rkt

#### Exercise 1.11-1.14

File: SICPex1.11.rkt, SICPex1.12.rkt, SICPex1.14.rkt

Note:  
ex1.13 is in SICPex1.12.rkt since they're related,  
ex1.14 Quick explain: <https://sicp.readthedocs.io/en/latest/chp1/13.html>

To-read: <https://sicp.readthedocs.io/en/latest/chp1/19.html>

### 1.2.5 Greatest Common Divisors

#### Exercise 1.15

File: SICPex1.15.py  

GCD using normal-order: O((logn)^n)=O(nlogn)

### 1.2.6 Example: Testing for Primality

File: SICPch1.2.6.rkt

Traditional O(sqrt(n)) test and the O(logn) fermat test

#### Exercise 1.16-1.22

File:  
SICPch1.2.6.scm, SICPch1.18.scm, SICPch1.19.scm,  
SICPch1.20.rkt, SICPch1.21.rkt, SICPch1.22.rkt

Note:  
ex1.16 & ex1.17 are in SICPch1.2.6.scm.  
Also, modern computers are too fast to see the results.

### 1.3 Formulating Abstractions with Higher-Order Procedures

Procedures build abstractions,  
higher-order procedures accept procedures as parameters  
or return them to increase the expressive power of our language.

### 1.3.1 Procedures as Parameters

File: SICPch1.3.1.rkt  
Just an example: (sum term a next b)

#### Exercise 1.23-1.27

File: SICPch1.3.1.rkt  
ex1.23-1.27, ex1.29 are in SICPch1.3.1.rkt.

[44] ch3.4.2 Data structure - streams
can be used to build more powerful abstractions.

### 1.3.2 Constructing Procedures Using *Lambda*

Lambda:

    (lambda (<formal-parameters>) <body>)

IIFE (Immediately-invoked function expression):

    ((lambda (<var1>...<varn>)
        <body>)
     <exp1>
     ...
     <expn>)

let (just a syntactic sugar):

    (let ((<var1> <exp1>)
          ...
          (<varn> <expn>))
    <body>)

2 reasons for using *let*:

* scope: bind variables as locally as possible
* simultaneously: variables are bound simultaneously

#### Exercise 1.28

Answer: error! 2 is not a procedure.  
; application: not a procedure;  
;  expected a procedure that can be applied to arguments

### 1.3.3 Procedures as General Methods

File: SICPch1.3.3.rkt  
Example: Finding roots of equations by the half-interval method  
Example: Finding the maximum of a unimodal function  
**Checkpoint: 190318, Page: about 66**

#### Exercise 1.29-1.31

ex1.29 is in SICPch1.3.1.rkt.  
ex1.30 answer:

    Brute-force = O(L/T), Golden section = O(log(L/T))  
    With L=1 & T=0.01, the exact numbers of evaluations are:  
        Brute-force = 101, Golden section = 10.  
        ( beacause math.log(100)/math.log(1.618) > 9 )

File: SICPex1.31.rkt  

### 1.3.4 Procedures as Returned Values

File: SICPch1.3.4.rkt  
Procedures as returned values increase expressive power.  
Example: derivative, newton's method.  
[50] Procedures as returned values can deal with infinite data structure
 via the technique of stream processing.

#### Exercise 1.32-1.35

File: SICPex1.32.rkt, SICPex1.35.rkt  
ex1.32, ex1.33 are in SICPex1.32.rkt.  
ex1.34 is in SICPch1.3.4.rkt.  
**Checkpoint: 190731, Page: 70, Chap1 finished**

## Chapter 2: Building Abstractions with Data

Build abstractions by combining data objects to form **compound data**.

* Elevate conceptual level
* Increase modularity
* Enhance expressive power

Example: rational numbers (using pairs(glue) to combine data)  
Example: linear combination (generic operators(type-irrelevant))

**Data abstraction** can erect suitable **abstraction barriers**  
 between different parts of a program.  
**Data-directed programming**

### 2.1 Introduction to Data Abstraction

Compound procedure -> procedural abstraction  
Compound data -> **data abstraction**

Interface between data representation and the use is  
a set of procedures, called *selectors* and *constructors*.

### 2.1.1 Example: Arithmetic Operators for Rational Numbers

File: SICPch2.1.1.rkt  
ex2.1 is in it.

    ;; Pairs:
    (cons <> <>) ;; CONStruct
    (car <>) ;; Contents of Address Register
    (cdr <>) ;; Contents of Decrement Register "could-er"
    ;; Example:
    ==> (define x (cons 1 2))
    x
    ==> (car x)
    1
    ==> (cdr x)
    2
    ;; Rational number
    (make-rat <n> <d>) (numer <x>) (denom <x>)
    ([+-*/=]rat <x> <y>)

#### Exercise 2.1

A better version of make-rat which prettify negative input results.  
Solved in SICPch2.1.1.rkt.

### 2.1.2 Abstraction Barriers

**Abstraction barriers** isolate different levels of  
 data manipulation of the program, which makes  
 the program easier to maintain and to modify.

#### Exercise 2.2

File: SICPex2.2.rkt  
Segment, point data abstraction, midpoint operator using pairs.

### 2.1.3 What Is Meant by Data

File: SICPch2.1.3.rkt

Data can be thought as some selectors and constructors,  
 together with some conditions that these procedures must fulfill.

[4] This idea is hard to formulate rigorously.  
 Two failed approach at 1970s:  
 **Abstract models** & **Algebraic specification**.

Example: implement *cons*, *car*, and *cdr* using *only procedures*.  
This style of programming is often called **message passing**,  
 and will be used in chapter 3: modeling and simulation.

#### Exercise 2.3-2.5

File: SICPex2.3.rkt, SICPex2.4.rkt, SICPex2.5.rkt
**Checkpoint: 190801, Page: 84, 2.1.3 finished**

### 2.1.4 Example: Interval Arithmetic

File: SICPch2.1.4.rkt  
ex2.6-2.15 are in SICPch2.1.4.rkt.

An example of doing arithmetic on intervals
 (containing a lower-bound and an upper-bound)
 with lots of exercises.

#### Exercise 2.6-2.10

ex2.6-2.10 are in SICPch2.1.4.rkt.  
Some exercise of Interval Arithmetic.  
To think: Is there a better implementation of ex2.10??  
Or, it just doesn't matter?

#### Exercise 2.11-2.15

ex2.11-2.15 are in SICPch2.1.4.rkt.  
Some exercise of Interval Arithmetic.  
**Checkpoint: 190814, Page: 88, 2.1.4 done**

### 2.2 Hierarchical Data

Pairs provide a "glue" to construct compound data objects.  
Figure 2.2-2.3 shows the *box-and-pointer* notation.  

*cons* can also combine other pairs, so all data structures can be constructed by it,  
which enables us to represent **hierarchical data** (sequences and trees).

Then introduce **symbolic expressions** -- data whose elementary parts
 can be arbitrary symbols rather than only number.

Then explore alternatives for representing sets;
 see the impact/complexity of manipulating data using different objects
 to represent the same data structure.

Investigate *Huffman encoding*.

### 2.2.1 Representing Sequences

**Sequence** is an ordered collection of data objects,
 can be constructed using nested *cons*:

    (cons 1 (cons 2 (cons 3 (cons 4 nil))))

Such a sequence of pairs is called a *list*
 ([5] A **list** is a data structure made out of pairs, not just *list*),  
Lisp provides a primitive called *list* to help in constructing lists:

    (list <a1> <a2> ... <an>) ;; (list 1 2 3 4)

is equivalent to

    (cons <a1> (cons <a2> (cons ... (cons <an> nil) ... )))

Use **car** and **cdr** to traversal the list,
 **cons** to add an item to the beginning of it.

nil can be thought as a sequence of no elements, the *empty list*.

#### List oprations

File: SICPch2.2.1.rkt  
See (nth), (length), (append) in it.

*cdring down*: (nth), (length)  
*cons up* an answer/result list while cdring down a list: (append)

#### Exercise 2.16-2.21

File: SICPch2.2.1.rkt, SICPex2.16.rkt, SICPex2.17.rkt, SICPex2.18.rkt, SICPex2.19.rkt, SICPex2.20.rkt, SICPex2.21.rkt  
**Checkpoint: 190816, Page: 93, 2.2.1 done, TODO: none**

### 2.2.2 Representing Trees

Representing sequences whose elements are sequences forms a tree:

    ==> (cons (list 1 2) (list 3 4))
    ((1 2) 3 4)

My structure:

    *   -   *
    |       |
    1 - *   3  -  *
        |         |
        2 - nil   4 - nil

Box-and-pointer:

    **-**-*/
    |  3  4
    **-*/
    1  2

Tree:

    |
    -------
    |   | |
    --- 3 4
    | |
    1 2

#### Exercise 2.22-2.24

File: SICPex2.22.rkt, SICPex2.23.rkt, SICPex2.24.rkt

#### Recursion

File: SICPch2.2.2.rkt

Recursion is a natural tool to deal with tree structures.

In addition to **null?**, Lisp provides **atom?** to test whether its argument
 is atomic(not a pair).

Length:

    Empty: 0
    Else: length of (cdr list) + 1

Countatoms:

    Empty: 0
    Elif atomic: 1
    Else: (countatoms (car list)) + (countatoms (cdr list))

#### Exercise 2.25-2.27

File: SICPex2.25.rkt, SICPex2.26.rkt, SICPex2.27.rkt

**Checkpoint: 190911, Page: 100, 2.2.2 done, TODO: none**  
Congratulations! Reached page 100! 🎉 You deserve a beer! 🍺

### 2.2.3 Symbols and the Need for **Quote**
