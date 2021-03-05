local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local os = os
local my_table = awful.util.table

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome"
theme.font = "monospace 8" 
theme.bg_normal = xrdb.background or "#000000"
theme.bg_focus = xrdb.background or xrdb.color12 or "#000000"
theme.bg_urgent = xrdb.background or xrdb.color9 or "#000000"
theme.fg_normal = xrdb.foreground or "#aaaaaa"
theme.fg_focus = xrdb.color6 or "#ff8c00"
theme.fg_urgent = xrdb.color1 or "#af1d18"
theme.fg_minimize = xrdb.cursorColor or "#ffffff"
theme.border_width = dpi(1)
theme.border_normal = xrdb.color0 or "#1c2022"
theme.border_focus = xrdb.color8 or "#606060"
theme.border_marked = xrdb.color10 or "#3ca4d8"
theme.taglist_squares_sel = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = 3
theme.layout_tile = theme.confdir .. "/icons/tile.png"
theme.layout_floating = theme.confdir .. "/icons/floating.png"
theme.layout_centerwork = theme.confdir .. "/icons/centerwork.png"

local markup = lain.util.markup

local colors = {}
colors.hours = "#d08770"
colors.clockSeparator = xrdb.color1
colors.date = xrdb.color6

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock =
    wibox.widget.textclock(markup(colors.date, "%A %d %B ") .. markup(colors.clockSeparator, ">") .. markup(colors.hours, " %H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal =
    lain.widget.cal(
    {
        attach_to = {mytextclock},
        notification_preset = {
            font = theme.font .. " 10",
            fg = theme.fg_normal,
            bg = theme.bg_normal
        }
    }
)

-- CPU
local cpu =
    lain.widget.cpu(
    {
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, xrdb.color1, "CPU " .. cpu_now.usage .. "% "))
        end
    }
)

-- Coretemp
local temp =
    lain.widget.temp(
    {
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, xrdb.color2, "T " .. coretemp_now .. "°C "))
        end
    }
)

-- Battery
local bat =
    lain.widget.bat(
    {
        settings = function()
            local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

            if bat_now.ac_status == 1 then
                perc = perc .. " plug"
            end

            widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, "B " .. perc .. " "))
        end
    }
)

-- ALSA volume
theme.volume =
    lain.widget.alsa(
    {
        settings = function()
            if volume_now.status == "off" then
                volume_now.level = volume_now.level .. "M"
            end

            widget:set_markup(markup.fontfg(theme.font, "#5e81ac", "V " .. volume_now.level .. "% "))
        end
    }
)

-- Net
local netdowninfo = wibox.widget.textbox()
local netupinfo =
    lain.widget.net(
    {
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, xrdb.color14, "U " .. net_now.sent .. " "))
            netdowninfo:set_markup(markup.fontfg(theme.font, xrdb.color1, "D " .. net_now.received .. " "))
        end
    }
)

-- MEM
local memory =
    lain.widget.mem(
    {
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, xrdb.color3, mem_now.used .. "M "))
        end
    }
)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({app = awful.util.terminal})

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
        my_table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox =
        awful.wibar({position = "top", screen = s, height = dpi(19), bg = theme.bg_normal, fg = theme.fg_normal})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox
        },
        s.mytasklist, -- Middle widget
        --nil,
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            netdowninfo,
            netupinfo.widget,
            theme.volume.widget,
            memory.widget,
            cpu.widget,
            temp.widget,
            bat.widget,
            mytextclock,
            s.mylayoutbox
        }
    }
end

return theme
