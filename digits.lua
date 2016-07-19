digits = {
    -- 0 to 9 --
    0x00000010,
    0x11110010,
    0x00100100,
    0x01100000,
    0x11010000,
    0x01001000,
    0x00001000,
    0x11100010,
    0x00000000,
    0x01000000,

    -- a to f --
    0x10000000,
    0x00011000,
    0x00001110,
    0x00110000,
    0x00001100,
    0x10001100
}

-- Shift array items forward to make the first index zero
for i = 1, #digits do
    digits[i - 1] = digits[i]
end
digits[#digits] = nil
