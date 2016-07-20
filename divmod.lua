function divmod(x, y)
    local quotient = math.floor(x / y)
    local remainder = x - y * quotient
    return quotient, remainder
end
