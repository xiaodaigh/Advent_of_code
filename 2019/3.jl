using CSV, StatsBase

a = CSV.read("3.csv", delim = '|', header = false)


codes = split(a[1, 1], ",")
l = length.(codes)

directions = [c[1] for c in codes]
steps = [parse(Int, c[2:end]) for c in codes]



countmap(directions)
countmap(steps)

sort(unique(steps))

function draw(direction, steps)
    current = [0, 0]
    route1 = Dict{Tuple{Int, Int}, Bool}()
    for (d, s) in zip(directions, steps)
        if d == 'U'
            for i in current[1]+1:current[1]+s
                route1[(i, current[2])] = true
            end
            current[1] +=  s
        elseif d == 'D'
            for i in current[1]-1:-1:current[1]-s
                route1[(i, current[2])] = true
            end
            current[1] -=  s
        elseif d == 'L'
            for i in current[2]-1:-1:current[2]-s
                route1[(current[1], i)] = true
            end
            current[2] -=  s
        else
            for i in current[2]+1:current[2]+s
                route1[(current[1], i)] = true
            end
            current[2] +=  s
        end
    end
    route1
end

route1 = draw(directions, steps)


codes = split(a[2, 1], ",")
l = length.(codes)
directions = [c[1] for c in codes]
steps = [parse(Int, c[2:end]) for c in codes]

route2 = draw(directions, steps)

intersect(keys(route1), keys(route2))

sort(intersect(keys(route1), keys(route2)) |> collect, by = x->abs(x[1])+abs(x[2]))[1]

# 2nd problem

using CSV, StatsBase

# a function to record the path
function draw(direction, steps)
    # current position
    current = [0, 0]
    # use a dictionary to keep track of where it has been and count the number of steps
    route1 = Dict{Tuple{Int, Int}, Int}()
    steps_so_far = 0
    for (d, s) in zip(directions, steps)
        if d == 'U'
            for i in current[1]+1:current[1]+s
                steps_so_far += 1
                route1[(i, current[2])] = steps_so_far
            end
            current[1] +=  s
        elseif d == 'D'
            for i in current[1]-1:-1:current[1]-s
                steps_so_far += 1
                route1[(i, current[2])] = steps_so_far
            end
            current[1] -=  s
        elseif d == 'L'
            for i in current[2]-1:-1:current[2]-s
                steps_so_far += 1
                route1[(current[1], i)] = steps_so_far
            end
            current[2] -=  s
        else
            for i in current[2]+1:current[2]+s
                steps_so_far += 1
                route1[(current[1], i)] = steps_so_far
            end
            current[2] +=  s
        end
    end
    route1
end

# read data
a = CSV.read("3.csv", delim = '|', header = false)

# record route 1
codes = split(a[1, 1], ",")
directions = [c[1] for c in codes]
steps = [parse(Int, c[2:end]) for c in codes]
route1 = draw(directions, steps)

# record route 2
codes = split(a[2, 1], ",")
directions = [c[1] for c in codes]
steps = [parse(Int, c[2:end]) for c in codes]
route2 = draw(directions, steps)

# find intersections
intersections = intersect(keys(route1), keys(route2)) |> collect

# find minimum steps
minimum([route1[intersection] + route2[intersection] for intersection in intersections])
