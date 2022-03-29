# CS302: Paradigms of Programming

## Spring 2021

Programming Assignment 3: Pointer Analysis using Logic
======================================================

In object-oriented languages such as C++ or Java, at a statement `a = new A();`, a new object is allocated on the heap and its reference is stored into the variable `a`; another way to express this relationship is by saying "a points to o", where `o` represents the newly allocated object.

Consider a programming language that supports the following five kinds of statements:
- alloc(a, o) allocates an object `o` on the heap and stores its reference into the variable `a`
- copy(a, b) copies the object pointed-to by `b` to `a`
- load(a, b, f) loads the object pointed-to by `b.f` and copies it to `a`
- store(a, f, b) stores the object pointed-to by `b` into `a.f`

Now consider this program:

```
alloc(a, o1).
alloc(b, o2).
alloc(c, o3).
store(a, f, c).
load(d, a, f).
```

Here, `a` points to `o1`, `b` points to `o2`, `c` points to `o3`, `a.f` points to `o3`, and `d` points to `o3`.

In this assignment, we have to implement a "pointer analysis" in Prolog.
In particular, we should be able to answer the following queries:
- pointees(a, L) should return a list `L` of all the objects that are pointed-to by `a`.
- fieldpointees(a, [f1, f2], L) should return a list `L` of all the objects that are pointed-to by `a.f1.f2` (the second argument could be a list consisting of any number of valid fields).

The input to the assignment will be programs represented as Prolog facts of the above form (alloc, copy, load and store).

## Submission

- You need to submit a single file named `rollnum-asgn3.pl` (where 'rollnum' is your roll number in small letters) consisting of your Prolog program.

## Evaluation

We will be using a testcase-based automated evaluation to check various standard as well as corner cases. You will get marks based on how many testcases does your submission pass.

