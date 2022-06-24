--[[

     Licensed under GNU General Public License v2
      * (c) 2018, Luca CPZ

--]]

local helpers  = require("lain.helpers")
local markup   = require("lain.util.markup")
local awful    = require("awful")
local naughty  = require("naughty")
local floor    = math.floor
local os       = os
local pairs    = pairs
local string   = string
local tconcat  = table.concat
local type     = type
local tonumber = tonumber
local tostring = tostring
local utf8     = utf8
local browser  = os.getenv('BROWSER')

-- Calendar notification
-- lain.widget.gCal
local function factory(args)
    args = args or {}
    local cal = {
        attach_to = args.attach_to or {},
    }

    function cal.launchCalendar()
        awful.spawn(browser .. " " .. "https://calendar.google.com/calendar/u/0/r/year")
    end

    function cal.attach(widget)
        widget:buttons(awful.util.table.join(
            awful.button({}, 1, cal.launchCalendar)))
    end

    for _, widget in pairs(cal.attach_to) do cal.attach(widget) end

    return cal
end

return factory
