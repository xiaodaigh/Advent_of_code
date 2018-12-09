nplayers = 458
nmarbles = 72019*100


function day9_2(nplayers, nmarbles)
    x = zeros(Int, nmarbles)
    x[1:2] = 0:1

    lengthx = 2

    pos = 2
    upto = 2
    score = 0
    scoreboard = Dict{Int, Int}([x=>0 for x in 1:nplayers])

    # preallocate an array


    player = 2
    @inbounds for i in 2:nmarbles
        if mod(upto, 23) == 0
            scoreboard[player] += upto
            pos = pos - 2 - 7
            if pos == 0
                pos = lengthx
            else
                pos = mod(pos, lengthx)
            end
            # remvoe this marble
            scoreboard[player] += x[pos]
            #x = vcat(x[1:pos-1], x[pos+1:end])
            #splice!(x, pos, )
            x[pos:lengthx] .= @view x[pos+1:lengthx+1]
            upto += 1
            pos += 2
            lengthx = lengthx - 1
        else
            if pos > lengthx + 1
                pos = mod(pos, lengthx)
            end
            #x = vcat(x[1:pos-1], upto, x[pos:end])
            #splice!(x, pos:pos-1, upto)
            x[pos+1:lengthx+1] .= @view x[pos:lengthx]
            x[pos] = upto
            lengthx = lengthx + 1
            upto += 1
            pos = pos + 2
        end
        player += 1
        if player == nplayers+1
          player = 1
        end
    end
    maximum([v for v in values(scoreboard)])
end

@time day9_2(458, 72019)
@time day9_2(458, 72019*100)

@code_warntype day9_2(458, 72019)
