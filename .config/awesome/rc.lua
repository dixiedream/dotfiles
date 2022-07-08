-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, type = ipairs, string, os, table, tostring, type

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local my_table = awful.util.table
-- }}}

-- Xrandr script
local xrandr = require("xrandr")

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

run_once({ "setbg", "xcompmgr", "unclutter -root" })

-- }}}

-- {{{ Variable definitions
local modkey = "Mod4" -- Win / Mac Cmd button
local altkey = "Mod1"
local terminal = os.getenv("TERMINAL")
local vi_focus = false -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle trough all previous client or just the first -- https://github.com/lcpz/awesome-copycats/issues/274
local browser = os.getenv("BROWSER")
local filemanager = terminal .. " -e lf"
local scrlocker = "slock"

awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
awful.layout.layouts = {
    awful.layout.suit.tile,
    lain.layout.centerwork,
    awful.layout.suit.floating
}

awful.util.taglist_buttons = my_table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    )
)

awful.util.tasklist_buttons = my_table.join(
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
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
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

-- {{{ Keybinds functions }}}
local function raiseVolume()
    os.execute("pactl set-sink-volume @DEFAULT_SINK@ +5%")
    beautiful.volume.update()
end

local function lowerVolume()
    os.execute("pactl set-sink-volume @DEFAULT_SINK@ -5%")
    beautiful.volume.update()
end

local function toggleMute()
    os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    beautiful.volume.update()
end

local function toggleMicMute()
    os.execute("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
end

local function playPauseAudio()
    os.execute("playerctl play-pause")
end

local function previousSong()
    os.execute("playerctl previous")
end

local function nextSong()
    os.execute("playerctl next")
end

-- {{{ Key bindings
globalkeys = my_table.join(
-- Screen locker
    awful.key({ altkey, modkey }, "l", function() os.execute(scrlocker) end,
        { description = "lock screen", group = "hotkeys" }),
    -- Hotkeys
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    -- Default client focus
    -- awful.key({ modkey }, "p", function() os.execute("autorandr --cycle") end,
    awful.key({ modkey }, "p", function() xrandr.xrandr() end,
        { description = "cycle through display arrangements", group = "screen" }),
    awful.key(
        { modkey, "Shift" },
        "h",
        function()
            awful.screen.focus_relative(1)
        end,
        { description = "focus the next screen", group = "screen" }
    ),
    awful.key(
        { modkey, "Shift" },
        "l",
        function()
            awful.screen.focus_relative(-1)
        end,
        { description = "focus the previous screen", group = "screen" }
    ),
    awful.key(
        { modkey, }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key(
        { modkey, }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key(
        { modkey },
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
        { description = "cycle with previous/go back", group = "client" }
    ),
    -- On the fly useless gaps change
    awful.key(
        { altkey, "Control" },
        "+",
        function()
            lain.util.useless_gaps_resize(1)
        end,
        { description = "increment useless gaps", group = "tag" }
    ),
    awful.key(
        { altkey, "Control" },
        "-",
        function()
            lain.util.useless_gaps_resize(-1)
        end,
        { description = "decrement useless gaps", group = "tag" }
    ),
    -- Standard program
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
    awful.key(
        { altkey, "Shift" },
        "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        { description = "increase master width", group = "layout" }
    ),
    awful.key(
        { altkey, "Shift" },
        "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        { description = "decrease master width", group = "layout" }
    ),
    awful.key({ modkey }, "space", function() awful.layout.inc(1) end, { description = "select next", group = "layout" })
    ,
    -- Brightness
    awful.key({}, "XF86MonBrightnessUp", function() os.execute("brightnessctl set 10%+") end),
    awful.key({}, "XF86MonBrightnessDown", function() os.execute("brightnessctl set 10%-") end),
    -- Volume Keys
    awful.key({}, "XF86AudioLowerVolume", lowerVolume),
    awful.key({}, "XF86AudioRaiseVolume", raiseVolume),
    awful.key({}, "XF86AudioMute", toggleMute),
    awful.key({}, "XF86AudioMicMute", toggleMicMute),
    awful.key({ altkey }, "Up", raiseVolume, { description = "volume up", group = "hotkeys" }),
    awful.key({ altkey }, "Down", lowerVolume, { description = "volume down", group = "hotkeys" }),
    awful.key({ altkey }, "m", toggleMute, { description = "toggle mute", group = "hotkeys" }),
    -- Music player controls (requires playerctl package)
    awful.key({ altkey, "Control" }, "Up", playPauseAudio, { description = "play - pause", group = "music" }),
    awful.key({}, "XF86AudioStop", playPauseAudio),
    awful.key({}, "XF86AudioPlay", playPauseAudio),
    awful.key({ altkey, "Control" }, "Left", previousSong, { description = "previous song", group = "music" }),
    awful.key({}, "XF86AudioPrev", previousSong),
    awful.key({ altkey, "Control" }, "Right", nextSong, { description = "next song", group = "music" }),
    awful.key({}, "XF86AudioNext", nextSong),
    -- Screenshot
    awful.key({}, "Print", function() os.execute("screenshot") end),
    -- User programs
    awful.key({ modkey }, "q", function() awful.spawn(browser) end, { description = "browser", group = "launcher" }),
    awful.key({ modkey }, "n", function() awful.spawn(filemanager) end,
        { description = "file manager", group = "launcher" }),
    -- dmenu
    awful.key({ modkey }, "d", function() os.execute("dmenu_run -i") end,
        { description = "launcher", group = "launcher" })
)

clientkeys = my_table.join(
    awful.key(
        { modkey },
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),
    awful.key(
        { modkey, "Shift" },
        "c",
        function(c)
            c:kill()
        end,
        { description = "close", group = "client" }
    ),
    awful.key(
        { modkey, "Control" },
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        { description = "move to master", group = "client" }
    ),
    awful.key(
        { modkey },
        "o",
        function(c)
            c:move_to_screen()
        end,
        { description = "move to screen", group = "client" }
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_move
    if i == 1 or i == 9 then
        descr_view = { description = "view tag #", group = "tag" }
        descr_move = { description = "move focused client to tag #", group = "tag" }
    end
    globalkeys = my_table.join(
        globalkeys,
        -- View tag only.
        awful.key(
            { modkey },
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
            { modkey, "Shift" },
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

clientbuttons = gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end
    ),
    awful.button(
        { modkey },
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        { modkey },
        3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
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
        rule = { class = "Gimp", role = "gimp-image-window" },
        properties = { maximized = true }
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
        c:emit_signal("request::activate", "mouse_enter", { raise = vi_focus })
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

-- awful.spawn.with_shell("setbg")
