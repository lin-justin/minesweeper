mutable struct MineField
    size::Tuple{Int64, Int64}
    numbers::Array{Int64, 2}
    possible_mines::Array{Bool, 2}
    actual_mines::Array{Bool, 2}
    visible::Array{Bool, 2}
end

function MineField(x, y)
    size           = (x, y)
    actual_mines   = convert(Array{Bool, 2}, rand(x, y) .< 0.15)
    possible_mines = zeros(Bool, x, y)
    numbers        = zeros(Int64, x, y)
    visible        = zeros(Bool, x, y)

    for i in 1:x
        for j in 1:y
            n = 0
            for di in -1:1
                for dj in -1:1
                    n += (0 < di + i <= x && 0 < dj + j <= y ? (actual_mines[di + i, dj + j] ? 1 : 0) : 0)
                end
            end
            numbers[i, j] = n
        end
    end

    return MineField(size, numbers, possible_mines, actual_mines, visible)
end

function displayField(f::MineField; showall = false)
    spaces = Int64(floor(log(10, f.size[2])))

    s = " "^(4 + spaces)
    for i in 1:f.size[1]
        s *= string(" ", i, " ")
    end

    s *= "\n" * " "^(4 + spaces) * "___"^f.size[1] * "\n"
    for j in 1:f.size[2]
        s *= " " * string(j) * " "^(floor(log(10, j)) > 0 ? 1 : spaces + 1) * "|"
        for i in 1:f.size[1]
            if showall
                s *= f.actual_mines[i, j] ? " * " : "   "
            else
                if f.visible[i, j]
                    s *= "" * string(f.numbers[i, j] > 0 ? f.numbers[i, j] : " ") * " "
                elseif f.possible_mines[i, j]
                    s *= " ? "
                else
                    s *= " . "
                end
            end
        end
        s *= "\r\n"
    end

    println("Found " * string(length(f.possible_mines[f.possible_mines .== true])) * 
            " of " * string(length(f.actual_mines[f.actual_mines .==  true])) * " mines.\n")
    println(s)
end

function parseInput(s::String)
    input = split(chomp(s), " ")
    mode = input[1]
    println(s)
    coords = length(input) > 1 ? (parse(Int64, input[2]), parse(Int64, input[3])) : (0, 0)
    return mode, coords
end

function reveal(f::MineField, x::Int64, y::Int64)
    (x > f.size[1] || y > f.size[2]) && return true
    f.actual_mines[x, y] && return false
    f.visible[x, y] = true
    
    if f.numbers[x, y] == 0
        for di in -1:1
            for dj in -1:1
                if (0 < di + x <= f.size[1] && 0 < dj + y <= f.size[2]) && f.actual_mines[x + di, y + dj] ==  false && f.visible[x + di, y + dj] == false
                    reveal(f, x + di, y + dj)
                end
            end
        end
    end

    return true
end

function evalInput(f::MineField, s::String)
    mode, coords = parseInput(s)
    (coords[1] > f.size[1] || coords[2] > f.size[2]) && return true
    if mode == "o"
        reveal(f, coords...) || return false
    elseif mode == "m" && f.visible[coords...] == false
        f.possible_mines[coords...] = !f.possible_mines[coords...]
    elseif mode == "close"
        error("Game closed")
    end

    return true
end

function play()
    println("Welcome to Minesweeper\n")
    print("Enter a grid size x y:\n")
    s = split(readline(), " ")
    f = MineField(parse.(Int64, s)...)

    won = false
    while true
        displayField(f)
        println("\nSelect: (\"o x y\" to reveal a field or \"m x y\" to toggle a mine or close)")
        evalInput(f, readline()) || break
        println("_"^80 * "\n")
        (f.actual_mines == f.possible_mines || f.visible == .!f.actual_mines) && (won = true; break)
    end
    println(won ? "Game won" : "Game lost")
    displayField(f, showall = true)
end

play()