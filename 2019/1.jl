using CSV

a = CSV.read("1.csv", header = false)

fuel(x) = begin
    if x < 7
        return 0
    else
        new_fuel = Int(floor(x / 3)) - 2
        return max(new_fuel, 0) + fuel(new_fuel)
    end
end

fuel.(a[:,1]) |> sum
