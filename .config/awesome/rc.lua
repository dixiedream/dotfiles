-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, type = ipairs, string, os, table, tostring, type

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local my_table = awful.util.table
local dpi = require("beautiful.xresources").apply_dpi
local xrandr = require("xrandr")
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end
-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({"unclutter -root"})

-- }}}

-- {{{ Variable definitions
local modkey = "Mod4"
local altkey = "Mod1"
local terminal = os.getenv("TERMINAL") or "st"
local vi_focus = false -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle trough all previous client or just the first -- https://github.com/lcpz/awesome-copycats/issues/274
local font = "monospace"
local editor = os.getenv("EDITOR") or "vim"
local browser = os.getenv("BROWSER") or "firefox"
local filemanager = terminal .. " -e ranger"
local scrlocker = "slock"

awful.util.terminal = terminal
awful.util.tagnames = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
awful.layout.layouts = {
    awful.layout.suit.tile,
    lain.layout.centerwork,
    awful.layout.suit.floating
}

awful.util.taglist_buttons =
    my_table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    )
)

awful.util.tasklist_buttons =
    my_table.join(
    awful.button(
        {},
        1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                client.focus = c
                c:raise()
            end
        end
    )
)

beautiful.init(string.format("%s/.config/awesome/theme.lua", os.getenv("HOME")))
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal(
    "property::geometry",
    function(s)
        os.execute("setbg")
    end
)
--

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal(
    "arrange",
    function(s)
        local only_one = #s.tiled_clients == 1
        for _, c in pairs(s.clients) do
            if only_one and not c.floating or c.maximized then
                c.border_width = 0
            else
                c.border_width = beautiful.border_width
            end
        end
    end
)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
    function(s)
        beautiful.at_screen_connect(s)
    end
)
-- }}}

-- {{{ Key bindings
globalkeys =
    my_table.join(
    -- X screen locker
    awful.key(
        {altkey, modkey},
        "l",
        function()
            os.execute(scrlocker)
        end,
        {description = "lock screen", group = "hotkeys"}
    ),
    -- Hotkeys
    awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
    -- Tag browsing
    awful.key({modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),
    -- Default client focus
    awful.key(
        {modkey, "Control"},
        "j",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        {modkey, "Control"},
        "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key(
        {modkey}, "u", 
        awful.client.urgent.jumpto, 
        {description = "jump to urgent client", group = "client"}),
    awful.key(
        { modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        { modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key(
        {modkey},
        "Tab",
        function()
            if cycle_prev then
                awful.client.focus.history.previous()
            else
                awful.client.focus.byidx(-1)
            end
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "cycle with previous/go back", group = "client"}
    ),
    -- On the fly useless gaps change
    awful.key(
        {altkey, "Control"},
        "+",
        function()
            lain.util.useless_gaps_resize(1)
        end,
        {description = "increment useless gaps", group = "tag"}
    ),
    awful.key(
        {altkey, "Control"},
        "-",
        function()
            lain.util.useless_gaps_resize(-1)
        end,
        {description = "decrement useless gaps", group = "tag"}
    ),
    -- Standard program
    awful.key(
        {modkey},
        "Return",
        function()
            awful.spawn(terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key({modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
    awful.key(
        {altkey, "Shift"},
        "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key(
        {altkey, "Shift"},
        "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key(
        {modkey, "Control"},
        "h",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key(
        {modkey, "Control"},
        "l",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key(
        {modkey},
        "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    awful.key(
        {modkey, "Control"},
        "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}
    ),
    -- Brightness
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            os.execute("brightnessctl set 10%+")
        end
    ),
    awful.key(
        {},
        "XF86MonBrightnessDown",
        function()
            os.execute("brightnessctl set 10%-")
        end
    ),
    -- Volume Keys
    awful.key(
        {}, 
        "XF86AudioLowerVolume", 
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key(
        {}, 
        "XF86AudioRaiseVolume", 
        function()
            os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key(
        {}, 
        "XF86AudioMute", 
        function ()
            os.execute(
                string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel)
            )
            beautiful.volume.update()
        end),
    awful.key(
        {}, 
        "XF86AudioMicMute", 
        function ()
            os.execute("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
        end),
    -- ALSA volume control
    awful.key(
        {altkey},
        "Up",
        function()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume up", group = "hotkeys"}
    ),
    awful.key(
        {altkey},
        "Down",
        function()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume down", group = "hotkeys"}
    ),
    awful.key(
        {altkey},
        "m",
        function()
            os.execute(
                string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel)
            )
            beautiful.volume.update()
        end,
        {description = "toggle mute", group = "hotkeys"}
    ),
    -- CMUS controls
    awful.key(
        {altkey, "Control"},
        "Up",
        function()
            os.execute("cmus-remote --pause")
        end,
        {description = "cmus toggle", group = "cmus"}
    ),
    awful.key(
        {altkey, "Control"},
        "Down",
        function()
            os.execute("cmus-remote --stop")
        end,
        {description = "cmus stop", group = "cmus"}
    ),
    awful.key(
        {altkey, "Control"},
        "Left",
        function()
            os.execute("cmus-remote --prev")
        end,
        {description = "cmus prev", group = "cmus"}
    ),
    awful.key(
        {altkey, "Control"},
        "Right",
        function()
            os.execute("cmus-remote --next")
        end,
        {description = "cmus next", group = "cmus"}
    ),
    -- Screenshot
    awful.key({}, "Print",
        function()
            os.execute("screenshot")
        end
    ),
    -- User programs
    awful.key(
        {modkey},
        "q",
        function()
            awful.spawn(browser)
        end,
        {description = "run browser", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "n",
        function()
            awful.spawn(filemanager)
        end,
        {description = "run file manager", group = "launcher"}
    ),
    -- Multiple screen switch
    awful.key(
        {modkey},
        "p",
        function()
            xrandr.xrandr()
        end,
        {description = "switch monitor layout", group = "hotkeys"}
    ),
    -- dmenu
    awful.key(
        {modkey},
        "d",
        function()
            os.execute(
                string.format(
                    "dmenu_run -i -fn '%s-9' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
                    font,
                    beautiful.bg_normal,
                    beautiful.fg_normal,
                    beautiful.bg_focus,
                    beautiful.fg_focus
                )
            )
        end,
        {description = "show dmenu", group = "launcher"}
    )
)

clientkeys =
    my_table.join(
    awful.key({altkey, "Shift"}, "m", lain.util.magnify_client, {description = "magnify client", group = "client"}),
    awful.key(
        {modkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "c",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = "client"}
    ),
    awful.key(
        {modkey},
        "o",
        function(c)
            c:move_to_screen()
        end,
        {description = "move to screen", group = "client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_move
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
    end
    globalkeys =
        my_table.join(
        globalkeys,
        -- View tag only.
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),
        -- Move client to tag.
        awful.key(
            {modkey, "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            descr_move
        )
    )
end

clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        {modkey},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {modkey},
        3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false
        }
    },
    -- Programs specific
    {
        rule = {class = "Gimp", role = "gimp-image-window"},
        properties = {maximized = true}
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_offscreen(c)
        end
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
    end
)

client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)

awful.spawn.with_shell("setbg")
