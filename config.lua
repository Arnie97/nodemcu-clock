-- Avoid LED flickering
node.setcpufreq(160)

-- Pinout for 74HC595
pins = {
    data   = 3, -- SER
    clock  = 0, -- SRCLK
    latch  = 1, -- RCLK
    output = 2, -- OE
}

for name, pin in pairs(pins) do
    gpio.mode(pin, gpio.OUTPUT)
end
gpio.write(pins.output, 0)

-- Pins for different digit places
for pin = 5, 8 do
    gpio.mode(pin, gpio.OUTPUT)
    pwm.setup(pin, 1000, 0)
end
