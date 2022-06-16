--[[

     Licensed under GNU General Public License v2
      * (c) 2016, Luca CPZ

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string
local type    = type

-- PulseAudio volume
-- lain.widget.pulse

local function factory(args)
    args = args or {}

    local pulse    = { widget = args.widget or wibox.widget.textbox(), device = "N/A" }
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    pulse.devicetype = args.devicetype or "sink"
    pulse.cmd = "echo \"Volume: $(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' 'NF > 0 {print $4}' | sed 's/^[ \t]*//;s/[ \t]*$//')\"; pactl get-sink-mute @DEFAULT_SINK@"

    function pulse.update()
        helpers.async({ shell, "-c", type(pulse.cmd) == "string" and pulse.cmd or pulse.cmd() },
            function(s)
                volume_now = {
                    muted = string.match(s, "Mute: (%S+)") or "N/A",
                    left = string.match(s, "Volume: (%d+)%%") or "N/A/",
                    right = string.match(s, "Volume: (%d+)%%") or "N/A/"
                }

                widget = pulse.widget
                settings()
            end)
    end

    helpers.newtimer("pulse", timeout, pulse.update)

    return pulse
end

return factory
