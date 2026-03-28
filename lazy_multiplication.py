# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "marimo>=0.21.1",
#     "numpy==2.4.3",
#     "sympy==1.14.0",
# ]
# ///

import marimo

__generated_with = "0.21.1"
app = marimo.App(width="medium")

with app.setup:
    import marimo as mo
    import numpy as np
    import sympy as sm
    import itertools


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # Lazy Matrix Multiplication
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.outline()
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # The Problem

    There is a class of matrices where the multiplication of matrices looks like digit concatentation

    $$
    \begin{pmatrix}
      3 & 4 \\
      8 & 7 \\
    \end{pmatrix} \begin{pmatrix}
      7 & 2 \\
      4 & 9
    \end{pmatrix} =
    \begin{pmatrix}
      37 & 42 \\
      84 & 79 \\
    \end{pmatrix}
    $$

    Can we find them all? (Gotta Catche Em All!)
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # Summary of Main Results
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    It can be shown that the matrices must be of the following form

    $$
    A = \begin{pmatrix}
        k \alpha + 1 & k \beta \\
        k \gamma & k \delta + 1
    \end{pmatrix}
    $$

    $$
    B = \begin{pmatrix}
        \lambda \delta + 10 & - \lambda \beta \\
        -\lambda \gamma & \lambda \alpha +10
    \end{pmatrix}
    $$


    Where $\alpha, \beta, \gamma, \delta, \lambda, k \in \mathbb{Z}$
    $$
    \begin{align*}
    0 & < \delta & \le - \frac{10}{\lambda} \\
    0 & < \beta & < - \frac{10}{\lambda} \\
    0 & < \gamma & < - \frac{10}{\lambda} \\
    0 & < \alpha & \le - \frac{10}{\lambda} \\
    \end{align*}
    $$

    With $k > 0$,

    $$
    \lambda k (\alpha \delta - \beta \gamma) = 10
    $$

    $$
    \beta \gamma - \alpha \delta = - \frac{10}{\lambda k} = \mu \text{ }(\in \mathbb{Z}^+)
    $$
    This means that,
    $$
    k \in \begin{cases}
    \{1 , 2 , 5 ,10\} &\text{  if  } \lambda = - 1 \\
    \{1 , 5\} &\text{  if  } \lambda = - 2
    \end{cases}
    $$
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # Utility Functions
    """)
    return


@app.function
def abcd_to_matrix(a,b,c,d,lam,k):
    '''
       convert alpha(a),beta(b),gamma(c),delta(d)  and lambda (lam) and k
       to the two matrices
    '''
    B = lam*np.array([d,-b,-c,a]).reshape(2,2)+10*np.eye(2)
    A = k*np.array([a,b,c,d]).reshape(2,2)+np.eye(2)
    A,B = A.astype(int),B.astype(int)
    return (A,B)


@app.function(hide_code=True)
def print_nice(A,B):
    '''
    Print A,B and AB in a nice way for visualization
    '''
    AA = sm.Matrix(A)
    BB = sm.Matrix(B)
    CC = sm.Matrix(A@B)
    return f'''
    ${sm.latex(AA)} \\times {sm.latex(BB)} = {sm.latex(CC)}$
    '''


@app.cell(hide_code=True)
def _():
    A1,B1 = abcd_to_matrix(a=3,b=5,c=2,d=3,lam=-1,k=10)
    mo.md(
        print_nice(A1,B1)
    )
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # Find all in the unconstrained case for A
    """)
    return


