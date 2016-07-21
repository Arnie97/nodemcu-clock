wifi.sta.eventMonStop()
wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
    local ip, nm, gw = wifi.sta.getip()
    print(
        'Wifi connected as ' .. ip ..
        ' (netmask ' .. nm .. ', gateway ' .. gw .. ')'
    )
    print('Synchronizing clock with NTP server...')
    sntp.sync(
        sync.server,
        function(s, us, server)
            print('Successfully synchronized with ' .. server)
        end,
        function(err)
            local msg = {
                'DNS lookup failed',
                'Memory allocation failure',
                'UDP send failed',
                'Timeout, no NTP response received'
            }
            print('Error: ' .. msg[err])
        end
    )
end)
wifi.sta.eventMonStart()
wifi.setmode(wifi.STATION)
wifi.sta.config(sync.ssid, sync.password)
