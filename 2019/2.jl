using CSV
a = CSV.read("2.csv", header = false, delim='|')

x = parse.(Int, split(a[1,1], ',') )

x[2] = 12
x[3] = 2

i = 1

done = false
while !done
    global i, done
    if x[i] == 99
        done = true
    elseif x[i] == 1
        x[x[i+3]+1] = x[x[i+1]+1] + x[x[i+2]+1]
        println("add")
    elseif x[i] == 2
        x[x[i+3]+1] = x[x[i+1]+1] * x[x[i+2]+1]
        println("mult")
    end
    i += 4
end

x[1]

# second part

using CSV
a = CSV.read("2.csv", header = false, delim='|')

y = parse.(Int, split(a[1,1], ',') )

fn(a,b) = begin
    x = copy(y)
    i = 1
    done = false
    x[2] = a
    x[3] = b
    while !done
        if x[i] == 99
            done = true
        elseif x[i] == 1
            x[x[i+3]+1] = x[x[i+1]+1] + x[x[i+2]+1]
        elseif x[i] == 2
            x[x[i+3]+1] = x[x[i+1]+1] * x[x[i+2]+1]
        end
    i += 4
    end
    x[1]
end

using Base.Iterators

res = [fn(a,b) for (a,b) in product(0:99, 0:99)]

findall(res .== 19690720)