@app.function
def find_all(k,l):
    deltas = [i for i in range(1,10//(-l)+1)]
    alphas = [i for i in range(1,10//(-l)+1)]
    betas = [i for i in range(1,10//(-l))]
    gammas = [i for i in range(1,10//(-l))]

    mu = -10/(k*l)
    solutions = []
    for alpha,beta,gamma,delta in itertools.product(alphas,betas,gammas,deltas):
        val = beta*gamma-alpha*delta
        if(val == mu):
            solutions.append(
                (alpha,beta,gamma,delta,l,k)
            )

    return solutions


@app.cell
def _():
    lks = {
        -1:{1:[],2:[],5:[],10:[]},
        -2:{1:[],5:[]}
    }
    all_solutions = []
    for l in lks:
        for k in lks[l]:
            lks[l][k] = find_all(k,l)
            all_solutions.extend(lks[l][k])
    return all_solutions, lks


@app.cell
def _(lks):
    num_solutions = {l:{k:len(v) for (k,v) in x.items() } for (l,x) in lks.items()}
    return


@app.cell(hide_code=True)
def _(all_solutions):
    mo.callout(mo.md(rf"""
    Number of solutions in the unconstrained case for A  = {len(all_solutions)}
    """),kind='info')
    return


@app.cell(hide_code=True)
def _(all_solutions):
    matrices = tuple(abcd_to_matrix(a,b,c,d,l,k) for (a,b,c,d,l,k) in all_solutions)
    return (matrices,)


@app.cell(hide_code=True)
def _(matrices):
    all_solution_string = '\n' .join(
            print_nice(A,B) for A,B in matrices
    )
    return (all_solution_string,)


@app.cell(hide_code=True)
def _(all_solution_string):
    mo.accordion({"**List of solutions(Expand to View):**":mo.md(all_solution_string)})
    return


@app.cell(hide_code=True)
def _(matrices):
    print(r'\\'.join(
            print_nice(A,B)[6:-6] for A,B in matrices
    ))
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # A Constrained to Single Integer Matrix
    """)
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    Here we have the additional constraints that,
    $$
    \begin{align*}
     \alpha &\leq \frac{8}{k} \\
     \beta &\leq \frac{9}{k} \\
     \gamma &\leq \frac{9}{k} \\
     \delta &\leq \frac{8}{k} \\
    \end{align*}
    $$
    """)
    return


@app.function
def find_all_A_single(k,l):
    max_delta = min(10//(-l),8//k)
    max_alpha = min(10//(-l),8//k)
    max_beta = min(10//(-l)-1,9//k)
    max_gamma = min(10//(-l)-1,9//k)
    deltas = [i for i in range(1,max_delta+1)]
    alphas = [i for i in range(1,max_alpha+1)]
    betas = [i for i in range(1,max_beta+1)]
    gammas = [i for i in range(1,max_gamma+1)]
    mu = -10/(k*l)
    solutions = []
    for alpha,beta,gamma,delta in itertools.product(alphas,betas,gammas,deltas):
        val = beta*gamma-alpha*delta
        if(val == mu):
            solutions.append(
                (alpha,beta,gamma,delta,l,k)
            )

    return solutions


@app.cell
def _():
    def _():
        lks = {
            -1:{1:[],2:[],5:[],10:[]},
            -2:{1:[],5:[]}
        }
        all_solutions = []
        for l in lks:
            for k in lks[l]:
                lks[l][k] = find_all_A_single(k,l)
                all_solutions.extend(lks[l][k])
        return all_solutions
    all_solutions_A_single = _()
    return (all_solutions_A_single,)


@app.cell(hide_code=True)
def _(all_solutions_A_single):
    matrices_A_single = tuple(abcd_to_matrix(a,b,c,d,l,k) for (a,b,c,d,l,k) in all_solutions_A_single)
    return (matrices_A_single,)


@app.cell(hide_code=True)
def _(matrices_A_single):
    all_solution_A_single_string = '\n' .join(
            print_nice(A,B) for A,B in matrices_A_single
    )
    return (all_solution_A_single_string,)


@app.cell(hide_code=True)
def _(matrices_A_single):
    print(r'\\'.join(
            print_nice(A,B)[6:-6] for A,B in matrices_A_single
    ))
    return


@app.cell(hide_code=True)
def _(all_solutions_A_single):
    mo.callout(mo.md(rf"""
    Number of single matrix solutions= {len(all_solutions_A_single)}
    """),kind='info')
    return


@app.cell(hide_code=True)
def _(all_solution_A_single_string):
    mo.accordion({"**List of Solutions(Expand to View):**":mo.md(all_solution_A_single_string)})
    return


@app.cell(hide_code=True)
def _():
    mo.md(r"""
    # Brute Force Checking of Single Integer Case

    This is for checking whether the number of solutions we found for the single integer case is correct
    """)
    return


@app.cell
def _():
    integer_options = [[i for i in range(10)] for _ in range(4)]

    _sols = []
    for (a,b,c,d) in itertools.product(*integer_options):
        _sols.append(np.array([a,b,c,d]).reshape(2,2)) 
    all_single_matrices = np.stack(_sols,axis=0)
    return (all_single_matrices,)


@app.function
def check(As,Bs):
    mask_1 = np.all(As@Bs == (As*10+Bs),axis=(1,2)) # what we want
    mask_2 = ~np.any(As==0,axis=(1,2)) #exclude presence of zeros in A
    return mask_1 & mask_2


@app.cell
def _(all_single_matrices):
    sols = 0
    for roll in mo.status.progress_bar(range(all_single_matrices.shape[0])):
        As = all_single_matrices
        Bs = np.roll(all_single_matrices,axis=0,shift=roll)
        sols += np.sum(check(As,Bs))
    return (sols,)


@app.cell(hide_code=True)
def _(sols):
    mo.callout(mo.md(rf"""
    Number of single integer matrix solutions = {sols} (Found through Brute Force)
    """),kind='success')
    return


if __name__ == "__main__":
    app.run()
