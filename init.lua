require('config')
require('digits')
require('shiftout')

tmr.alarm(1, 1000, 1, function()
    -- Enable all outputs
    gpio.write(pins.output, 0)

    for i = 1, 50 do
        for pin = 5, 8 do
            -- Keep current output status
            gpio.write(pins.latch, 0)
            shiftout(digits[9 - pin])

            -- Deactivate the previous digit place
            if pin ~= 5 then
                gpio.write(pin - 1, 0)
            else
                gpio.write(8, 0)
            end

            -- Transfer changes to output pins
            gpio.write(pins.latch, 1)
            gpio.write(pin, 1)
        end
    end

    -- Disable all outputs
    gpio.write(pins.output, 1)
end)
