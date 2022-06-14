<div align="center">

<h3 align="center">Sudoku Solver</h3>

  <p align="center">
    A simple backtracking based Sudoku puzzle Solver
  </p>
</div>




<!-- ABOUT THE PROJECT -->
## What's Sudoku?
Sudoku is a very old game with simple rules: you must fill a *N²*x*N²* square with integer numbers going from 1 to N² withouth having it repeated across the row, column or quadrant (*N*x*N* square).

## Why Sudoku?
Sudoku is a well known NP-complete problem when generalized to variable *N*x*N*. It's true that a fixed sized Sudoku cannot be considered NP-complete, however, it still shows some its true colors just by imagining a huge size for N, like *1000000*x*1000000*. You can check <a href="https://jcrouser.github.io/CSC250/projects/sudoku.html">this discussion about the topic.</a>

## The P Vs. NP problem
P = NP is an unsolved problem in Computer Science which states: "for every problem whose solution can be easily verified, it can also be easily discovered." Note that the term *"easily"* actually means *"in polynomial time (P)"*, i.e. *T(n) = O(n<sup>k</sup>)*. NP stands for *nondeterministic polynomial time*, which means that a nondeterministic computer could solve the problem in polynomial time. Being able to prove that P = NP would mean that the hardest problems humanity faces (mathematicaly speaking) could be solved in polynomial time, including problems such as protein folding and optimal logistics strategies. On the other hand, fields that depend on P being not equalt NP, such as cryptography, could be negatively impacted.<br><br>
<div align="center">
<img style="width: 500px; height: auto;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/P_np_np-complete_np-hard.svg/800px-P_np_np-complete_np-hard.svg.png"><br>
</div>
<span style="font-size:12px">*NP/NP-hard realms for P≠NP and P=NP. Author: Behnam Esfahbod. Taken from: https://en.wikipedia.org/wiki/File:P_np_np-complete_np-hard.svg, jun 14 2022.*</span>

<!-- REFERENCES -->
## References
- *Ruby(Ziheng) Ru, Kristen(Zidan) Huang, Lingge Nox Yu. Discussing NP-Completeness of Sudoku Game. Taken from: https://jcrouser.github.io/CSC250/projects/sudoku.html, jun 14 2022.*
- *P versus NP problem. Wikipedia. Taken from: https://en.wikipedia.org/wiki/P_versus_NP_problem, jun 14 2022.*

<!-- LICENSE -->
## License

Distributed under the CC-0 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>
