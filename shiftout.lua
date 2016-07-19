-- Lua does not support binary literals, so we treat nibbles
-- in hexadecimal literals as bits in binary literals.
function shiftout(nibbles)
    for pos = 7, 0, -1 do
        gpio.write(pins.clock, 0)
        gpio.write(
            pins.data,
            bit.isset(nibbles, pos * 4) and 1 or 0
        )
        gpio.write(pins.clock, 1)
    end
end
