# Minesweeper

Implemented the [Minesweeper](https://en.wikipedia.org/wiki/Minesweeper_(video_game)) game in Julia.

This was mainly for me to learn Julia.

# Usage

```
git clone https:
```

If Julia is added to your PATH, you can run as so:

```
> julia minesweeper.jl
Welcome to Minesweeper

Enter a grid size x y:
5 5
Found 0 of 6 mines.

     1  2  3  4  5 
    _______________
 1 | .  .  .  .  . 
 2 | .  .  .  .  . 
 3 | .  .  .  .  . 
 4 | .  .  .  .  . 
 5 | .  .  .  .  . 


Select: ("o x y" to reveal a field or "m x y" to toggle a mine or close)
o 1 2
________________________________________________________________________________

Found 0 of 6 mines.

     1  2  3  4  5
    _______________
 1 | .  .  .  .  .
 2 |1  .  .  .  .
 3 | .  .  .  .  .
 4 | .  .  .  .  .
 5 | .  .  .  .  .


Select: ("o x y" to reveal a field or "m x y" to toggle a mine or close)
o 2 3
________________________________________________________________________________

Found 0 of 6 mines.

     1  2  3  4  5
    _______________
 1 | .  .  .  .  .
 2 |1 1 2  .  .
 3 |    1  .  .
 4 |  1 2  .  .
 5 |  1  .  .  .


Select: ("o x y" to reveal a field or "m x y" to toggle a mine or close)
o 4 5
Game lost
Found 0 of 6 mines.

     1  2  3  4  5
    _______________
 1 | *        *
 2 |          *
 3 |             *
 4 |
 5 |       *  *
```
