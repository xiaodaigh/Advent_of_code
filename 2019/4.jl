
day41() = begin
    l=183564
    h=657474
    cnt = 0
    for i in l:h
        dd = @view digits(i)[end:-1:1]
        ddd = diff(dd)
        cnt += all(ddd .>= 0) & any(ddd .== 0)
    end
    cnt
end

# 
# l=183564
# h=657474
# ok(a) = !any(==(0), a[1:end-1] .+ a[2:end])
# ispass(a) = any(==(0), a) && all(>=(0), a) && ok(a)
# ipw(n) = ispass(diff(reverse(digits(n))))
# count(ipw, l:h)
#
# l=183564
#
# ipw(l)
#
#
#
# day42() = begin
#     l=183564
#     h=657474
#
# end
#
# day42()


day42() = begin
    l=183564
    h=657474
    cnt = 0
    for i in l:h
        dd = @view digits(i)[end:-1:1]
        ddd = diff(dd)
        if all(ddd .>= 0)
            pos = findall(ddd .== 0)
            if length(pos) > 0
                done = false
                for p in pos
                    if p == 1
                        if ddd[2] != 0
                            done = true
                        end
                    elseif p == 5
                        if ddd[4] != 0
                            done = true
                        end
                    else
                        if (ddd[p-1] !=0) & (ddd[p+1] != 0)
                            done = true
                        end
                    end
                end
                cnt += done
            end
        end
    end

    cnt
end

day42()
