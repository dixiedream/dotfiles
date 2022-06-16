--[[

     Licensed under GNU General Public License v2
      * (c) 2016, Luca CPZ

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string

-- Pipewire volume
-- lain.widget.pipewire
local function factory(args)
    args = args or {}

    local pipewire    = { widget = args.widget or wibox.widget.textbox(), device = "N/A" }
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    pipewire.cmd = "echo \"Volume: $(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' 'NF > 0 {print $4}' | sed 's/^[ \t]*//;s/[ \t]*$//')\"; pactl get-sink-mute @DEFAULT_SINK@"

    function pipewire.update()
        helpers.async({ shell, "-c", pipewire.cmd },
            function(s)
                volume_now = {
                    muted = string.match(s, "Mute: (%S+)") or "N/A",
                    value = string.match(s, "Volume: (%d+)%%") or "N/A/",
                }

                widget = pipewire.widget
                settings()
            end)
    end

    helpers.newtimer("pipewire", timeout, pipewire.update)

    return pipewire
end

return factory
