#show math.equation: it => {
  if it.has("label") {
    math.equation(it.body, block: true, numbering: "(1)")
  } else {
    it
  }
}
#show math.equation: set block(breakable: true)
#import "@preview/theorion:0.5.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion
#import "@preview/obsidius:0.1.0": *


= Introduction

I saw the following meme
#figure(
  image("The_meme.jpg", width: 50%),
)
The humor is of course in the fact that the matrix multiplication itself was done by digit concatenation, but the answer also happens to be correct ;)
$
  mat(
    3, 4;
    8, 7;
  )mat(
    7, 2;
    4, 9
  )=
  mat(
    37, 42;
    84, 79;
  )
$

This however leads to the interesting problem whether there are other examples of this?

= Formulation
We can model the problem in the following manner

$
  A B = 10A+B
$<eq:mode>

We need to *restrict $A$ to be positive integer matrices* (This means we are not allowing the case where A can have zero entries thus ignoring concatenation 0|3=03). *Restrict $B$ to be a non-negative matrix*.

With this model it should also be that *B must consist of single integers*. (If we allow B to have integers with two digits then the model must change to $A B = 100A +B$ which is also an interesting problem but let's look at this one for now)


It is not necessary for $A$ to be single digit, but perhaps we will restrict it any way (for a bit of symmetry) lets see.

So we have the following to consider,

+ $A B = 10A+B$
+ $A in M_(2 times 2)(ZZ^plus)$ and $B in M_(2 times 2)(ZZ^plus_0)$
+ $B$ is a single integer matrix ($B_(i j) < 10 " "forall i,j$)




= Deriving Conditions

To make some progress it is useful factorize things as follows,
$
        A B - 10A-B & =0 \
  A B - 10A-B +10 I & =10I \
       (A-I)(B-10I) & =10I \
                C D & =10I \
$

Note that $C$ and $D$ must be invertible (because I is invertible, i.e.  $det(C) det (D) =10$)

$
  D = 10C^(-1)
$

*Furthermore, $A,B in M_(2 times 2)(ZZ) ==> C,D in M_(2 times 2)(ZZ)$ considering the way they are defined*

Now Let,

$
  C = k mat(
    alpha, beta;
    gamma, delta
  ) = k C'
$

$"GCD"(alpha, beta, gamma, delta)=1$. with $k in ZZ^(+)$
Then,

$
  C^(-1) = 1/(k det(C')) mat(
    delta, -beta;
    -gamma, alpha
  )
$

$
  D = 10/(k det(C')) mat(
    delta, -beta;
    -gamma, alpha
  ) = lambda mat(
    delta, -beta;
    -gamma, alpha
  )
$

Where,
$
  lambda = 10/(k det(C')) = 10/(k(alpha delta - beta gamma))
$

Note that, $det(C') = (alpha delta - beta gamma) in ZZ$

Now note that all entries of $D$ must be integers. Since $"GCD"(alpha, beta, gamma, delta) = 1$, this means $k det(C') | 10$. This also means $lambda in {plus.minus 1,plus.minus 2,plus.minus 5,plus.minus 10}$ (Divisors of 10)

Rewriting $B$ in terms of $D$,
$
  B & = D+10I \
  B & = lambda mat(
        delta, -beta;
        -gamma, alpha
      ) +10I \
  B & = mat(
        lambda delta +10, -lambda beta;
        -lambda gamma, lambda alpha +10
      )
$

Similarly A,

$
  A = C+I\
  A = mat(
    k alpha +1, k beta;
    k gamma, k delta +1
  )
$

Now based on our problem we have that $A in M_(2 times 2)(ZZ^+)$ so that,

$k beta >0$ and $k gamma >0$ meaning $beta >0$ and $gamma >0$

Furthermore, $(k alpha +1 >0,k delta +1 >0 )-> (k alpha > -1, k delta >-1)$

Now this mean $alpha>=0$ and $delta>=0$ (because $k>0$ and we are working with integers).

However remember we need restrict $B$ to be single integers so $alpha,delta != 0$.
(If they are then the diagonal entries of $B$ will be 10!).

This means $alpha>0$ and $delta>0$. This ends up meaning that $C$ itself is an entirely positive matrix.

*In otherwords $alpha, beta, gamma, delta >0$ i.e. $C in M_(2 times 2)(ZZ^plus)$*



Now, from the fact that $-lambda beta >=0$ and $-lambda gamma >=0$ coupled with the fact that $beta, gamma >0$ means that $lambda<0$ which also aligns with $lambda delta+10 < 10$ and $lambda alpha +10 <10$.

*Therefor now we have that $lambda in {-1,-2,-5,-10}$ which means that $(alpha delta - beta gamma) <0 -> alpha delta < beta gamma$*

Next we will consider more deeply the restrictions on B. (Here I am using the following abuse of notation to write four inequalities in one go.)

$
  mat(
    0, 0;
    0, 0
  ) & <=mat(
        lambda delta +10, -lambda beta;
        -lambda gamma, lambda alpha +10
      ) & < mat(
            10, 10;
            10, 10;
          ) \
  <==> mat(
    0, 0;
    0, 0
  ) & >=mat(
        delta +10/lambda, - beta;
        - gamma, alpha +10/lambda
      ) & > mat(
            10/lambda, 10/lambda;
            10/lambda, 10/lambda;
          ) \
  <==> mat(
    -10/lambda, 0;
    0, -10/lambda
  ) & >=mat(
        delta, - beta;
        - gamma, alpha
      ) & > mat(
            0, 10/lambda;
            10/lambda, 0;
          ) \
$

So we have the following as _necessary and sufficient conditions on $alpha, beta, gamma,delta$_,

$
  0 & < delta & <= -10/lambda \
  0 & < beta  &  < -10/lambda \
  0 & < gamma &  < -10/lambda \
  0 & < alpha & <= -10/lambda \
$

Now clearly, $lambda =-10$ is not an option (since it doesn't leave any valid choices for $beta$ and $delta$)
So we are left with the cases $lambda in {-1,-2,-5}$ !

Now consider the case where $lambda = -5$,


This results in $k det(C') = -2$, and leads to $delta,alpha in {1,2}$ and $beta=1, gamma=1$

Note that this means,
$
  -(alpha delta - beta gamma) = beta gamma - alpha delta = 1-alpha delta = mu "where" mu in {1,2}
$
This admits no solution for $alpha,delta >0$!

So to summarize,

#important-block[
  $
    A = mat(
      k alpha+1, k beta;
      k gamma, k delta+1
    ) \
    B = mat(
      lambda delta +10, -lambda beta;
      -lambda gamma, lambda alpha +10
    )
  $
  Where $alpha,beta,gamma,delta,lambda,k in ZZ$,
  $
    0 & < delta & <= -10/lambda \
    0 & < beta  &  < -10/lambda \
    0 & < gamma &  < -10/lambda \
    0 & < alpha & <= -10/lambda \
  $
  $
    & lambda in {-1,-2}
  $
  With $k>0$,
  $
    lambda k (alpha delta -beta gamma) = 10
  $

  Which we can rewrite as,
  $
    beta gamma - alpha delta = -10/(lambda k) = mu " "(in ZZ^plus)
  $

  This means that,

  $
    k in cases(
      {1,2,5,10} "if" lambda=-1,
      {1,5} "if" lambda=-2
    )
  $


]


== Some practical examples before we go further!


Consider the case where $lambda =-1$, and  $k=10$ making  $mu=1$.

Then, for example, let $beta =5$ and $alpha=3$.

So here we can get $gamma=2$ and $delta=3$ as as one possible solution. (we have that $5 times 2 - 3 times 3 = 1$.)

This means,

$
  A & = mat(
        10 times 3+1, 10 times 5;
        10 times 2, 10 times 3 +1
      ) = mat(31, 50; 20, 31) \
  B & = mat(
        -1 times 3 +10, -(-1 times 5);
        -(-1 times 2), (-1 times 3+10)
      ) = mat(7, 5; 2, 7)
$

and,

$
  A B = mat(
    317, 505;
    202, 317;
  )
$

We can also find that the example we started with corresponded to $k=2 and lambda=-1$

We can come back to counting the number of solutions later. Right now let's further restrict A!

= What happens if we make entries of $A$ single digit as well? (There is a kind of beauty there no?)

$
  mat(
    k alpha +1, k beta;
    k gamma, k delta+1
  )                    & <= mat(9, 9; 9, 9) \
  mat(
    k alpha, k beta;
    k gamma, k delta
  ) <= mat(8, 9; 9, 8)
$
We immediately observe $k=10$ is not possible anymore,

Consider the case where $k=5$, then $alpha,beta,gamma,delta <=1$ meaning all must be 1, which doesn't lead a valid $mu$. So that is out.

*Consider the case where $k=2$, then
$alpha,beta,gamma,delta <=4$ and $lambda = -1$*


For the case where $k=1$,  we have $alpha,delta<8$ and $gamma, beta <=9$. and rest is the same.

= Counting Solutions.

Now crux of the matter boils down to finding integer solutions to,

$
  beta gamma-alpha delta = mu
$<diophantine>
for different cases of $lambda$ and $k$. This is a Diophantine equation!

Also note that we still have the condition $"GCD"(alpha, beta, gamma, delta)=1$. However as we shall see this turns out to be not of concern.

Assume we find a set of solutions $alpha', beta', gamma', delta'$ whose GCD is not 1 and is $"GCD"(alpha',beta',gamma',delta')=g !=1$. Then, $alpha'=g alpha'', beta'=g beta'', gamma'=g gamma'', delta'=g delta''$

$
  g^2 (beta''gamma''-alpha''delta'') = mu
$

meaning $g^2 | mu$. However, noting that $mu in {1,2,5,10}$ this is impossible. Therefore, there exist no solutions where $"GCD"(alpha, beta, gamma,delta) != 1$ and we can ignore that constraint.

Since there is a bijection between $alpha,beta,gamma,delta$ and the two matrices $A,B$
it is sufficient to count the unique solutions to $alpha,beta,gamma,delta$ that satisfy the constraints.

This is a sufficiently small problem that we can find all solutions through brute force. (Roughly on the order of $10^4$)


Apparently there are *458 such solutions!*

If we consider the case where $A$ is constrained to be single integers, there are *exactly 100 solutions*


= Additional Note: on Counting Solution
In fact we can do better that considering all possible combinations of the parameters.

If we fix two of the parameters such as $beta, alpha$ and $mu$ in the Diophantine equation it becomes a linear Diophantine equation
$
  beta x- alpha y = mu
$

whose solutions can be found using the extended euclidean algorithm.

if $"GCD"(alpha,beta) divides.not mu$ then there are no solutions,

otherwise, if $"GCD"(alpha,beta) = g$
$
  x = x_0 mu/g + alpha/g t\
  y = y_0 mu/g+ beta/g t
$
Where $x_0,y_0$ are found through extended euclidean algorithm for $alpha,beta$.

Then number of solutions for the specific can be found by solving the inequalities,

$
  gamma_min < x_0 mu/g + alpha/g t < gamma_max\
  delta_min < y_0 mu/g+ beta/g t <delta_max
$

and then simply iterate over the all the possibilities for $alpha,beta$ and $mu$.

However, even without this optimization, the search space is small enough to just search so we will not use this optimization.

= Additional Note: Brute Force Verification of the Single Integer Case.

For the case where $A$ is constrained to a single integer matrix, the search space is roughly $10^8$. So although we quite large we can brute force it leveraging parallelizing abilities of modern cpus (or even gpus) to check our counting for the single integer case

*And indeed, we get that the number of solutions is 100*

= Single digit A solutions

$
  [mat(delim: #none, 2, 2; 6, 3)] times [mat(delim: #none, 8, 2; 6, 9)] = [mat(delim: #none, 28, 22; 66, 39)] \ [mat(delim: #none, 2, 2; 7, 5)] times [mat(delim: #none, 6, 2; 7, 9)] = [mat(delim: #none, 26, 22; 77, 59)] \ [mat(delim: #none, 2, 2; 8, 7)] times [mat(delim: #none, 4, 2; 8, 9)] = [mat(delim: #none, 24, 22; 88, 79)] \ [mat(delim: #none, 2, 2; 9, 9)] times [mat(delim: #none, 2, 2; 9, 9)] = [mat(delim: #none, 22, 22; 99, 99)] \ [mat(delim: #none, 2, 3; 4, 3)] times [mat(delim: #none, 8, 3; 4, 9)] = [mat(delim: #none, 28, 33; 44, 39)] \ [mat(delim: #none, 2, 3; 5, 6)] times [mat(delim: #none, 5, 3; 5, 9)] = [mat(delim: #none, 25, 33; 55, 69)] \ [mat(delim: #none, 2, 3; 6, 9)] times [mat(delim: #none, 2, 3; 6, 9)] = [mat(delim: #none, 22, 33; 66, 99)] \ [mat(delim: #none, 2, 4; 3, 3)] times [mat(delim: #none, 8, 4; 3, 9)] = [mat(delim: #none, 28, 44; 33, 39)] \ [mat(delim: #none, 2, 4; 4, 7)] times [mat(delim: #none, 4, 4; 4, 9)] = [mat(delim: #none, 24, 44; 44, 79)] \ [mat(delim: #none, 2, 5; 3, 6)] times [mat(delim: #none, 5, 5; 3, 9)] = [mat(delim: #none, 25, 55; 33, 69)] \ [mat(delim: #none, 2, 6; 2, 3)] times [mat(delim: #none, 8, 6; 2, 9)] = [mat(delim: #none, 28, 66; 22, 39)] \ [mat(delim: #none, 2, 6; 3, 9)] times [mat(delim: #none, 2, 6; 3, 9)] = [mat(delim: #none, 22, 66; 33, 99)] \ [mat(delim: #none, 2, 7; 2, 5)] times [mat(delim: #none, 6, 7; 2, 9)] = [mat(delim: #none, 26, 77; 22, 59)] \
  [mat(delim: #none, 2, 8; 2, 7)] times [mat(delim: #none, 4, 8; 2, 9)] = [mat(delim: #none, 24, 88; 22, 79)] \ [mat(delim: #none, 2, 9; 2, 9)] times [mat(delim: #none, 2, 9; 2, 9)] = [mat(delim: #none, 22, 99; 22, 99)] \ [mat(delim: #none, 3, 2; 6, 2)] times [mat(delim: #none, 9, 2; 6, 8)] = [mat(delim: #none, 39, 22; 66, 28)] \ [mat(delim: #none, 3, 2; 7, 3)] times [mat(delim: #none, 8, 2; 7, 8)] = [mat(delim: #none, 38, 22; 77, 38)] \ [mat(delim: #none, 3, 2; 8, 4)] times [mat(delim: #none, 7, 2; 8, 8)] = [mat(delim: #none, 37, 22; 88, 48)] \ [mat(delim: #none, 3, 2; 9, 5)] times [mat(delim: #none, 6, 2; 9, 8)] = [mat(delim: #none, 36, 22; 99, 58)] \ [mat(delim: #none, 3, 3; 4, 2)] times [mat(delim: #none, 9, 3; 4, 8)] = [mat(delim: #none, 39, 33; 44, 28)] \ [mat(delim: #none, 3, 3; 6, 5)] times [mat(delim: #none, 6, 3; 6, 8)] = [mat(delim: #none, 36, 33; 66, 58)] \ [mat(delim: #none, 3, 3; 8, 8)] times [mat(delim: #none, 3, 3; 8, 8)] = [mat(delim: #none, 33, 33; 88, 88)] \ [mat(delim: #none, 3, 4; 3, 2)] times [mat(delim: #none, 9, 4; 3, 8)] = [mat(delim: #none, 39, 44; 33, 28)] \ [mat(delim: #none, 3, 4; 4, 4)] times [mat(delim: #none, 7, 4; 4, 8)] = [mat(delim: #none, 37, 44; 44, 48)] \ [mat(delim: #none, 3, 4; 5, 6)] times [mat(delim: #none, 5, 4; 5, 8)] = [mat(delim: #none, 35, 44; 55, 68)] \
  [mat(delim: #none, 3, 4; 6, 8)] times [mat(delim: #none, 3, 4; 6, 8)] = [mat(delim: #none, 33, 44; 66, 88)] \ [mat(delim: #none, 3, 5; 4, 6)] times [mat(delim: #none, 5, 5; 4, 8)] = [mat(delim: #none, 35, 55; 44, 68)] \ [mat(delim: #none, 3, 6; 2, 2)] times [mat(delim: #none, 9, 6; 2, 8)] = [mat(delim: #none, 39, 66; 22, 28)] \ [mat(delim: #none, 3, 6; 3, 5)] times [mat(delim: #none, 6, 6; 3, 8)] = [mat(delim: #none, 36, 66; 33, 58)] \ [mat(delim: #none, 3, 6; 4, 8)] times [mat(delim: #none, 3, 6; 4, 8)] = [mat(delim: #none, 33, 66; 44, 88)] \ [mat(delim: #none, 3, 7; 2, 3)] times [mat(delim: #none, 8, 7; 2, 8)] = [mat(delim: #none, 38, 77; 22, 38)] \ [mat(delim: #none, 3, 8; 2, 4)] times [mat(delim: #none, 7, 8; 2, 8)] = [mat(delim: #none, 37, 88; 22, 48)] \ [mat(delim: #none, 3, 8; 3, 8)] times [mat(delim: #none, 3, 8; 3, 8)] = [mat(delim: #none, 33, 88; 33, 88)] \ [mat(delim: #none, 3, 9; 2, 5)] times [mat(delim: #none, 6, 9; 2, 8)] = [mat(delim: #none, 36, 99; 22, 58)] \ [mat(delim: #none, 4, 2; 8, 3)] times [mat(delim: #none, 8, 2; 8, 7)] = [mat(delim: #none, 48, 22; 88, 37)] \ [mat(delim: #none, 4, 4; 4, 3)] times [mat(delim: #none, 8, 4; 4, 7)] = [mat(delim: #none, 48, 44; 44, 37)] \ [mat(delim: #none, 4, 4; 7, 7)] times [mat(delim: #none, 4, 4; 7, 7)] = [mat(delim: #none, 44, 44; 77, 77)] \ [mat(delim: #none, 4, 5; 5, 6)] times [mat(delim: #none, 5, 5; 5, 7)] = [mat(delim: #none, 45, 55; 55, 67)] \ [mat(delim: #none, 4, 7; 4, 7)] times [mat(delim: #none, 4, 7; 4, 7)] = [mat(delim: #none, 44, 77; 44, 77)] \ [mat(delim: #none, 4, 8; 2, 3)] times [mat(delim: #none, 8, 8; 2, 7)] = [mat(delim: #none, 48, 88; 22, 37)] \ [mat(delim: #none, 5, 2; 7, 2)] times [mat(delim: #none, 9, 2; 7, 6)] = [mat(delim: #none, 59, 22; 77, 26)] \ [mat(delim: #none, 5, 2; 9, 3)] times [mat(delim: #none, 8, 2; 9, 6)] = [mat(delim: #none, 58, 22; 99, 36)] \ [mat(delim: #none, 5, 3; 6, 3)] times [mat(delim: #none, 8, 3; 6, 6)] = [mat(delim: #none, 58, 33; 66, 36)] \ [mat(delim: #none, 5, 5; 6, 6)] times [mat(delim: #none, 5, 5; 6, 6)] = [mat(delim: #none, 55, 55; 66, 66)] \ [mat(delim: #none, 5, 6; 3, 3)] times [mat(delim: #none, 8, 6; 3, 6)] = [mat(delim: #none, 58, 66; 33, 36)] \ [mat(delim: #none, 5, 6; 5, 6)] times [mat(delim: #none, 5, 6; 5, 6)] = [mat(delim: #none, 55, 66; 55, 66)] \ [mat(delim: #none, 5, 6; 7, 9)] times [mat(delim: #none, 2, 6; 7, 6)] = [mat(delim: #none, 52, 66; 77, 96)] \ [mat(delim: #none, 5, 7; 2, 2)] times [mat(delim: #none, 9, 7; 2, 6)] = [mat(delim: #none, 59, 77; 22, 26)] \ [mat(delim: #none, 5, 7; 6, 9)] times [mat(delim: #none, 2, 7; 6, 6)] = [mat(delim: #none, 52, 77; 66, 96)] \ [mat(delim: #none, 5, 9; 2, 3)] times [mat(delim: #none, 8, 9; 2, 6)] = [mat(delim: #none, 58, 99; 22, 36)] \ [mat(delim: #none, 6, 3; 5, 2)] times [mat(delim: #none, 9, 3; 5, 5)] = [mat(delim: #none, 69, 33; 55, 25)] \ [mat(delim: #none, 6, 4; 5, 3)] times [mat(delim: #none, 8, 4; 5, 5)] = [mat(delim: #none, 68, 44; 55, 35)] \ [mat(delim: #none, 6, 5; 3, 2)] times [mat(delim: #none, 9, 5; 3, 5)] = [mat(delim: #none, 69, 55; 33, 25)] \ [mat(delim: #none, 6, 5; 4, 3)] times [mat(delim: #none, 8, 5; 4, 5)] = [mat(delim: #none, 68, 55; 44, 35)] \ [mat(delim: #none, 6, 5; 5, 4)] times [mat(delim: #none, 7, 5; 5, 5)] = [mat(delim: #none, 67, 55; 55, 45)] \ [mat(delim: #none, 6, 5; 6, 5)] times [mat(delim: #none, 6, 5; 6, 5)] = [mat(delim: #none, 66, 55; 66, 55)] \ [mat(delim: #none, 6, 5; 7, 6)] times [mat(delim: #none, 5, 5; 7, 5)] = [mat(delim: #none, 65, 55; 77, 65)] \ [mat(delim: #none, 6, 5; 8, 7)] times [mat(delim: #none, 4, 5; 8, 5)] = [mat(delim: #none, 64, 55; 88, 75)] \ [mat(delim: #none, 6, 5; 9, 8)] times [mat(delim: #none, 3, 5; 9, 5)] = [mat(delim: #none, 63, 55; 99, 85)] \ [mat(delim: #none, 6, 6; 5, 5)] times [mat(delim: #none, 6, 6; 5, 5)] = [mat(delim: #none, 66, 66; 55, 55)] \ [mat(delim: #none, 6, 7; 5, 6)] times [mat(delim: #none, 5, 7; 5, 5)] = [mat(delim: #none, 65, 77; 55, 65)] \ [mat(delim: #none, 6, 8; 5, 7)] times [mat(delim: #none, 4, 8; 5, 5)] = [mat(delim: #none, 64, 88; 55, 75)] \ [mat(delim: #none, 6, 9; 5, 8)] times [mat(delim: #none, 3, 9; 5, 5)] = [mat(delim: #none, 63, 99; 55, 85)] \ [mat(delim: #none, 7, 2; 8, 2)] times [mat(delim: #none, 9, 2; 8, 4)] = [mat(delim: #none, 79, 22; 88, 24)] \ [mat(delim: #none, 7, 4; 4, 2)] times [mat(delim: #none, 9, 4; 4, 4)] = [mat(delim: #none, 79, 44; 44, 24)] \ [mat(delim: #none, 7, 4; 7, 4)] times [mat(delim: #none, 7, 4; 7, 4)] = [mat(delim: #none, 77, 44; 77, 44)] \ [mat(delim: #none, 7, 5; 8, 6)] times [mat(delim: #none, 5, 5; 8, 4)] = [mat(delim: #none, 75, 55; 88, 64)] \ [mat(delim: #none, 7, 7; 4, 4)] times [mat(delim: #none, 7, 7; 4, 4)] = [mat(delim: #none, 77, 77; 44, 44)] \ [mat(delim: #none, 7, 8; 2, 2)] times [mat(delim: #none, 9, 8; 2, 4)] = [mat(delim: #none, 79, 88; 22, 24)] \ [mat(delim: #none, 7, 8; 5, 6)] times [mat(delim: #none, 5, 8; 5, 4)] = [mat(delim: #none, 75, 88; 55, 64)] \ [mat(delim: #none, 8, 3; 8, 3)] times [mat(delim: #none, 8, 3; 8, 3)] = [mat(delim: #none, 88, 33; 88, 33)] \ [mat(delim: #none, 8, 4; 6, 3)] times [mat(delim: #none, 8, 4; 6, 3)] = [mat(delim: #none, 88, 44; 66, 33)] \ [mat(delim: #none, 8, 5; 9, 6)] times [mat(delim: #none, 5, 5; 9, 3)] = [mat(delim: #none, 85, 55; 99, 63)] \ [mat(delim: #none, 8, 6; 4, 3)] times [mat(delim: #none, 8, 6; 4, 3)] = [mat(delim: #none, 88, 66; 44, 33)] \ [mat(delim: #none, 8, 8; 3, 3)] times [mat(delim: #none, 8, 8; 3, 3)] = [mat(delim: #none, 88, 88; 33, 33)] \ [mat(delim: #none, 8, 9; 5, 6)] times [mat(delim: #none, 5, 9; 5, 3)] = [mat(delim: #none, 85, 99; 55, 63)] \ [mat(delim: #none, 9, 2; 9, 2)] times [mat(delim: #none, 9, 2; 9, 2)] = [mat(delim: #none, 99, 22; 99, 22)] \ [mat(delim: #none, 9, 3; 6, 2)] times [mat(delim: #none, 9, 3; 6, 2)] = [mat(delim: #none, 99, 33; 66, 22)] \ [mat(delim: #none, 9, 6; 3, 2)] times [mat(delim: #none, 9, 6; 3, 2)] = [mat(delim: #none, 99, 66; 33, 22)] \ [mat(delim: #none, 9, 6; 7, 5)] times [mat(delim: #none, 6, 6; 7, 2)] = [mat(delim: #none, 96, 66; 77, 52)] \ [mat(delim: #none, 9, 7; 6, 5)] times [mat(delim: #none, 6, 7; 6, 2)] = [mat(delim: #none, 96, 77; 66, 52)] \ [mat(delim: #none, 9, 9; 2, 2)] times [mat(delim: #none, 9, 9; 2, 2)] = [mat(delim: #none, 99, 99; 22, 22)] \ [mat(delim: #none, 3, 4; 6, 3)] times [mat(delim: #none, 9, 2; 3, 9)] = [mat(delim: #none, 39, 42; 63, 39)] \ [mat(delim: #none, 3, 4; 8, 7)] times [mat(delim: #none, 7, 2; 4, 9)] = [mat(delim: #none, 37, 42; 84, 79)] \ [mat(delim: #none, 3, 6; 4, 3)] times [mat(delim: #none, 9, 3; 2, 9)] = [mat(delim: #none, 39, 63; 42, 39)] \ [mat(delim: #none, 3, 6; 6, 9)] times [mat(delim: #none, 6, 3; 3, 9)] = [mat(delim: #none, 36, 63; 63, 99)] \ [mat(delim: #none, 3, 8; 4, 7)] times [mat(delim: #none, 7, 4; 2, 9)] = [mat(delim: #none, 37, 84; 42, 79)] \ [mat(delim: #none, 5, 6; 6, 5)] times [mat(delim: #none, 8, 3; 3, 8)] = [mat(delim: #none, 58, 63; 63, 58)] \ [mat(delim: #none, 7, 4; 8, 3)] times [mat(delim: #none, 9, 2; 4, 7)] = [mat(delim: #none, 79, 42; 84, 37)] \ [mat(delim: #none, 7, 8; 4, 3)] times [mat(delim: #none, 9, 4; 2, 7)] = [mat(delim: #none, 79, 84; 42, 37)] \ [mat(delim: #none, 9, 6; 6, 3)] times [mat(delim: #none, 9, 3; 3, 6)] = [mat(delim: #none, 99, 63; 63, 36)] \ [mat(delim: #none, 2, 2; 3, 2)] times [mat(delim: #none, 8, 4; 6, 8)] = [mat(delim: #none, 28, 24; 36, 28)] \ [mat(delim: #none, 2, 2; 4, 4)] times [mat(delim: #none, 4, 4; 8, 8)] = [mat(delim: #none, 24, 24; 48, 48)] \ [mat(delim: #none, 2, 3; 2, 2)] times [mat(delim: #none, 8, 6; 4, 8)] = [mat(delim: #none, 28, 36; 24, 28)] \ [mat(delim: #none, 2, 3; 3, 5)] times [mat(delim: #none, 2, 6; 6, 8)] = [mat(delim: #none, 22, 36; 36, 58)] \
  [mat(delim: #none, 2, 4; 2, 4)] times [mat(delim: #none, 4, 8; 4, 8)] = [mat(delim: #none, 24, 48; 24, 48)] \ [mat(delim: #none, 3, 3; 3, 3)] times [mat(delim: #none, 6, 6; 6, 6)] = [mat(delim: #none, 36, 36; 36, 36)] \ [mat(delim: #none, 4, 2; 4, 2)] times [mat(delim: #none, 8, 4; 8, 4)] = [mat(delim: #none, 48, 24; 48, 24)] \ [mat(delim: #none, 4, 4; 2, 2)] times [mat(delim: #none, 8, 8; 4, 4)] = [mat(delim: #none, 48, 48; 24, 24)] \ [mat(delim: #none, 5, 3; 3, 2)] times [mat(delim: #none, 8, 6; 6, 2)] = [mat(delim: #none, 58, 36; 36, 22)]
$

= Unconstrained Solutions
$
  [mat(delim: #none, 2, 2; 6, 3)] times [mat(delim: #none, 8, 2; 6, 9)] = [mat(delim: #none, 28, 22; 66, 39)] \ [mat(delim: #none, 2, 2; 7, 5)] times [mat(delim: #none, 6, 2; 7, 9)] = [mat(delim: #none, 26, 22; 77, 59)] \ [mat(delim: #none, 2, 2; 8, 7)] times [mat(delim: #none, 4, 2; 8, 9)] = [mat(delim: #none, 24, 22; 88, 79)] \ [mat(delim: #none, 2, 2; 9, 9)] times [mat(delim: #none, 2, 2; 9, 9)] = [mat(delim: #none, 22, 22; 99, 99)] \ [mat(delim: #none, 2, 3; 4, 3)] times [mat(delim: #none, 8, 3; 4, 9)] = [mat(delim: #none, 28, 33; 44, 39)] \ [mat(delim: #none, 2, 3; 5, 6)] times [mat(delim: #none, 5, 3; 5, 9)] = [mat(delim: #none, 25, 33; 55, 69)] \ [mat(delim: #none, 2, 3; 6, 9)] times [mat(delim: #none, 2, 3; 6, 9)] = [mat(delim: #none, 22, 33; 66, 99)] \ [mat(delim: #none, 2, 4; 3, 3)] times [mat(delim: #none, 8, 4; 3, 9)] = [mat(delim: #none, 28, 44; 33, 39)] \ [mat(delim: #none, 2, 4; 4, 7)] times [mat(delim: #none, 4, 4; 4, 9)] = [mat(delim: #none, 24, 44; 44, 79)] \ [mat(delim: #none, 2, 4; 5, 11)] times [mat(delim: #none, 0, 4; 5, 9)] = [mat(delim: #none, 20, 44; 55, 119)] \ [mat(delim: #none, 2, 5; 3, 6)] times [mat(delim: #none, 5, 5; 3, 9)] = [mat(delim: #none, 25, 55; 33, 69)] \ [mat(delim: #none, 2, 5; 4, 11)] times [mat(delim: #none, 0, 5; 4, 9)] = [mat(delim: #none, 20, 55; 44, 119)] \ [mat(delim: #none, 2, 6; 2, 3)] times [mat(delim: #none, 8, 6; 2, 9)] = [mat(delim: #none, 28, 66; 22, 39)] \ [mat(delim: #none, 2, 6; 3, 9)] times [mat(delim: #none, 2, 6; 3, 9)] = [mat(delim: #none, 22, 66; 33, 99)] \ [mat(delim: #none, 2, 7; 2, 5)] times [mat(delim: #none, 6, 7; 2, 9)] = [mat(delim: #none, 26, 77; 22, 59)] \ [mat(delim: #none, 2, 8; 2, 7)] times [mat(delim: #none, 4, 8; 2, 9)] = [mat(delim: #none, 24, 88; 22, 79)] \ [mat(delim: #none, 2, 9; 2, 9)] times [mat(delim: #none, 2, 9; 2, 9)] = [mat(delim: #none, 22, 99; 22, 99)] \ [mat(delim: #none, 3, 2; 6, 2)] times [mat(delim: #none, 9, 2; 6, 8)] = [mat(delim: #none, 39, 22; 66, 28)] \ [mat(delim: #none, 3, 2; 7, 3)] times [mat(delim: #none, 8, 2; 7, 8)] = [mat(delim: #none, 38, 22; 77, 38)] \ [mat(delim: #none, 3, 2; 8, 4)] times [mat(delim: #none, 7, 2; 8, 8)] = [mat(delim: #none, 37, 22; 88, 48)] \ [mat(delim: #none, 3, 2; 9, 5)] times [mat(delim: #none, 6, 2; 9, 8)] = [mat(delim: #none, 36, 22; 99, 58)] \ [mat(delim: #none, 3, 3; 4, 2)] times [mat(delim: #none, 9, 3; 4, 8)] = [mat(delim: #none, 39, 33; 44, 28)] \ [mat(delim: #none, 3, 3; 6, 5)] times [mat(delim: #none, 6, 3; 6, 8)] = [mat(delim: #none, 36, 33; 66, 58)] \ [mat(delim: #none, 3, 3; 8, 8)] times [mat(delim: #none, 3, 3; 8, 8)] = [mat(delim: #none, 33, 33; 88, 88)] \ [mat(delim: #none, 3, 4; 3, 2)] times [mat(delim: #none, 9, 4; 3, 8)] = [mat(delim: #none, 39, 44; 33, 28)] \ [mat(delim: #none, 3, 4; 4, 4)] times [mat(delim: #none, 7, 4; 4, 8)] = [mat(delim: #none, 37, 44; 44, 48)] \ [mat(delim: #none, 3, 4; 5, 6)] times [mat(delim: #none, 5, 4; 5, 8)] = [mat(delim: #none, 35, 44; 55, 68)] \ [mat(delim: #none, 3, 4; 6, 8)] times [mat(delim: #none, 3, 4; 6, 8)] = [mat(delim: #none, 33, 44; 66, 88)] \ [mat(delim: #none, 3, 4; 7, 10)] times [mat(delim: #none, 1, 4; 7, 8)] = [mat(delim: #none, 31, 44; 77, 108)] \ [mat(delim: #none, 3, 5; 4, 6)] times [mat(delim: #none, 5, 5; 4, 8)] = [mat(delim: #none, 35, 55; 44, 68)] \ [mat(delim: #none, 3, 5; 6, 11)] times [mat(delim: #none, 0, 5; 6, 8)] = [mat(delim: #none, 30, 55; 66, 118)] \ [mat(delim: #none, 3, 6; 2, 2)] times [mat(delim: #none, 9, 6; 2, 8)] = [mat(delim: #none, 39, 66; 22, 28)] \ [mat(delim: #none, 3, 6; 3, 5)] times [mat(delim: #none, 6, 6; 3, 8)] = [mat(delim: #none, 36, 66; 33, 58)] \ [mat(delim: #none, 3, 6; 4, 8)] times [mat(delim: #none, 3, 6; 4, 8)] = [mat(delim: #none, 33, 66; 44, 88)] \ [mat(delim: #none, 3, 6; 5, 11)] times [mat(delim: #none, 0, 6; 5, 8)] = [mat(delim: #none, 30, 66; 55, 118)] \ [mat(delim: #none, 3, 7; 2, 3)] times [mat(delim: #none, 8, 7; 2, 8)] = [mat(delim: #none, 38, 77; 22, 38)] \ [mat(delim: #none, 3, 7; 4, 10)] times [mat(delim: #none, 1, 7; 4, 8)] = [mat(delim: #none, 31, 77; 44, 108)] \ [mat(delim: #none, 3, 8; 2, 4)] times [mat(delim: #none, 7, 8; 2, 8)] = [mat(delim: #none, 37, 88; 22, 48)] \ [mat(delim: #none, 3, 8; 3, 8)] times [mat(delim: #none, 3, 8; 3, 8)] = [mat(delim: #none, 33, 88; 33, 88)] \ [mat(delim: #none, 3, 9; 2, 5)] times [mat(delim: #none, 6, 9; 2, 8)] = [mat(delim: #none, 36, 99; 22, 58)] \ [mat(delim: #none, 4, 2; 8, 3)] times [mat(delim: #none, 8, 2; 8, 7)] = [mat(delim: #none, 48, 22; 88, 37)] \ [mat(delim: #none, 4, 4; 4, 3)] times [mat(delim: #none, 8, 4; 4, 7)] = [mat(delim: #none, 48, 44; 44, 37)] \ [mat(delim: #none, 4, 4; 7, 7)] times [mat(delim: #none, 4, 4; 7, 7)] = [mat(delim: #none, 44, 44; 77, 77)] \ [mat(delim: #none, 4, 5; 5, 6)] times [mat(delim: #none, 5, 5; 5, 7)] = [mat(delim: #none, 45, 55; 55, 67)] \ [mat(delim: #none, 4, 5; 8, 11)] times [mat(delim: #none, 0, 5; 8, 7)] = [mat(delim: #none, 40, 55; 88, 117)] \ [mat(delim: #none, 4, 7; 4, 7)] times [mat(delim: #none, 4, 7; 4, 7)] = [mat(delim: #none, 44, 77; 44, 77)] \ [mat(delim: #none, 4, 8; 2, 3)] times [mat(delim: #none, 8, 8; 2, 7)] = [mat(delim: #none, 48, 88; 22, 37)] \ [mat(delim: #none, 4, 8; 5, 11)] times [mat(delim: #none, 0, 8; 5, 7)] = [mat(delim: #none, 40, 88; 55, 117)] \ [mat(delim: #none, 5, 2; 7, 2)] times [mat(delim: #none, 9, 2; 7, 6)] = [mat(delim: #none, 59, 22; 77, 26)] \ [mat(delim: #none, 5, 2; 9, 3)] times [mat(delim: #none, 8, 2; 9, 6)] = [mat(delim: #none, 58, 22; 99, 36)] \ [mat(delim: #none, 5, 3; 6, 3)] times [mat(delim: #none, 8, 3; 6, 6)] = [mat(delim: #none, 58, 33; 66, 36)] \ [mat(delim: #none, 5, 5; 6, 6)] times [mat(delim: #none, 5, 5; 6, 6)] = [mat(delim: #none, 55, 55; 66, 66)] \ [mat(delim: #none, 5, 6; 3, 3)] times [mat(delim: #none, 8, 6; 3, 6)] = [mat(delim: #none, 58, 66; 33, 36)] \ [mat(delim: #none, 5, 6; 5, 6)] times [mat(delim: #none, 5, 6; 5, 6)] = [mat(delim: #none, 55, 66; 55, 66)] \ [mat(delim: #none, 5, 6; 7, 9)] times [mat(delim: #none, 2, 6; 7, 6)] = [mat(delim: #none, 52, 66; 77, 96)] \ [mat(delim: #none, 5, 7; 2, 2)] times [mat(delim: #none, 9, 7; 2, 6)] = [mat(delim: #none, 59, 77; 22, 26)] \ [mat(delim: #none, 5, 7; 6, 9)] times [mat(delim: #none, 2, 7; 6, 6)] = [mat(delim: #none, 52, 77; 66, 96)] \ [mat(delim: #none, 5, 9; 2, 3)] times [mat(delim: #none, 8, 9; 2, 6)] = [mat(delim: #none, 58, 99; 22, 36)] \ [mat(delim: #none, 6, 3; 5, 2)] times [mat(delim: #none, 9, 3; 5, 5)] = [mat(delim: #none, 69, 33; 55, 25)] \ [mat(delim: #none, 6, 4; 5, 3)] times [mat(delim: #none, 8, 4; 5, 5)] = [mat(delim: #none, 68, 44; 55, 35)] \ [mat(delim: #none, 6, 5; 3, 2)] times [mat(delim: #none, 9, 5; 3, 5)] = [mat(delim: #none, 69, 55; 33, 25)] \ [mat(delim: #none, 6, 5; 4, 3)] times [mat(delim: #none, 8, 5; 4, 5)] = [mat(delim: #none, 68, 55; 44, 35)] \ [mat(delim: #none, 6, 5; 5, 4)] times [mat(delim: #none, 7, 5; 5, 5)] = [mat(delim: #none, 67, 55; 55, 45)] \ [mat(delim: #none, 6, 5; 6, 5)] times [mat(delim: #none, 6, 5; 6, 5)] = [mat(delim: #none, 66, 55; 66, 55)] \ [mat(delim: #none, 6, 5; 7, 6)] times [mat(delim: #none, 5, 5; 7, 5)] = [mat(delim: #none, 65, 55; 77, 65)] \ [mat(delim: #none, 6, 5; 8, 7)] times [mat(delim: #none, 4, 5; 8, 5)] = [mat(delim: #none, 64, 55; 88, 75)] \ [mat(delim: #none, 6, 5; 9, 8)] times [mat(delim: #none, 3, 5; 9, 5)] = [mat(delim: #none, 63, 55; 99, 85)] \ [mat(delim: #none, 6, 6; 5, 5)] times [mat(delim: #none, 6, 6; 5, 5)] = [mat(delim: #none, 66, 66; 55, 55)] \ [mat(delim: #none, 6, 7; 5, 6)] times [mat(delim: #none, 5, 7; 5, 5)] = [mat(delim: #none, 65, 77; 55, 65)] \ [mat(delim: #none, 6, 8; 5, 7)] times [mat(delim: #none, 4, 8; 5, 5)] = [mat(delim: #none, 64, 88; 55, 75)] \ [mat(delim: #none, 6, 9; 5, 8)] times [mat(delim: #none, 3, 9; 5, 5)] = [mat(delim: #none, 63, 99; 55, 85)] \ [mat(delim: #none, 7, 2; 8, 2)] times [mat(delim: #none, 9, 2; 8, 4)] = [mat(delim: #none, 79, 22; 88, 24)] \ [mat(delim: #none, 7, 4; 4, 2)] times [mat(delim: #none, 9, 4; 4, 4)] = [mat(delim: #none, 79, 44; 44, 24)] \ [mat(delim: #none, 7, 4; 7, 4)] times [mat(delim: #none, 7, 4; 7, 4)] = [mat(delim: #none, 77, 44; 77, 44)] \ [mat(delim: #none, 7, 5; 8, 6)] times [mat(delim: #none, 5, 5; 8, 4)] = [mat(delim: #none, 75, 55; 88, 64)] \ [mat(delim: #none, 7, 7; 4, 4)] times [mat(delim: #none, 7, 7; 4, 4)] = [mat(delim: #none, 77, 77; 44, 44)] \ [mat(delim: #none, 7, 8; 2, 2)] times [mat(delim: #none, 9, 8; 2, 4)] = [mat(delim: #none, 79, 88; 22, 24)] \ [mat(delim: #none, 7, 8; 5, 6)] times [mat(delim: #none, 5, 8; 5, 4)] = [mat(delim: #none, 75, 88; 55, 64)] \ [mat(delim: #none, 7, 8; 8, 10)] times [mat(delim: #none, 1, 8; 8, 4)] = [mat(delim: #none, 71, 88; 88, 104)] \ [mat(delim: #none, 8, 3; 8, 3)] times [mat(delim: #none, 8, 3; 8, 3)] = [mat(delim: #none, 88, 33; 88, 33)] \ [mat(delim: #none, 8, 4; 6, 3)] times [mat(delim: #none, 8, 4; 6, 3)] = [mat(delim: #none, 88, 44; 66, 33)] \ [mat(delim: #none, 8, 5; 9, 6)] times [mat(delim: #none, 5, 5; 9, 3)] = [mat(delim: #none, 85, 55; 99, 63)] \ [mat(delim: #none, 8, 6; 4, 3)] times [mat(delim: #none, 8, 6; 4, 3)] = [mat(delim: #none, 88, 66; 44, 33)] \ [mat(delim: #none, 8, 8; 3, 3)] times [mat(delim: #none, 8, 8; 3, 3)] = [mat(delim: #none, 88, 88; 33, 33)] \ [mat(delim: #none, 8, 9; 5, 6)] times [mat(delim: #none, 5, 9; 5, 3)] = [mat(delim: #none, 85, 99; 55, 63)] \ [mat(delim: #none, 9, 2; 9, 2)] times [mat(delim: #none, 9, 2; 9, 2)] = [mat(delim: #none, 99, 22; 99, 22)] \ [mat(delim: #none, 9, 3; 6, 2)] times [mat(delim: #none, 9, 3; 6, 2)] = [mat(delim: #none, 99, 33; 66, 22)] \ [mat(delim: #none, 9, 6; 3, 2)] times [mat(delim: #none, 9, 6; 3, 2)] = [mat(delim: #none, 99, 66; 33, 22)] \ [mat(delim: #none, 9, 6; 7, 5)] times [mat(delim: #none, 6, 6; 7, 2)] = [mat(delim: #none, 96, 66; 77, 52)] \ [mat(delim: #none, 9, 7; 6, 5)] times [mat(delim: #none, 6, 7; 6, 2)] = [mat(delim: #none, 96, 77; 66, 52)] \ [mat(delim: #none, 9, 9; 2, 2)] times [mat(delim: #none, 9, 9; 2, 2)] = [mat(delim: #none, 99, 99; 22, 22)] \ [mat(delim: #none, 10, 4; 7, 3)] times [mat(delim: #none, 8, 4; 7, 1)] = [mat(delim: #none, 108, 44; 77, 31)] \ [mat(delim: #none, 10, 7; 4, 3)] times [mat(delim: #none, 8, 7; 4, 1)] = [mat(delim: #none, 108, 77; 44, 31)] \ [mat(delim: #none, 10, 8; 8, 7)] times [mat(delim: #none, 4, 8; 8, 1)] = [mat(delim: #none, 104, 88; 88, 71)] \ [mat(delim: #none, 11, 4; 5, 2)] times [mat(delim: #none, 9, 4; 5, 0)] = [mat(delim: #none, 119, 44; 55, 20)] \ [mat(delim: #none, 11, 5; 4, 2)] times [mat(delim: #none, 9, 5; 4, 0)] = [mat(delim: #none, 119, 55; 44, 20)] \ [mat(delim: #none, 11, 5; 6, 3)] times [mat(delim: #none, 8, 5; 6, 0)] = [mat(delim: #none, 118, 55; 66, 30)] \ [mat(delim: #none, 11, 5; 8, 4)] times [mat(delim: #none, 7, 5; 8, 0)] = [mat(delim: #none, 117, 55; 88, 40)] \ [mat(delim: #none, 11, 6; 5, 3)] times [mat(delim: #none, 8, 6; 5, 0)] = [mat(delim: #none, 118, 66; 55, 30)] \ [mat(delim: #none, 11, 8; 5, 4)] times [mat(delim: #none, 7, 8; 5, 0)] = [mat(delim: #none, 117, 88; 55, 40)] \ [mat(delim: #none, 3, 2; 12, 3)] times [mat(delim: #none, 9, 1; 6, 9)] = [mat(delim: #none, 39, 21; 126, 39)] \ [mat(delim: #none, 3, 2; 14, 5)] times [mat(delim: #none, 8, 1; 7, 9)] = [mat(delim: #none, 38, 21; 147, 59)] \ [mat(delim: #none, 3, 2; 16, 7)] times [mat(delim: #none, 7, 1; 8, 9)] = [mat(delim: #none, 37, 21; 168, 79)] \ [mat(delim: #none, 3, 2; 18, 9)] times [mat(delim: #none, 6, 1; 9, 9)] = [mat(delim: #none, 36, 21; 189, 99)] \ [mat(delim: #none, 3, 4; 6, 3)] times [mat(delim: #none, 9, 2; 3, 9)] = [mat(delim: #none, 39, 42; 63, 39)] \ [mat(delim: #none, 3, 4; 8, 7)] times [mat(delim: #none, 7, 2; 4, 9)] = [mat(delim: #none, 37, 42; 84, 79)] \ [mat(delim: #none, 3, 4; 10, 11)] times [mat(delim: #none, 5, 2; 5, 9)] = [mat(delim: #none, 35, 42; 105, 119)] \ [mat(delim: #none, 3, 4; 12, 15)] times [mat(delim: #none, 3, 2; 6, 9)] = [mat(delim: #none, 33, 42; 126, 159)] \ [mat(delim: #none, 3, 4; 14, 19)] times [mat(delim: #none, 1, 2; 7, 9)] = [mat(delim: #none, 31, 42; 147, 199)] \ [mat(delim: #none, 3, 6; 4, 3)] times [mat(delim: #none, 9, 3; 2, 9)] = [mat(delim: #none, 39, 63; 42, 39)] \ [mat(delim: #none, 3, 6; 6, 9)] times [mat(delim: #none, 6, 3; 3, 9)] = [mat(delim: #none, 36, 63; 63, 99)] \ [mat(delim: #none, 3, 6; 8, 15)] times [mat(delim: #none, 3, 3; 4, 9)] = [mat(delim: #none, 33, 63; 84, 159)] \ [mat(delim: #none, 3, 6; 10, 21)] times [mat(delim: #none, 0, 3; 5, 9)] = [mat(delim: #none, 30, 63; 105, 219)] \ [mat(delim: #none, 3, 8; 4, 7)] times [mat(delim: #none, 7, 4; 2, 9)] = [mat(delim: #none, 37, 84; 42, 79)] \ [mat(delim: #none, 3, 8; 6, 15)] times [mat(delim: #none, 3, 4; 3, 9)] = [mat(delim: #none, 33, 84; 63, 159)] \ [mat(delim: #none, 3, 10; 4, 11)] times [mat(delim: #none, 5, 5; 2, 9)] = [mat(delim: #none, 35, 105; 42, 119)] \ [mat(delim: #none, 3, 10; 6, 21)] times [mat(delim: #none, 0, 5; 3, 9)] = [mat(delim: #none, 30, 105; 63, 219)] \ [mat(delim: #none, 3, 12; 2, 3)] times [mat(delim: #none, 9, 6; 1, 9)] = [mat(delim: #none, 39, 126; 21, 39)] \ [mat(delim: #none, 3, 12; 4, 15)] times [mat(delim: #none, 3, 6; 2, 9)] = [mat(delim: #none, 33, 126; 42, 159)] \ [mat(delim: #none, 3, 14; 2, 5)] times [mat(delim: #none, 8, 7; 1, 9)] = [mat(delim: #none, 38, 147; 21, 59)] \ [mat(delim: #none, 3, 14; 4, 19)] times [mat(delim: #none, 1, 7; 2, 9)] = [mat(delim: #none, 31, 147; 42, 199)] \ [mat(delim: #none, 3, 16; 2, 7)] times [mat(delim: #none, 7, 8; 1, 9)] = [mat(delim: #none, 37, 168; 21, 79)] \ [mat(delim: #none, 3, 18; 2, 9)] times [mat(delim: #none, 6, 9; 1, 9)] = [mat(delim: #none, 36, 189; 21, 99)] \ [mat(delim: #none, 5, 2; 14, 3)] times [mat(delim: #none, 9, 1; 7, 8)] = [mat(delim: #none, 59, 21; 147, 38)] \ [mat(delim: #none, 5, 2; 18, 5)] times [mat(delim: #none, 8, 1; 9, 8)] = [mat(delim: #none, 58, 21; 189, 58)] \ [mat(delim: #none, 5, 6; 6, 5)] times [mat(delim: #none, 8, 3; 3, 8)] = [mat(delim: #none, 58, 63; 63, 58)] \ [mat(delim: #none, 5, 6; 10, 11)] times [mat(delim: #none, 5, 3; 5, 8)] = [mat(delim: #none, 55, 63; 105, 118)] \ [mat(delim: #none, 5, 6; 14, 17)] times [mat(delim: #none, 2, 3; 7, 8)] = [mat(delim: #none, 52, 63; 147, 178)] \ [mat(delim: #none, 5, 10; 6, 11)] times [mat(delim: #none, 5, 5; 3, 8)] = [mat(delim: #none, 55, 105; 63, 118)] \ [mat(delim: #none, 5, 10; 10, 21)] times [mat(delim: #none, 0, 5; 5, 8)] = [mat(delim: #none, 50, 105; 105, 218)] \ [mat(delim: #none, 5, 14; 2, 3)] times [mat(delim: #none, 9, 7; 1, 8)] = [mat(delim: #none, 59, 147; 21, 38)] \ [mat(delim: #none, 5, 14; 6, 17)] times [mat(delim: #none, 2, 7; 3, 8)] = [mat(delim: #none, 52, 147; 63, 178)] \ [mat(delim: #none, 5, 18; 2, 5)] times [mat(delim: #none, 8, 9; 1, 8)] = [mat(delim: #none, 58, 189; 21, 58)] \ [mat(delim: #none, 7, 2; 16, 3)] times [mat(delim: #none, 9, 1; 8, 7)] = [mat(delim: #none, 79, 21; 168, 37)] \ [mat(delim: #none, 7, 4; 8, 3)] times [mat(delim: #none, 9, 2; 4, 7)] = [mat(delim: #none, 79, 42; 84, 37)] \ [mat(delim: #none, 7, 4; 14, 7)] times [mat(delim: #none, 7, 2; 7, 7)] = [mat(delim: #none, 77, 42; 147, 77)] \ [mat(delim: #none, 7, 8; 4, 3)] times [mat(delim: #none, 9, 4; 2, 7)] = [mat(delim: #none, 79, 84; 42, 37)] \ [mat(delim: #none, 7, 8; 10, 11)] times [mat(delim: #none, 5, 4; 5, 7)] = [mat(delim: #none, 75, 84; 105, 117)] \ [mat(delim: #none, 7, 8; 16, 19)] times [mat(delim: #none, 1, 4; 8, 7)] = [mat(delim: #none, 71, 84; 168, 197)] \ [mat(delim: #none, 7, 10; 8, 11)] times [mat(delim: #none, 5, 5; 4, 7)] = [mat(delim: #none, 75, 105; 84, 117)] \ [mat(delim: #none, 7, 10; 14, 21)] times [mat(delim: #none, 0, 5; 7, 7)] = [mat(delim: #none, 70, 105; 147, 217)] \ [mat(delim: #none, 7, 14; 4, 7)] times [mat(delim: #none, 7, 7; 2, 7)] = [mat(delim: #none, 77, 147; 42, 77)] \ [mat(delim: #none, 7, 14; 10, 21)] times [mat(delim: #none, 0, 7; 5, 7)] = [mat(delim: #none, 70, 147; 105, 217)] \ [mat(delim: #none, 7, 16; 2, 3)] times [mat(delim: #none, 9, 8; 1, 7)] = [mat(delim: #none, 79, 168; 21, 37)] \ [mat(delim: #none, 7, 16; 8, 19)] times [mat(delim: #none, 1, 8; 4, 7)] = [mat(delim: #none, 71, 168; 84, 197)] \ [mat(delim: #none, 9, 2; 18, 3)] times [mat(delim: #none, 9, 1; 9, 6)] = [mat(delim: #none, 99, 21; 189, 36)] \ [mat(delim: #none, 9, 6; 6, 3)] times [mat(delim: #none, 9, 3; 3, 6)] = [mat(delim: #none, 99, 63; 63, 36)] \ [mat(delim: #none, 9, 6; 14, 9)] times [mat(delim: #none, 6, 3; 7, 6)] = [mat(delim: #none, 96, 63; 147, 96)] \ [mat(delim: #none, 9, 10; 10, 11)] times [mat(delim: #none, 5, 5; 5, 6)] = [mat(delim: #none, 95, 105; 105, 116)] \ [mat(delim: #none, 9, 10; 18, 21)] times [mat(delim: #none, 0, 5; 9, 6)] = [mat(delim: #none, 90, 105; 189, 216)] \ [mat(delim: #none, 9, 14; 6, 9)] times [mat(delim: #none, 6, 7; 3, 6)] = [mat(delim: #none, 96, 147; 63, 96)] \ [mat(delim: #none, 9, 18; 2, 3)] times [mat(delim: #none, 9, 9; 1, 6)] = [mat(delim: #none, 99, 189; 21, 36)] \ [mat(delim: #none, 9, 18; 10, 21)] times [mat(delim: #none, 0, 9; 5, 6)] = [mat(delim: #none, 90, 189; 105, 216)] \ [mat(delim: #none, 11, 4; 10, 3)] times [mat(delim: #none, 9, 2; 5, 5)] = [mat(delim: #none, 119, 42; 105, 35)] \ [mat(delim: #none, 11, 6; 10, 5)] times [mat(delim: #none, 8, 3; 5, 5)] = [mat(delim: #none, 118, 63; 105, 55)] \ [mat(delim: #none, 11, 8; 10, 7)] times [mat(delim: #none, 7, 4; 5, 5)] = [mat(delim: #none, 117, 84; 105, 75)] \ [mat(delim: #none, 11, 10; 4, 3)] times [mat(delim: #none, 9, 5; 2, 5)] = [mat(delim: #none, 119, 105; 42, 35)] \ [mat(delim: #none, 11, 10; 6, 5)] times [mat(delim: #none, 8, 5; 3, 5)] = [mat(delim: #none, 118, 105; 63, 55)] \ [mat(delim: #none, 11, 10; 8, 7)] times [mat(delim: #none, 7, 5; 4, 5)] = [mat(delim: #none, 117, 105; 84, 75)] \ [mat(delim: #none, 11, 10; 10, 9)] times [mat(delim: #none, 6, 5; 5, 5)] = [mat(delim: #none, 116, 105; 105, 95)] \ [mat(delim: #none, 11, 10; 12, 11)] times [mat(delim: #none, 5, 5; 6, 5)] = [mat(delim: #none, 115, 105; 126, 115)] \ [mat(delim: #none, 11, 10; 14, 13)] times [mat(delim: #none, 4, 5; 7, 5)] = [mat(delim: #none, 114, 105; 147, 135)] \ [mat(delim: #none, 11, 10; 16, 15)] times [mat(delim: #none, 3, 5; 8, 5)] = [mat(delim: #none, 113, 105; 168, 155)] \ [mat(delim: #none, 11, 10; 18, 17)] times [mat(delim: #none, 2, 5; 9, 5)] = [mat(delim: #none, 112, 105; 189, 175)] \ [mat(delim: #none, 11, 12; 10, 11)] times [mat(delim: #none, 5, 6; 5, 5)] = [mat(delim: #none, 115, 126; 105, 115)] \ [mat(delim: #none, 11, 14; 10, 13)] times [mat(delim: #none, 4, 7; 5, 5)] = [mat(delim: #none, 114, 147; 105, 135)] \ [mat(delim: #none, 11, 16; 10, 15)] times [mat(delim: #none, 3, 8; 5, 5)] = [mat(delim: #none, 113, 168; 105, 155)] \ [mat(delim: #none, 11, 18; 10, 17)] times [mat(delim: #none, 2, 9; 5, 5)] = [mat(delim: #none, 112, 189; 105, 175)] \ [mat(delim: #none, 13, 10; 14, 11)] times [mat(delim: #none, 5, 5; 7, 4)] = [mat(delim: #none, 135, 105; 147, 114)] \ [mat(delim: #none, 13, 14; 10, 11)] times [mat(delim: #none, 5, 7; 5, 4)] = [mat(delim: #none, 135, 147; 105, 114)] \ [mat(delim: #none, 15, 4; 12, 3)] times [mat(delim: #none, 9, 2; 6, 3)] = [mat(delim: #none, 159, 42; 126, 33)] \ [mat(delim: #none, 15, 6; 8, 3)] times [mat(delim: #none, 9, 3; 4, 3)] = [mat(delim: #none, 159, 63; 84, 33)] \ [mat(delim: #none, 15, 8; 6, 3)] times [mat(delim: #none, 9, 4; 3, 3)] = [mat(delim: #none, 159, 84; 63, 33)] \ [mat(delim: #none, 15, 10; 16, 11)] times [mat(delim: #none, 5, 5; 8, 3)] = [mat(delim: #none, 155, 105; 168, 113)] \ [mat(delim: #none, 15, 12; 4, 3)] times [mat(delim: #none, 9, 6; 2, 3)] = [mat(delim: #none, 159, 126; 42, 33)] \ [mat(delim: #none, 15, 12; 18, 15)] times [mat(delim: #none, 3, 6; 9, 3)] = [mat(delim: #none, 153, 126; 189, 153)] \ [mat(delim: #none, 15, 16; 10, 11)] times [mat(delim: #none, 5, 8; 5, 3)] = [mat(delim: #none, 155, 168; 105, 113)] \ [mat(delim: #none, 15, 18; 12, 15)] times [mat(delim: #none, 3, 9; 6, 3)] = [mat(delim: #none, 153, 189; 126, 153)] \ [mat(delim: #none, 17, 6; 14, 5)] times [mat(delim: #none, 8, 3; 7, 2)] = [mat(delim: #none, 178, 63; 147, 52)] \ [mat(delim: #none, 17, 10; 18, 11)] times [mat(delim: #none, 5, 5; 9, 2)] = [mat(delim: #none, 175, 105; 189, 112)] \ [mat(delim: #none, 17, 14; 6, 5)] times [mat(delim: #none, 8, 7; 3, 2)] = [mat(delim: #none, 178, 147; 63, 52)] \ [mat(delim: #none, 17, 18; 10, 11)] times [mat(delim: #none, 5, 9; 5, 2)] = [mat(delim: #none, 175, 189; 105, 112)] \ [mat(delim: #none, 19, 4; 14, 3)] times [mat(delim: #none, 9, 2; 7, 1)] = [mat(delim: #none, 199, 42; 147, 31)] \ [mat(delim: #none, 19, 8; 16, 7)] times [mat(delim: #none, 7, 4; 8, 1)] = [mat(delim: #none, 197, 84; 168, 71)] \ [mat(delim: #none, 19, 14; 4, 3)] times [mat(delim: #none, 9, 7; 2, 1)] = [mat(delim: #none, 199, 147; 42, 31)] \ [mat(delim: #none, 19, 16; 8, 7)] times [mat(delim: #none, 7, 8; 4, 1)] = [mat(delim: #none, 197, 168; 84, 71)] \ [mat(delim: #none, 21, 6; 10, 3)] times [mat(delim: #none, 9, 3; 5, 0)] = [mat(delim: #none, 219, 63; 105, 30)] \ [mat(delim: #none, 21, 10; 6, 3)] times [mat(delim: #none, 9, 5; 3, 0)] = [mat(delim: #none, 219, 105; 63, 30)] \ [mat(delim: #none, 21, 10; 10, 5)] times [mat(delim: #none, 8, 5; 5, 0)] = [mat(delim: #none, 218, 105; 105, 50)] \ [mat(delim: #none, 21, 10; 14, 7)] times [mat(delim: #none, 7, 5; 7, 0)] = [mat(delim: #none, 217, 105; 147, 70)] \ [mat(delim: #none, 21, 10; 18, 9)] times [mat(delim: #none, 6, 5; 9, 0)] = [mat(delim: #none, 216, 105; 189, 90)] \ [mat(delim: #none, 21, 14; 10, 7)] times [mat(delim: #none, 7, 7; 5, 0)] = [mat(delim: #none, 217, 147; 105, 70)] \ [mat(delim: #none, 21, 18; 10, 9)] times [mat(delim: #none, 6, 9; 5, 0)] = [mat(delim: #none, 216, 189; 105, 90)] \ [mat(delim: #none, 6, 5; 15, 6)] times [mat(delim: #none, 9, 1; 3, 9)] = [mat(delim: #none, 69, 51; 153, 69)] \ [mat(delim: #none, 6, 5; 20, 11)] times [mat(delim: #none, 8, 1; 4, 9)] = [mat(delim: #none, 68, 51; 204, 119)] \ [mat(delim: #none, 6, 5; 25, 16)] times [mat(delim: #none, 7, 1; 5, 9)] = [mat(delim: #none, 67, 51; 255, 169)] \ [mat(delim: #none, 6, 5; 30, 21)] times [mat(delim: #none, 6, 1; 6, 9)] = [mat(delim: #none, 66, 51; 306, 219)] \ [mat(delim: #none, 6, 5; 35, 26)] times [mat(delim: #none, 5, 1; 7, 9)] = [mat(delim: #none, 65, 51; 357, 269)] \ [mat(delim: #none, 6, 5; 40, 31)] times [mat(delim: #none, 4, 1; 8, 9)] = [mat(delim: #none, 64, 51; 408, 319)] \ [mat(delim: #none, 6, 5; 45, 36)] times [mat(delim: #none, 3, 1; 9, 9)] = [mat(delim: #none, 63, 51; 459, 369)] \ [mat(delim: #none, 6, 10; 10, 11)] times [mat(delim: #none, 8, 2; 2, 9)] = [mat(delim: #none, 68, 102; 102, 119)] \ [mat(delim: #none, 6, 10; 15, 21)] times [mat(delim: #none, 6, 2; 3, 9)] = [mat(delim: #none, 66, 102; 153, 219)] \ [mat(delim: #none, 6, 10; 20, 31)] times [mat(delim: #none, 4, 2; 4, 9)] = [mat(delim: #none, 64, 102; 204, 319)] \ [mat(delim: #none, 6, 10; 25, 41)] times [mat(delim: #none, 2, 2; 5, 9)] = [mat(delim: #none, 62, 102; 255, 419)] \ [mat(delim: #none, 6, 10; 30, 51)] times [mat(delim: #none, 0, 2; 6, 9)] = [mat(delim: #none, 60, 102; 306, 519)] \ [mat(delim: #none, 6, 15; 5, 6)] times [mat(delim: #none, 9, 3; 1, 9)] = [mat(delim: #none, 69, 153; 51, 69)] \ [mat(delim: #none, 6, 15; 10, 21)] times [mat(delim: #none, 6, 3; 2, 9)] = [mat(delim: #none, 66, 153; 102, 219)] \ [mat(delim: #none, 6, 15; 15, 36)] times [mat(delim: #none, 3, 3; 3, 9)] = [mat(delim: #none, 63, 153; 153, 369)] \ [mat(delim: #none, 6, 15; 20, 51)] times [mat(delim: #none, 0, 3; 4, 9)] = [mat(delim: #none, 60, 153; 204, 519)] \ [mat(delim: #none, 6, 20; 5, 11)] times [mat(delim: #none, 8, 4; 1, 9)] = [mat(delim: #none, 68, 204; 51, 119)] \ [mat(delim: #none, 6, 20; 10, 31)] times [mat(delim: #none, 4, 4; 2, 9)] = [mat(delim: #none, 64, 204; 102, 319)] \ [mat(delim: #none, 6, 20; 15, 51)] times [mat(delim: #none, 0, 4; 3, 9)] = [mat(delim: #none, 60, 204; 153, 519)] \ [mat(delim: #none, 6, 25; 5, 16)] times [mat(delim: #none, 7, 5; 1, 9)] = [mat(delim: #none, 67, 255; 51, 169)] \ [mat(delim: #none, 6, 25; 10, 41)] times [mat(delim: #none, 2, 5; 2, 9)] = [mat(delim: #none, 62, 255; 102, 419)] \ [mat(delim: #none, 6, 30; 5, 21)] times [mat(delim: #none, 6, 6; 1, 9)] = [mat(delim: #none, 66, 306; 51, 219)] \ [mat(delim: #none, 6, 30; 10, 51)] times [mat(delim: #none, 0, 6; 2, 9)] = [mat(delim: #none, 60, 306; 102, 519)] \ [mat(delim: #none, 6, 35; 5, 26)] times [mat(delim: #none, 5, 7; 1, 9)] = [mat(delim: #none, 65, 357; 51, 269)] \ [mat(delim: #none, 6, 40; 5, 31)] times [mat(delim: #none, 4, 8; 1, 9)] = [mat(delim: #none, 64, 408; 51, 319)] \ [mat(delim: #none, 6, 45; 5, 36)] times [mat(delim: #none, 3, 9; 1, 9)] = [mat(delim: #none, 63, 459; 51, 369)] \ [mat(delim: #none, 11, 5; 20, 6)] times [mat(delim: #none, 9, 1; 4, 8)] = [mat(delim: #none, 119, 51; 204, 68)] \ [mat(delim: #none, 11, 5; 30, 11)] times [mat(delim: #none, 8, 1; 6, 8)] = [mat(delim: #none, 118, 51; 306, 118)] \ [mat(delim: #none, 11, 5; 40, 16)] times [mat(delim: #none, 7, 1; 8, 8)] = [mat(delim: #none, 117, 51; 408, 168)] \ [mat(delim: #none, 11, 10; 10, 6)] times [mat(delim: #none, 9, 2; 2, 8)] = [mat(delim: #none, 119, 102; 102, 68)] \ [mat(delim: #none, 11, 10; 15, 11)] times [mat(delim: #none, 8, 2; 3, 8)] = [mat(delim: #none, 118, 102; 153, 118)] \ [mat(delim: #none, 11, 10; 20, 16)] times [mat(delim: #none, 7, 2; 4, 8)] = [mat(delim: #none, 117, 102; 204, 168)] \ [mat(delim: #none, 11, 10; 25, 21)] times [mat(delim: #none, 6, 2; 5, 8)] = [mat(delim: #none, 116, 102; 255, 218)] \ [mat(delim: #none, 11, 10; 30, 26)] times [mat(delim: #none, 5, 2; 6, 8)] = [mat(delim: #none, 115, 102; 306, 268)] \ [mat(delim: #none, 11, 10; 35, 31)] times [mat(delim: #none, 4, 2; 7, 8)] = [mat(delim: #none, 114, 102; 357, 318)] \ [mat(delim: #none, 11, 10; 40, 36)] times [mat(delim: #none, 3, 2; 8, 8)] = [mat(delim: #none, 113, 102; 408, 368)] \ [mat(delim: #none, 11, 10; 45, 41)] times [mat(delim: #none, 2, 2; 9, 8)] = [mat(delim: #none, 112, 102; 459, 418)] \ [mat(delim: #none, 11, 15; 10, 11)] times [mat(delim: #none, 8, 3; 2, 8)] = [mat(delim: #none, 118, 153; 102, 118)] \ [mat(delim: #none, 11, 15; 20, 26)] times [mat(delim: #none, 5, 3; 4, 8)] = [mat(delim: #none, 115, 153; 204, 268)] \ [mat(delim: #none, 11, 15; 30, 41)] times [mat(delim: #none, 2, 3; 6, 8)] = [mat(delim: #none, 112, 153; 306, 418)] \ [mat(delim: #none, 11, 20; 5, 6)] times [mat(delim: #none, 9, 4; 1, 8)] = [mat(delim: #none, 119, 204; 51, 68)] \ [mat(delim: #none, 11, 20; 10, 16)] times [mat(delim: #none, 7, 4; 2, 8)] = [mat(delim: #none, 117, 204; 102, 168)] \ [mat(delim: #none, 11, 20; 15, 26)] times [mat(delim: #none, 5, 4; 3, 8)] = [mat(delim: #none, 115, 204; 153, 268)] \ [mat(delim: #none, 11, 20; 20, 36)] times [mat(delim: #none, 3, 4; 4, 8)] = [mat(delim: #none, 113, 204; 204, 368)] \ [mat(delim: #none, 11, 20; 25, 46)] times [mat(delim: #none, 1, 4; 5, 8)] = [mat(delim: #none, 111, 204; 255, 468)] \ [mat(delim: #none, 11, 25; 10, 21)] times [mat(delim: #none, 6, 5; 2, 8)] = [mat(delim: #none, 116, 255; 102, 218)] \ [mat(delim: #none, 11, 25; 20, 46)] times [mat(delim: #none, 1, 5; 4, 8)] = [mat(delim: #none, 111, 255; 204, 468)] \ [mat(delim: #none, 11, 30; 5, 11)] times [mat(delim: #none, 8, 6; 1, 8)] = [mat(delim: #none, 118, 306; 51, 118)] \ [mat(delim: #none, 11, 30; 10, 26)] times [mat(delim: #none, 5, 6; 2, 8)] = [mat(delim: #none, 115, 306; 102, 268)] \ [mat(delim: #none, 11, 30; 15, 41)] times [mat(delim: #none, 2, 6; 3, 8)] = [mat(delim: #none, 112, 306; 153, 418)] \ [mat(delim: #none, 11, 35; 10, 31)] times [mat(delim: #none, 4, 7; 2, 8)] = [mat(delim: #none, 114, 357; 102, 318)] \ [mat(delim: #none, 11, 40; 5, 16)] times [mat(delim: #none, 7, 8; 1, 8)] = [mat(delim: #none, 117, 408; 51, 168)] \ [mat(delim: #none, 11, 40; 10, 36)] times [mat(delim: #none, 3, 8; 2, 8)] = [mat(delim: #none, 113, 408; 102, 368)] \ [mat(delim: #none, 11, 45; 10, 41)] times [mat(delim: #none, 2, 9; 2, 8)] = [mat(delim: #none, 112, 459; 102, 418)] \ [mat(delim: #none, 16, 5; 25, 6)] times [mat(delim: #none, 9, 1; 5, 7)] = [mat(delim: #none, 169, 51; 255, 67)] \ [mat(delim: #none, 16, 5; 40, 11)] times [mat(delim: #none, 8, 1; 8, 7)] = [mat(delim: #none, 168, 51; 408, 117)] \ [mat(delim: #none, 16, 10; 20, 11)] times [mat(delim: #none, 8, 2; 4, 7)] = [mat(delim: #none, 168, 102; 204, 117)] \ [mat(delim: #none, 16, 10; 35, 21)] times [mat(delim: #none, 6, 2; 7, 7)] = [mat(delim: #none, 166, 102; 357, 217)] \ [mat(delim: #none, 16, 20; 10, 11)] times [mat(delim: #none, 8, 4; 2, 7)] = [mat(delim: #none, 168, 204; 102, 117)] \ [mat(delim: #none, 16, 20; 25, 31)] times [mat(delim: #none, 4, 4; 5, 7)] = [mat(delim: #none, 164, 204; 255, 317)] \ [mat(delim: #none, 16, 20; 40, 51)] times [mat(delim: #none, 0, 4; 8, 7)] = [mat(delim: #none, 160, 204; 408, 517)] \ [mat(delim: #none, 16, 25; 5, 6)] times [mat(delim: #none, 9, 5; 1, 7)] = [mat(delim: #none, 169, 255; 51, 67)] \ [mat(delim: #none, 16, 25; 20, 31)] times [mat(delim: #none, 4, 5; 4, 7)] = [mat(delim: #none, 164, 255; 204, 317)] \ [mat(delim: #none, 16, 35; 10, 21)] times [mat(delim: #none, 6, 7; 2, 7)] = [mat(delim: #none, 166, 357; 102, 217)] \ [mat(delim: #none, 16, 40; 5, 11)] times [mat(delim: #none, 8, 8; 1, 7)] = [mat(delim: #none, 168, 408; 51, 117)] \ [mat(delim: #none, 16, 40; 20, 51)] times [mat(delim: #none, 0, 8; 4, 7)] = [mat(delim: #none, 160, 408; 204, 517)] \ [mat(delim: #none, 21, 5; 30, 6)] times [mat(delim: #none, 9, 1; 6, 6)] = [mat(delim: #none, 219, 51; 306, 66)] \ [mat(delim: #none, 21, 10; 15, 6)] times [mat(delim: #none, 9, 2; 3, 6)] = [mat(delim: #none, 219, 102; 153, 66)] \ [mat(delim: #none, 21, 10; 25, 11)] times [mat(delim: #none, 8, 2; 5, 6)] = [mat(delim: #none, 218, 102; 255, 116)] \ [mat(delim: #none, 21, 10; 35, 16)] times [mat(delim: #none, 7, 2; 7, 6)] = [mat(delim: #none, 217, 102; 357, 166)] \ [mat(delim: #none, 21, 10; 45, 21)] times [mat(delim: #none, 6, 2; 9, 6)] = [mat(delim: #none, 216, 102; 459, 216)] \ [mat(delim: #none, 21, 15; 10, 6)] times [mat(delim: #none, 9, 3; 2, 6)] = [mat(delim: #none, 219, 153; 102, 66)] \ [mat(delim: #none, 21, 15; 30, 21)] times [mat(delim: #none, 6, 3; 6, 6)] = [mat(delim: #none, 216, 153; 306, 216)] \ [mat(delim: #none, 21, 25; 10, 11)] times [mat(delim: #none, 8, 5; 2, 6)] = [mat(delim: #none, 218, 255; 102, 116)] \ [mat(delim: #none, 21, 25; 30, 36)] times [mat(delim: #none, 3, 5; 6, 6)] = [mat(delim: #none, 213, 255; 306, 366)] \ [mat(delim: #none, 21, 30; 5, 6)] times [mat(delim: #none, 9, 6; 1, 6)] = [mat(delim: #none, 219, 306; 51, 66)] \ [mat(delim: #none, 21, 30; 15, 21)] times [mat(delim: #none, 6, 6; 3, 6)] = [mat(delim: #none, 216, 306; 153, 216)] \ [mat(delim: #none, 21, 30; 25, 36)] times [mat(delim: #none, 3, 6; 5, 6)] = [mat(delim: #none, 213, 306; 255, 366)] \ [mat(delim: #none, 21, 30; 35, 51)] times [mat(delim: #none, 0, 6; 7, 6)] = [mat(delim: #none, 210, 306; 357, 516)] \ [mat(delim: #none, 21, 35; 10, 16)] times [mat(delim: #none, 7, 7; 2, 6)] = [mat(delim: #none, 217, 357; 102, 166)] \ [mat(delim: #none, 21, 35; 30, 51)] times [mat(delim: #none, 0, 7; 6, 6)] = [mat(delim: #none, 210, 357; 306, 516)] \ [mat(delim: #none, 21, 45; 10, 21)] times [mat(delim: #none, 6, 9; 2, 6)] = [mat(delim: #none, 216, 459; 102, 216)] \ [mat(delim: #none, 26, 5; 35, 6)] times [mat(delim: #none, 9, 1; 7, 5)] = [mat(delim: #none, 269, 51; 357, 65)] \ [mat(delim: #none, 26, 10; 30, 11)] times [mat(delim: #none, 8, 2; 6, 5)] = [mat(delim: #none, 268, 102; 306, 115)] \ [mat(delim: #none, 26, 15; 20, 11)] times [mat(delim: #none, 8, 3; 4, 5)] = [mat(delim: #none, 268, 153; 204, 115)] \ [mat(delim: #none, 26, 15; 45, 26)] times [mat(delim: #none, 5, 3; 9, 5)] = [mat(delim: #none, 265, 153; 459, 265)] \ [mat(delim: #none, 26, 20; 15, 11)] times [mat(delim: #none, 8, 4; 3, 5)] = [mat(delim: #none, 268, 204; 153, 115)] \ [mat(delim: #none, 26, 20; 40, 31)] times [mat(delim: #none, 4, 4; 8, 5)] = [mat(delim: #none, 264, 204; 408, 315)] \ [mat(delim: #none, 26, 30; 10, 11)] times [mat(delim: #none, 8, 6; 2, 5)] = [mat(delim: #none, 268, 306; 102, 115)] \ [mat(delim: #none, 26, 30; 35, 41)] times [mat(delim: #none, 2, 6; 7, 5)] = [mat(delim: #none, 262, 306; 357, 415)] \ [mat(delim: #none, 26, 35; 5, 6)] times [mat(delim: #none, 9, 7; 1, 5)] = [mat(delim: #none, 269, 357; 51, 65)] \ [mat(delim: #none, 26, 35; 30, 41)] times [mat(delim: #none, 2, 7; 6, 5)] = [mat(delim: #none, 262, 357; 306, 415)] \ [mat(delim: #none, 26, 40; 20, 31)] times [mat(delim: #none, 4, 8; 4, 5)] = [mat(delim: #none, 264, 408; 204, 315)] \ [mat(delim: #none, 26, 45; 15, 26)] times [mat(delim: #none, 5, 9; 3, 5)] = [mat(delim: #none, 265, 459; 153, 265)] \ [mat(delim: #none, 31, 5; 40, 6)] times [mat(delim: #none, 9, 1; 8, 4)] = [mat(delim: #none, 319, 51; 408, 64)] \ [mat(delim: #none, 31, 10; 20, 6)] times [mat(delim: #none, 9, 2; 4, 4)] = [mat(delim: #none, 319, 102; 204, 64)] \ [mat(delim: #none, 31, 10; 35, 11)] times [mat(delim: #none, 8, 2; 7, 4)] = [mat(delim: #none, 318, 102; 357, 114)] \ [mat(delim: #none, 31, 20; 10, 6)] times [mat(delim: #none, 9, 4; 2, 4)] = [mat(delim: #none, 319, 204; 102, 64)] \ [mat(delim: #none, 31, 20; 25, 16)] times [mat(delim: #none, 7, 4; 5, 4)] = [mat(delim: #none, 317, 204; 255, 164)] \ [mat(delim: #none, 31, 20; 40, 26)] times [mat(delim: #none, 5, 4; 8, 4)] = [mat(delim: #none, 315, 204; 408, 264)] \ [mat(delim: #none, 31, 25; 20, 16)] times [mat(delim: #none, 7, 5; 4, 4)] = [mat(delim: #none, 317, 255; 204, 164)] \ [mat(delim: #none, 31, 35; 10, 11)] times [mat(delim: #none, 8, 7; 2, 4)] = [mat(delim: #none, 318, 357; 102, 114)] \ [mat(delim: #none, 31, 35; 40, 46)] times [mat(delim: #none, 1, 7; 8, 4)] = [mat(delim: #none, 311, 357; 408, 464)] \ [mat(delim: #none, 31, 40; 5, 6)] times [mat(delim: #none, 9, 8; 1, 4)] = [mat(delim: #none, 319, 408; 51, 64)] \ [mat(delim: #none, 31, 40; 20, 26)] times [mat(delim: #none, 5, 8; 4, 4)] = [mat(delim: #none, 315, 408; 204, 264)] \ [mat(delim: #none, 31, 40; 35, 46)] times [mat(delim: #none, 1, 8; 7, 4)] = [mat(delim: #none, 311, 408; 357, 464)] \ [mat(delim: #none, 36, 5; 45, 6)] times [mat(delim: #none, 9, 1; 9, 3)] = [mat(delim: #none, 369, 51; 459, 63)] \ [mat(delim: #none, 36, 10; 40, 11)] times [mat(delim: #none, 8, 2; 8, 3)] = [mat(delim: #none, 368, 102; 408, 113)] \ [mat(delim: #none, 36, 15; 15, 6)] times [mat(delim: #none, 9, 3; 3, 3)] = [mat(delim: #none, 369, 153; 153, 63)] \ [mat(delim: #none, 36, 20; 20, 11)] times [mat(delim: #none, 8, 4; 4, 3)] = [mat(delim: #none, 368, 204; 204, 113)] \ [mat(delim: #none, 36, 25; 30, 21)] times [mat(delim: #none, 6, 5; 6, 3)] = [mat(delim: #none, 366, 255; 306, 213)] \ [mat(delim: #none, 36, 30; 25, 21)] times [mat(delim: #none, 6, 6; 5, 3)] = [mat(delim: #none, 366, 306; 255, 213)] \ [mat(delim: #none, 36, 40; 10, 11)] times [mat(delim: #none, 8, 8; 2, 3)] = [mat(delim: #none, 368, 408; 102, 113)] \ [mat(delim: #none, 36, 40; 45, 51)] times [mat(delim: #none, 0, 8; 9, 3)] = [mat(delim: #none, 360, 408; 459, 513)] \ [mat(delim: #none, 36, 45; 5, 6)] times [mat(delim: #none, 9, 9; 1, 3)] = [mat(delim: #none, 369, 459; 51, 63)] \ [mat(delim: #none, 36, 45; 40, 51)] times [mat(delim: #none, 0, 9; 8, 3)] = [mat(delim: #none, 360, 459; 408, 513)] \ [mat(delim: #none, 41, 10; 25, 6)] times [mat(delim: #none, 9, 2; 5, 2)] = [mat(delim: #none, 419, 102; 255, 62)] \ [mat(delim: #none, 41, 10; 45, 11)] times [mat(delim: #none, 8, 2; 9, 2)] = [mat(delim: #none, 418, 102; 459, 112)] \ [mat(delim: #none, 41, 15; 30, 11)] times [mat(delim: #none, 8, 3; 6, 2)] = [mat(delim: #none, 418, 153; 306, 112)] \ [mat(delim: #none, 41, 25; 10, 6)] times [mat(delim: #none, 9, 5; 2, 2)] = [mat(delim: #none, 419, 255; 102, 62)] \ [mat(delim: #none, 41, 30; 15, 11)] times [mat(delim: #none, 8, 6; 3, 2)] = [mat(delim: #none, 418, 306; 153, 112)] \ [mat(delim: #none, 41, 30; 35, 26)] times [mat(delim: #none, 5, 6; 7, 2)] = [mat(delim: #none, 415, 306; 357, 262)] \ [mat(delim: #none, 41, 35; 30, 26)] times [mat(delim: #none, 5, 7; 6, 2)] = [mat(delim: #none, 415, 357; 306, 262)] \ [mat(delim: #none, 41, 45; 10, 11)] times [mat(delim: #none, 8, 9; 2, 2)] = [mat(delim: #none, 418, 459; 102, 112)] \ [mat(delim: #none, 46, 20; 25, 11)] times [mat(delim: #none, 8, 4; 5, 1)] = [mat(delim: #none, 468, 204; 255, 111)] \ [mat(delim: #none, 46, 25; 20, 11)] times [mat(delim: #none, 8, 5; 4, 1)] = [mat(delim: #none, 468, 255; 204, 111)] \ [mat(delim: #none, 46, 35; 40, 31)] times [mat(delim: #none, 4, 7; 8, 1)] = [mat(delim: #none, 464, 357; 408, 311)] \ [mat(delim: #none, 46, 40; 35, 31)] times [mat(delim: #none, 4, 8; 7, 1)] = [mat(delim: #none, 464, 408; 357, 311)] \ [mat(delim: #none, 51, 10; 30, 6)] times [mat(delim: #none, 9, 2; 6, 0)] = [mat(delim: #none, 519, 102; 306, 60)] \ [mat(delim: #none, 51, 15; 20, 6)] times [mat(delim: #none, 9, 3; 4, 0)] = [mat(delim: #none, 519, 153; 204, 60)] \ [mat(delim: #none, 51, 20; 15, 6)] times [mat(delim: #none, 9, 4; 3, 0)] = [mat(delim: #none, 519, 204; 153, 60)] \ [mat(delim: #none, 51, 20; 40, 16)] times [mat(delim: #none, 7, 4; 8, 0)] = [mat(delim: #none, 517, 204; 408, 160)] \ [mat(delim: #none, 51, 30; 10, 6)] times [mat(delim: #none, 9, 6; 2, 0)] = [mat(delim: #none, 519, 306; 102, 60)] \ [mat(delim: #none, 51, 30; 35, 21)] times [mat(delim: #none, 6, 6; 7, 0)] = [mat(delim: #none, 516, 306; 357, 210)] \ [mat(delim: #none, 51, 35; 30, 21)] times [mat(delim: #none, 6, 7; 6, 0)] = [mat(delim: #none, 516, 357; 306, 210)] \ [mat(delim: #none, 51, 40; 20, 16)] times [mat(delim: #none, 7, 8; 4, 0)] = [mat(delim: #none, 517, 408; 204, 160)] \ [mat(delim: #none, 51, 40; 45, 36)] times [mat(delim: #none, 3, 8; 9, 0)] = [mat(delim: #none, 513, 408; 459, 360)] \ [mat(delim: #none, 51, 45; 40, 36)] times [mat(delim: #none, 3, 9; 8, 0)] = [mat(delim: #none, 513, 459; 408, 360)] \ [mat(delim: #none, 11, 10; 20, 11)] times [mat(delim: #none, 9, 1; 2, 9)] = [mat(delim: #none, 119, 101; 202, 119)] \ [mat(delim: #none, 11, 10; 30, 21)] times [mat(delim: #none, 8, 1; 3, 9)] = [mat(delim: #none, 118, 101; 303, 219)] \ [mat(delim: #none, 11, 10; 40, 31)] times [mat(delim: #none, 7, 1; 4, 9)] = [mat(delim: #none, 117, 101; 404, 319)] \ [mat(delim: #none, 11, 10; 50, 41)] times [mat(delim: #none, 6, 1; 5, 9)] = [mat(delim: #none, 116, 101; 505, 419)] \ [mat(delim: #none, 11, 10; 60, 51)] times [mat(delim: #none, 5, 1; 6, 9)] = [mat(delim: #none, 115, 101; 606, 519)] \ [mat(delim: #none, 11, 10; 70, 61)] times [mat(delim: #none, 4, 1; 7, 9)] = [mat(delim: #none, 114, 101; 707, 619)] \ [mat(delim: #none, 11, 10; 80, 71)] times [mat(delim: #none, 3, 1; 8, 9)] = [mat(delim: #none, 113, 101; 808, 719)] \ [mat(delim: #none, 11, 10; 90, 81)] times [mat(delim: #none, 2, 1; 9, 9)] = [mat(delim: #none, 112, 101; 909, 819)] \ [mat(delim: #none, 11, 20; 10, 11)] times [mat(delim: #none, 9, 2; 1, 9)] = [mat(delim: #none, 119, 202; 101, 119)] \ [mat(delim: #none, 11, 20; 20, 31)] times [mat(delim: #none, 7, 2; 2, 9)] = [mat(delim: #none, 117, 202; 202, 319)] \ [mat(delim: #none, 11, 20; 30, 51)] times [mat(delim: #none, 5, 2; 3, 9)] = [mat(delim: #none, 115, 202; 303, 519)] \ [mat(delim: #none, 11, 20; 40, 71)] times [mat(delim: #none, 3, 2; 4, 9)] = [mat(delim: #none, 113, 202; 404, 719)] \ [mat(delim: #none, 11, 20; 50, 91)] times [mat(delim: #none, 1, 2; 5, 9)] = [mat(delim: #none, 111, 202; 505, 919)] \ [mat(delim: #none, 11, 30; 10, 21)] times [mat(delim: #none, 8, 3; 1, 9)] = [mat(delim: #none, 118, 303; 101, 219)] \ [mat(delim: #none, 11, 30; 20, 51)] times [mat(delim: #none, 5, 3; 2, 9)] = [mat(delim: #none, 115, 303; 202, 519)] \ [mat(delim: #none, 11, 30; 30, 81)] times [mat(delim: #none, 2, 3; 3, 9)] = [mat(delim: #none, 112, 303; 303, 819)] \ [mat(delim: #none, 11, 40; 10, 31)] times [mat(delim: #none, 7, 4; 1, 9)] = [mat(delim: #none, 117, 404; 101, 319)] \ [mat(delim: #none, 11, 40; 20, 71)] times [mat(delim: #none, 3, 4; 2, 9)] = [mat(delim: #none, 113, 404; 202, 719)] \ [mat(delim: #none, 11, 50; 10, 41)] times [mat(delim: #none, 6, 5; 1, 9)] = [mat(delim: #none, 116, 505; 101, 419)] \ [mat(delim: #none, 11, 50; 20, 91)] times [mat(delim: #none, 1, 5; 2, 9)] = [mat(delim: #none, 111, 505; 202, 919)] \ [mat(delim: #none, 11, 60; 10, 51)] times [mat(delim: #none, 5, 6; 1, 9)] = [mat(delim: #none, 115, 606; 101, 519)] \ [mat(delim: #none, 11, 70; 10, 61)] times [mat(delim: #none, 4, 7; 1, 9)] = [mat(delim: #none, 114, 707; 101, 619)] \ [mat(delim: #none, 11, 80; 10, 71)] times [mat(delim: #none, 3, 8; 1, 9)] = [mat(delim: #none, 113, 808; 101, 719)] \ [mat(delim: #none, 11, 90; 10, 81)] times [mat(delim: #none, 2, 9; 1, 9)] = [mat(delim: #none, 112, 909; 101, 819)] \ [mat(delim: #none, 21, 10; 30, 11)] times [mat(delim: #none, 9, 1; 3, 8)] = [mat(delim: #none, 219, 101; 303, 118)] \ [mat(delim: #none, 21, 10; 50, 21)] times [mat(delim: #none, 8, 1; 5, 8)] = [mat(delim: #none, 218, 101; 505, 218)] \ [mat(delim: #none, 21, 10; 70, 31)] times [mat(delim: #none, 7, 1; 7, 8)] = [mat(delim: #none, 217, 101; 707, 318)] \ [mat(delim: #none, 21, 10; 90, 41)] times [mat(delim: #none, 6, 1; 9, 8)] = [mat(delim: #none, 216, 101; 909, 418)] \ [mat(delim: #none, 21, 30; 10, 11)] times [mat(delim: #none, 9, 3; 1, 8)] = [mat(delim: #none, 219, 303; 101, 118)] \ [mat(delim: #none, 21, 30; 30, 41)] times [mat(delim: #none, 6, 3; 3, 8)] = [mat(delim: #none, 216, 303; 303, 418)] \ [mat(delim: #none, 21, 30; 50, 71)] times [mat(delim: #none, 3, 3; 5, 8)] = [mat(delim: #none, 213, 303; 505, 718)] \ [mat(delim: #none, 21, 30; 70, 101)] times [mat(delim: #none, 0, 3; 7, 8)] = [mat(delim: #none, 210, 303; 707, 1018)] \ [mat(delim: #none, 21, 50; 10, 21)] times [mat(delim: #none, 8, 5; 1, 8)] = [mat(delim: #none, 218, 505; 101, 218)] \ [mat(delim: #none, 21, 50; 30, 71)] times [mat(delim: #none, 3, 5; 3, 8)] = [mat(delim: #none, 213, 505; 303, 718)] \ [mat(delim: #none, 21, 70; 10, 31)] times [mat(delim: #none, 7, 7; 1, 8)] = [mat(delim: #none, 217, 707; 101, 318)] \ [mat(delim: #none, 21, 70; 30, 101)] times [mat(delim: #none, 0, 7; 3, 8)] = [mat(delim: #none, 210, 707; 303, 1018)] \ [mat(delim: #none, 21, 90; 10, 41)] times [mat(delim: #none, 6, 9; 1, 8)] = [mat(delim: #none, 216, 909; 101, 418)] \ [mat(delim: #none, 31, 10; 40, 11)] times [mat(delim: #none, 9, 1; 4, 7)] = [mat(delim: #none, 319, 101; 404, 117)] \ [mat(delim: #none, 31, 10; 70, 21)] times [mat(delim: #none, 8, 1; 7, 7)] = [mat(delim: #none, 318, 101; 707, 217)] \ [mat(delim: #none, 31, 20; 20, 11)] times [mat(delim: #none, 9, 2; 2, 7)] = [mat(delim: #none, 319, 202; 202, 117)] \ [mat(delim: #none, 31, 20; 50, 31)] times [mat(delim: #none, 7, 2; 5, 7)] = [mat(delim: #none, 317, 202; 505, 317)] \ [mat(delim: #none, 31, 20; 80, 51)] times [mat(delim: #none, 5, 2; 8, 7)] = [mat(delim: #none, 315, 202; 808, 517)] \ [mat(delim: #none, 31, 40; 10, 11)] times [mat(delim: #none, 9, 4; 1, 7)] = [mat(delim: #none, 319, 404; 101, 117)] \ [mat(delim: #none, 31, 40; 40, 51)] times [mat(delim: #none, 5, 4; 4, 7)] = [mat(delim: #none, 315, 404; 404, 517)] \ [mat(delim: #none, 31, 40; 70, 91)] times [mat(delim: #none, 1, 4; 7, 7)] = [mat(delim: #none, 311, 404; 707, 917)] \ [mat(delim: #none, 31, 50; 20, 31)] times [mat(delim: #none, 7, 5; 2, 7)] = [mat(delim: #none, 317, 505; 202, 317)] \ [mat(delim: #none, 31, 50; 50, 81)] times [mat(delim: #none, 2, 5; 5, 7)] = [mat(delim: #none, 312, 505; 505, 817)] \ [mat(delim: #none, 31, 70; 10, 21)] times [mat(delim: #none, 8, 7; 1, 7)] = [mat(delim: #none, 318, 707; 101, 217)] \ [mat(delim: #none, 31, 70; 40, 91)] times [mat(delim: #none, 1, 7; 4, 7)] = [mat(delim: #none, 311, 707; 404, 917)] \ [mat(delim: #none, 31, 80; 20, 51)] times [mat(delim: #none, 5, 8; 2, 7)] = [mat(delim: #none, 315, 808; 202, 517)] \ [mat(delim: #none, 41, 10; 50, 11)] times [mat(delim: #none, 9, 1; 5, 6)] = [mat(delim: #none, 419, 101; 505, 116)] \ [mat(delim: #none, 41, 10; 90, 21)] times [mat(delim: #none, 8, 1; 9, 6)] = [mat(delim: #none, 418, 101; 909, 216)] \ [mat(delim: #none, 41, 30; 30, 21)] times [mat(delim: #none, 8, 3; 3, 6)] = [mat(delim: #none, 418, 303; 303, 216)] \ [mat(delim: #none, 41, 30; 70, 51)] times [mat(delim: #none, 5, 3; 7, 6)] = [mat(delim: #none, 415, 303; 707, 516)] \ [mat(delim: #none, 41, 50; 10, 11)] times [mat(delim: #none, 9, 5; 1, 6)] = [mat(delim: #none, 419, 505; 101, 116)] \ [mat(delim: #none, 41, 50; 50, 61)] times [mat(delim: #none, 4, 5; 5, 6)] = [mat(delim: #none, 414, 505; 505, 616)] \ [mat(delim: #none, 41, 70; 30, 51)] times [mat(delim: #none, 5, 7; 3, 6)] = [mat(delim: #none, 415, 707; 303, 516)] \ [mat(delim: #none, 41, 90; 10, 21)] times [mat(delim: #none, 8, 9; 1, 6)] = [mat(delim: #none, 418, 909; 101, 216)] \ [mat(delim: #none, 51, 10; 60, 11)] times [mat(delim: #none, 9, 1; 6, 5)] = [mat(delim: #none, 519, 101; 606, 115)] \ [mat(delim: #none, 51, 20; 30, 11)] times [mat(delim: #none, 9, 2; 3, 5)] = [mat(delim: #none, 519, 202; 303, 115)] \ [mat(delim: #none, 51, 20; 80, 31)] times [mat(delim: #none, 7, 2; 8, 5)] = [mat(delim: #none, 517, 202; 808, 315)] \ [mat(delim: #none, 51, 30; 20, 11)] times [mat(delim: #none, 9, 3; 2, 5)] = [mat(delim: #none, 519, 303; 202, 115)] \ [mat(delim: #none, 51, 30; 70, 41)] times [mat(delim: #none, 6, 3; 7, 5)] = [mat(delim: #none, 516, 303; 707, 415)] \ [mat(delim: #none, 51, 40; 40, 31)] times [mat(delim: #none, 7, 4; 4, 5)] = [mat(delim: #none, 517, 404; 404, 315)] \ [mat(delim: #none, 51, 40; 90, 71)] times [mat(delim: #none, 3, 4; 9, 5)] = [mat(delim: #none, 513, 404; 909, 715)] \ [mat(delim: #none, 51, 60; 10, 11)] times [mat(delim: #none, 9, 6; 1, 5)] = [mat(delim: #none, 519, 606; 101, 115)] \ [mat(delim: #none, 51, 60; 60, 71)] times [mat(delim: #none, 3, 6; 6, 5)] = [mat(delim: #none, 513, 606; 606, 715)] \ [mat(delim: #none, 51, 70; 30, 41)] times [mat(delim: #none, 6, 7; 3, 5)] = [mat(delim: #none, 516, 707; 303, 415)] \ [mat(delim: #none, 51, 80; 20, 31)] times [mat(delim: #none, 7, 8; 2, 5)] = [mat(delim: #none, 517, 808; 202, 315)] \ [mat(delim: #none, 51, 90; 40, 71)] times [mat(delim: #none, 3, 9; 4, 5)] = [mat(delim: #none, 513, 909; 404, 715)] \ [mat(delim: #none, 61, 10; 70, 11)] times [mat(delim: #none, 9, 1; 7, 4)] = [mat(delim: #none, 619, 101; 707, 114)] \ [mat(delim: #none, 61, 50; 50, 41)] times [mat(delim: #none, 6, 5; 5, 4)] = [mat(delim: #none, 616, 505; 505, 414)] \ [mat(delim: #none, 61, 70; 10, 11)] times [mat(delim: #none, 9, 7; 1, 4)] = [mat(delim: #none, 619, 707; 101, 114)] \ [mat(delim: #none, 61, 70; 70, 81)] times [mat(delim: #none, 2, 7; 7, 4)] = [mat(delim: #none, 612, 707; 707, 814)] \ [mat(delim: #none, 71, 10; 80, 11)] times [mat(delim: #none, 9, 1; 8, 3)] = [mat(delim: #none, 719, 101; 808, 113)] \ [mat(delim: #none, 71, 20; 40, 11)] times [mat(delim: #none, 9, 2; 4, 3)] = [mat(delim: #none, 719, 202; 404, 113)] \ [mat(delim: #none, 71, 30; 50, 21)] times [mat(delim: #none, 8, 3; 5, 3)] = [mat(delim: #none, 718, 303; 505, 213)] \ [mat(delim: #none, 71, 40; 20, 11)] times [mat(delim: #none, 9, 4; 2, 3)] = [mat(delim: #none, 719, 404; 202, 113)] \ [mat(delim: #none, 71, 40; 90, 51)] times [mat(delim: #none, 5, 4; 9, 3)] = [mat(delim: #none, 715, 404; 909, 513)] \ [mat(delim: #none, 71, 50; 30, 21)] times [mat(delim: #none, 8, 5; 3, 3)] = [mat(delim: #none, 718, 505; 303, 213)] \ [mat(delim: #none, 71, 60; 60, 51)] times [mat(delim: #none, 5, 6; 6, 3)] = [mat(delim: #none, 715, 606; 606, 513)] \ [mat(delim: #none, 71, 80; 10, 11)] times [mat(delim: #none, 9, 8; 1, 3)] = [mat(delim: #none, 719, 808; 101, 113)] \ [mat(delim: #none, 71, 80; 80, 91)] times [mat(delim: #none, 1, 8; 8, 3)] = [mat(delim: #none, 711, 808; 808, 913)] \ [mat(delim: #none, 71, 90; 40, 51)] times [mat(delim: #none, 5, 9; 4, 3)] = [mat(delim: #none, 715, 909; 404, 513)] \ [mat(delim: #none, 81, 10; 90, 11)] times [mat(delim: #none, 9, 1; 9, 2)] = [mat(delim: #none, 819, 101; 909, 112)] \ [mat(delim: #none, 81, 30; 30, 11)] times [mat(delim: #none, 9, 3; 3, 2)] = [mat(delim: #none, 819, 303; 303, 112)] \ [mat(delim: #none, 81, 50; 50, 31)] times [mat(delim: #none, 7, 5; 5, 2)] = [mat(delim: #none, 817, 505; 505, 312)] \ [mat(delim: #none, 81, 70; 70, 61)] times [mat(delim: #none, 4, 7; 7, 2)] = [mat(delim: #none, 814, 707; 707, 612)] \ [mat(delim: #none, 81, 90; 10, 11)] times [mat(delim: #none, 9, 9; 1, 2)] = [mat(delim: #none, 819, 909; 101, 112)] \ [mat(delim: #none, 81, 90; 90, 101)] times [mat(delim: #none, 0, 9; 9, 2)] = [mat(delim: #none, 810, 909; 909, 1012)] \ [mat(delim: #none, 91, 20; 50, 11)] times [mat(delim: #none, 9, 2; 5, 1)] = [mat(delim: #none, 919, 202; 505, 111)] \ [mat(delim: #none, 91, 40; 70, 31)] times [mat(delim: #none, 7, 4; 7, 1)] = [mat(delim: #none, 917, 404; 707, 311)] \ [mat(delim: #none, 91, 50; 20, 11)] times [mat(delim: #none, 9, 5; 2, 1)] = [mat(delim: #none, 919, 505; 202, 111)] \ [mat(delim: #none, 91, 70; 40, 31)] times [mat(delim: #none, 7, 7; 4, 1)] = [mat(delim: #none, 917, 707; 404, 311)] \ [mat(delim: #none, 91, 80; 80, 71)] times [mat(delim: #none, 3, 8; 8, 1)] = [mat(delim: #none, 913, 808; 808, 711)] \ [mat(delim: #none, 101, 30; 70, 21)] times [mat(delim: #none, 8, 3; 7, 0)] = [mat(delim: #none, 1018, 303; 707, 210)] \ [mat(delim: #none, 101, 70; 30, 21)] times [mat(delim: #none, 8, 7; 3, 0)] = [mat(delim: #none, 1018, 707; 303, 210)] \ [mat(delim: #none, 101, 90; 90, 81)] times [mat(delim: #none, 2, 9; 9, 0)] = [mat(delim: #none, 1012, 909; 909, 810)] \ [mat(delim: #none, 2, 2; 3, 2)] times [mat(delim: #none, 8, 4; 6, 8)] = [mat(delim: #none, 28, 24; 36, 28)] \ [mat(delim: #none, 2, 2; 4, 4)] times [mat(delim: #none, 4, 4; 8, 8)] = [mat(delim: #none, 24, 24; 48, 48)] \ [mat(delim: #none, 2, 3; 2, 2)] times [mat(delim: #none, 8, 6; 4, 8)] = [mat(delim: #none, 28, 36; 24, 28)] \ [mat(delim: #none, 2, 3; 3, 5)] times [mat(delim: #none, 2, 6; 6, 8)] = [mat(delim: #none, 22, 36; 36, 58)] \ [mat(delim: #none, 2, 4; 2, 4)] times [mat(delim: #none, 4, 8; 4, 8)] = [mat(delim: #none, 24, 48; 24, 48)] \ [mat(delim: #none, 3, 3; 3, 3)] times [mat(delim: #none, 6, 6; 6, 6)] = [mat(delim: #none, 36, 36; 36, 36)] \ [mat(delim: #none, 4, 2; 4, 2)] times [mat(delim: #none, 8, 4; 8, 4)] = [mat(delim: #none, 48, 24; 48, 24)] \ [mat(delim: #none, 4, 4; 2, 2)] times [mat(delim: #none, 8, 8; 4, 4)] = [mat(delim: #none, 48, 48; 24, 24)] \ [mat(delim: #none, 5, 3; 3, 2)] times [mat(delim: #none, 8, 6; 6, 2)] = [mat(delim: #none, 58, 36; 36, 22)] \ [mat(delim: #none, 6, 5; 10, 6)] times [mat(delim: #none, 8, 2; 4, 8)] = [mat(delim: #none, 68, 52; 104, 68)] \ [mat(delim: #none, 6, 5; 15, 11)] times [mat(delim: #none, 6, 2; 6, 8)] = [mat(delim: #none, 66, 52; 156, 118)] \ [mat(delim: #none, 6, 5; 20, 16)] times [mat(delim: #none, 4, 2; 8, 8)] = [mat(delim: #none, 64, 52; 208, 168)] \ [mat(delim: #none, 6, 10; 5, 6)] times [mat(delim: #none, 8, 4; 2, 8)] = [mat(delim: #none, 68, 104; 52, 68)] \ [mat(delim: #none, 6, 10; 10, 16)] times [mat(delim: #none, 4, 4; 4, 8)] = [mat(delim: #none, 64, 104; 104, 168)] \ [mat(delim: #none, 6, 10; 15, 26)] times [mat(delim: #none, 0, 4; 6, 8)] = [mat(delim: #none, 60, 104; 156, 268)] \ [mat(delim: #none, 6, 15; 5, 11)] times [mat(delim: #none, 6, 6; 2, 8)] = [mat(delim: #none, 66, 156; 52, 118)] \ [mat(delim: #none, 6, 15; 10, 26)] times [mat(delim: #none, 0, 6; 4, 8)] = [mat(delim: #none, 60, 156; 104, 268)] \ [mat(delim: #none, 6, 20; 5, 16)] times [mat(delim: #none, 4, 8; 2, 8)] = [mat(delim: #none, 64, 208; 52, 168)] \ [mat(delim: #none, 11, 5; 15, 6)] times [mat(delim: #none, 8, 2; 6, 6)] = [mat(delim: #none, 118, 52; 156, 66)] \ [mat(delim: #none, 11, 15; 5, 6)] times [mat(delim: #none, 8, 6; 2, 6)] = [mat(delim: #none, 118, 156; 52, 66)] \ [mat(delim: #none, 11, 15; 15, 21)] times [mat(delim: #none, 2, 6; 6, 6)] = [mat(delim: #none, 112, 156; 156, 216)] \ [mat(delim: #none, 16, 5; 20, 6)] times [mat(delim: #none, 8, 2; 8, 4)] = [mat(delim: #none, 168, 52; 208, 64)] \ [mat(delim: #none, 16, 10; 10, 6)] times [mat(delim: #none, 8, 4; 4, 4)] = [mat(delim: #none, 168, 104; 104, 64)] \ [mat(delim: #none, 16, 20; 5, 6)] times [mat(delim: #none, 8, 8; 2, 4)] = [mat(delim: #none, 168, 208; 52, 64)] \ [mat(delim: #none, 16, 20; 20, 26)] times [mat(delim: #none, 0, 8; 8, 4)] = [mat(delim: #none, 160, 208; 208, 264)] \ [mat(delim: #none, 21, 15; 15, 11)] times [mat(delim: #none, 6, 6; 6, 2)] = [mat(delim: #none, 216, 156; 156, 112)] \ [mat(delim: #none, 26, 10; 15, 6)] times [mat(delim: #none, 8, 4; 6, 0)] = [mat(delim: #none, 268, 104; 156, 60)] \ [mat(delim: #none, 26, 15; 10, 6)] times [mat(delim: #none, 8, 6; 4, 0)] = [mat(delim: #none, 268, 156; 104, 60)] \ [mat(delim: #none, 26, 20; 20, 16)] times [mat(delim: #none, 4, 8; 8, 0)] = [mat(delim: #none, 264, 208; 208, 160)]
$
