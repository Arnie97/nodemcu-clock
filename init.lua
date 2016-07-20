require('config')
require('digits')
require('divmod')
require('shiftout')

function time()
    local date, hour = divmod(rtctime.get() + 8 * 3600, 86400)
    local hour, minute = divmod(hour, 3600)
    local minute, second = divmod(minute, 60)
    local text = {{divmod(hour, 10)}, {divmod(minute, 10)}}
    return text[1][1], text[1][2], text[2][1], text[2][2]
end

function refresh(text, duty)
    for pin = 5, 8 do
        -- Keep current output status
        gpio.write(pins.latch, 0)
        shiftout(digits[text[9 - pin]])

        -- Deactivate the previous digit place
        pwm.setduty(pin ~= 5 and pin - 1 or 8, 0)

        -- Transfer changes to output pins
        gpio.write(pins.latch, 1)
        pwm.setduty(pin, duty)
    end
end

tmr.alarm(0, 1000, tmr.ALARM_AUTO, function()
    local text = {time()}
    for duty = 0, 1000, 40 do
        refresh(text, duty)
    end
    for duty = 1000, 0, -40 do
        refresh(text, duty)
    end
end)
