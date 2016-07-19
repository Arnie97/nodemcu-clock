require('config')
require('digits')
require('shiftout')

function refresh(duty)
    for pin = 5, 8 do
        -- Keep current output status
        gpio.write(pins.latch, 0)
        shiftout(digits[9 - pin])

        -- Deactivate the previous digit place
        pwm.setduty(pin ~= 5 and pin - 1 or 8, 0)

        -- Transfer changes to output pins
        gpio.write(pins.latch, 1)
        pwm.setduty(pin, duty)
    end
end

tmr.alarm(0, 1000, tmr.ALARM_AUTO, function()
    for duty = 0, 1000, 40 do
        refresh(duty)
    end
    for duty = 1000, 0, -40 do
        refresh(duty)
    end
end)
