--[[
                                
     aek6 Awesome WM config 1.0 
     github.com/aek6
                                
--]]

-- Required libraries {{{
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- local menubar = require("menubar")
local revelation= require("revelation")
local vicious   = require("vicious")
local lain      = require("lain")
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- Variable definitions {{{
local config  = os.getenv('HOME')..'/.config/awesome'
local bin     = os.getenv('DIR_DOTFILES')..'/scripts'

-- This is used later as the default terminal and editor to run.
terminal            = 'urxvtc' or 'urxvt' or 'xterm'
editor              = os.getenv('EDITOR') or 'vi' or 'nano'
editor_cmd          = terminal..' -e '.. editor

local terminal_tmux = terminal..' -e zsh -c "tmux -q has-session &&'
                                ..' exec tmux attach-session -d || '
                                ..'exec tmux new-session -s$USER"'
local mpd_client    = terminal..' -title "Music" -e ncmpcpp'    -- widget_mpd

local exec          = awful.util.spawn
local key           = awful.key

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey          = 'Mod4'
altkey          = 'Mod1'

-- }}}

-- init {{{
-- localization
os.setlocale(os.getenv("LANG"))

-- Themes define colours, icons, font and wallpapers.
beautiful.init(config .. "/themes/kland/theme.lua")

revelation.init()

naughty.config.defaults.border_width    = 1
naughty.config.defaults.border_color    = "#202020"
naughty.config.defaults.opacity         = 0.9
naughty.config.defaults.margin          = 15
-- }}}

-- -- Autostart applications {{{
-- local function run_once(cmd, path)
--     findme = cmd
--     firstspace = cmd:find(" ")
--     if firstspace then
--         findme = cmd:sub(0, firstspace-1)
--     end

--     if path then
--         cmd = path .. cmd
--     end
--     awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
-- end
-- -- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags & Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.magnifier
    
    -- awful.layout.suit.floating,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
}

-- Define a tag table which hold all screen tags.
tags = {
    name    = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
    layout  = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], 
                layouts[1], layouts[1], layouts[1], layouts[7] }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.name, s, tags.layout)
end
-- }}}

-- Menu {{{
-- Create mymainmenu
-- require("freedesktop/freedesktop")

-- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Widgets {{{
require("COLORS")

local function markup(text, color, size, bg)
    local color = color and 'foreground="'..color..'"' or ''
    local size  = size  and 'font="sans ' .. size..'"' or ''
    local bg    = bg    and 'background="'..bg..'"' or ''
    return '<span '..color..' '..size..' '..bg..'>'..text..'</span>'
end

local function get_icon(icon, color, size)
    return wibox.widget.textbox(markup(icon, color, size))
end

-- Space {{{
local function space(spaces)
    if spaces and spaces > 0 then
        spaces = spaces * 8
    else 
        spaces = 8
    end

    return wibox.widget.textbox(markup('  ', nil, spaces))
end
-- }}}

-- Menu {{{
local function widget_menu(menu, icon, text)
    if icon then icon = wibox.widget.imagebox(image)  end
    if text then text = wibox.widget.textbox(text)    end
    local widget = nil
    if icon and text then
        widget = wibox.layout.fixed.horizontal()
        widget:add(icon)
        widget:add(text)
    else 
        widget = icon or text or wibox.widget.textbox("menu")
    end

    widget:buttons(awful.util.table.join( awful.button(
        { }, 1, function() menu:toggle() end
    )))

    return widget
end
-- }}}

-- Shutdown {{{
local function widget_shutdown()
    local text, menu 
    text = "<span foreground='#EE2323' font='sans 14'><b></b></span>"
    menu = awful.menu({
        items = {
            { "Apagar", "sudo shutdown -h now", beautiful.shutdown},
            { "Reiniciar", "sudo reboot", beautiful.reboot},
            { "Suspender", "systemctl suspend", beautiful.suspend},
            { "Cerrar sesion", awesome.quit, beautiful.logout},
            -- lightdm
            { "Cambiar usuario", "dm-tool switch-to-greeter", beautiful.switch},
            -- xscreensaver
            { "Bloquear", "xscreensaver-command -lock", beautiful.lock}
        },
        theme = { width = 150 } 
    })

    return widget_menu(menu, nil, text)
end
-- }}}

-- Clock {{{
local function widget_clock()
    if not clock then 
        clock       = wibox.layout.fixed.horizontal()
        local icon  = get_icon("", nil, 11)
        local text  = awful.widget.textclock(markup(" %I:%M %p", "#ffffff"))

        clock:add(icon)
        clock:add(text)
    end

    return clock
end
-- }}}

-- Calendar {{{
local function widget_calendar()
    if not calendar then
        calendar    = wibox.layout.fixed.horizontal()
        local icon  = get_icon("", "#BBBBBB", 11)
        local text  = awful.widget.textclock(markup(" %A, %d de %B", "#bbbbbb"))

        lain.widgets.calendar:attach(calendar, { font = "monospace", font_size = 11, screen = mouse.screen })

        calendar:add(icon)
        calendar:add(text)
    end

    return calendar
end
-- }}}

-- Temperature CPU {{{
local function widget_temperature()
    if not temperature then
        temperature = wibox.layout.fixed.horizontal()
        local icon  = get_icon("", "#FFFF00", 10)
        local text  = wibox.widget.textbox()

        vicious.register(text, vicious.widgets.thermal,
            function(widget, args)
                local color = RED

                if args[1] < 45 then
                    color = GREEN
                elseif args[1] < 50 then
                    color = YELLOW
                elseif args[1] < 55 then
                    color = ORANGE
                end

                return markup(args[1].."°C", color)
            end 
            , 4, 'thermal_zone0'
        )

        temperature:add(icon)
        temperature:add(text)
    end

    return temperature
end
-- }}}

-- Cpu {{{
local function widget_cpu()
    if not cpu then
        cpu         = wibox.layout.fixed.horizontal()
        local icon  = get_icon("", "#CCBB00", 10)
        local text  = wibox.widget.textbox()

        vicious.register(text, vicious.widgets.cpu,
            function(widget, args)
                local color = RED

                if args[1] < 25 then
                    color = GREEN
                elseif args[1] < 50 then
                    color = YELLOW
                elseif args[1] < 75 then
                    color = ORANGE
                end

                return markup(args[1]..'%', color)
            end
        )

        cpu:add(icon)
        cpu:add(text)
    end

    return cpu
end
-- }}}

-- Mem {{{
local function widget_mem()
    if not mem then
        mem         = wibox.layout.fixed.horizontal()
        local icon  = get_icon("", "#777777", 10)
        local text  = wibox.widget.textbox()

        vicious.register(text, vicious.widgets.mem,
            function(widget, args)
                local color = RED

                if args[1] < 30 then
                    color = GREEN
                elseif args[1] < 60 then
                    color = YELLOW
                elseif args[1] < 85 then
                    color = ORANGE
                end

                if args[4] < 1024 then
                    return markup(args[4]..'M', color)
                else
                    return markup(math.floor((args[4]/1024) * 10^2 + 0.5) / (10^2) 
                                    .."G", color)
                end
            end,
            4
        )

        mem:add(icon)
        mem:add(text)
    end

    return mem
end
-- }}}

-- Net {{{
local function widget_net(interface)
    if not net then
        net         = wibox.layout.fixed.horizontal()
        local text  = wibox.widget.textbox()
        local icon  = {}
        icon.down   = get_icon("", "#06B800", 11)
        icon.up     = get_icon("", "#53B1FF", 11)

        vicious.register(text, vicious.widgets.net,
            function(widget, args)
                local interface = interface or "wlan0"
                local down      = tonumber(args['{'..interface..' down_kb}'])
                local up        = tonumber(args['{'..interface..' up_kb}'])
                local color_dn  = RED
                local color_up  = RED

                if down < 100 then
                    color_dn = GREEN
                elseif down < 300 then
                    color_dn = "#68B1E8"
                elseif down < 700 then
                    color_dn = "#DB70B8"
                elseif down < 1000 then
                    color_dn = "#9470DB"
                end

                if up < 15 then
                    color_up = GREEN
                elseif up < 35 then
                    color_up = "#9470DB"
                end

                return markup(down, color_dn)..' - '..markup(up, color_up)
            end
        )

        net:add(icon.down)
        net:add(text)
        net:add(icon.up)
    end

    return net
end
-- }}}

-- Music MPD {{{
local function widget_mpd()
    if not mpd then
        mpd             = wibox.layout.fixed.horizontal()
        local icon      = {
            mpd         = wibox.widget.textbox(" "),
            prev        = wibox.widget.textbox(" "),
            nex         = wibox.widget.textbox(" "),
            stop        = wibox.widget.textbox(" "),
            play_pause  = wibox.widget.textbox(" ")
        }
        local text      = lain.widgets.mpd({
            default_art = beautiful.notify.cover,
            settings = function ()
                if mpd_now.state == "play" then
                    -- mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
                    -- mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
                    widget:set_markup(markup(mpd_now.artist..' - '..mpd_now.title, 
                                        "#aaaaaa", 8))
                    icon.play_pause:set_text(" ")
                elseif mpd_now.state == "pause" then
                    widget:set_markup(markup("MPD PAUSED", "#aaaaaa", 8))
                    icon.play_pause:set_text(" ")
                else
                    widget:set_markup("")
                    icon.play_pause:set_text(" ")
                end
            end
        })
        local layout_text = wibox.layout.constraint()
        layout_text:set_strategy('max')
        layout_text:set_width(500)
        layout_text:set_widget(text)


        mpd_cmd = function(cmd)
            local cmd = "mpc " .. cmd .. " || ncmpcpp " .. cmd ..  " || ncmpc " 
                        .. cmd .. " || pms " .. cmd
            os.execute(cmd)
            text.update()
        end

        local function get_button(cmd)
            return awful.util.table.join( awful.button( {}, 1,
                function() mpd_cmd(cmd) end
            ))
        end

        -- Click Buttons
        text:buttons(awful.util.table.join(awful.button(
            {}, 1, function() os.execute(mpd_client) end
        )))
        icon.mpd:buttons(awful.util.table.join(awful.button(
            {}, 1, function() os.execute(mpd_client) end
        )))
        icon.prev:buttons(get_button("prev"))
        icon.nex:buttons(get_button("next"))
        icon.stop:buttons(get_button("stop"))
        icon.play_pause:buttons(get_button("toggle"))


        mpd:add(icon.prev)
        mpd:add(icon.nex)
        mpd:add(icon.stop)
        mpd:add(icon.play_pause)
        mpd:add(icon.mpd)
        mpd:add(layout_text)
    end

    return mpd
end
-- }}}

-- Volume bar ALSA {{{
local function widget_volume()
    if not volume then
        volume = {}
        local alsa = lain.widgets.alsabar({
            ticks  = true,
            width  = 80,
            height = 10,
            colors = {
                background  = "#252525",
                unmute      = "#80CCE6",
                mute        = "#FF9F9F"
            },
            notifications = {
                font        = "sans",
                font_size   = "12",
                bar_size    = 32,
                screen      = mouse.screen
            }
        })
        volume.widget = wibox.layout.margin(alsa.bar, 5, 10, 9, 6)

        local function set_volume(signo)
            exec("amixer -q set " .. alsa.channel .. "  " .. 
                alsa.step .. signo)
            alsa.notify()
        end

        volume.up     = function() set_volume("+") end
        volume.down   = function() set_volume("-") end
        volume.toggle = function()
            exec("amixer -q set " .. alsa.channel .. " playback toggle")
            alsa.notify()
        end
    end

    return volume.widget
end
-- }}}

-- Mail {{{
local function widget_mail()
    if not mail then
        mail        = wibox.layout.fixed.horizontal()
        mail_text   = wibox.widget.textbox()
        local icon  = get_icon(" ", "#FF9933", 10)
        local timer = timer({ timeout = 10 })
        local cmd   = config..'/scripts/gmail-widget mail_text &'

        os.execute(cmd)

        timer:connect_signal('timeout', function() os.execute(cmd) end)
        timer:start()

        mail:add(icon)
        mail:add(mail_text)
    end

    return mail
end

local function notify_mail(time)
    local time = time or 5
    local f, info

    f = io.popen(bin.."/gmail -p mails | sed 's/^/ /g'")
    info = f:read("*all")

    if info == "" then info = "..." end 
    f:close()

    naughty.notify({
        title   = "Gmail Inbox",
        text    = info,
        timeout = time,
        icon    = beautiful.notify.mail,
        screen      = mouse.screen
    })
end
-- }}}

-- Pacman {{{
local function notify_pacman()
    local f, info
    f = io.popen("pacman -Qu")
    info = f:read("*all")

    if info == "" then info = "0 Updates" end
    f:close()

    pacman_noti = naughty.notify ({
        title           = "Pacman Updates",
        text            = info,
        timeout         = 0,
        hover_timeout   = 0.5,
        position        = "bottom_right",
        icon            = beautiful.notify.pacman,
        screen          = mouse.screen
    })
end

local function widget_pacman()
    if not pacman then
        pacman      = wibox.layout.fixed.horizontal()
        pacman_text = wibox.widget.textbox()
        local icon  = wibox.widget.imagebox(beautiful.pacman)
        local timer = timer({ timeout = 300 })
        local cmd   = config..'/scripts/pacman-widget pacman_text &'

        os.execute(cmd)

        timer:connect_signal('timeout', function() os.execute(cmd) end)
        timer:start()

        pacman:buttons(awful.util.table.join(awful.button({}, 1, 
            function() 
                os.execute(terminal 
                            ..' -title "Pacman Update" -e sudo pacman -Su')
            end
        )))

        pacman:connect_signal('mouse::enter', function() notify_pacman() end)
        pacman:connect_signal('mouse::leave', 
                                function() naughty.destroy(pacman_noti) end)

        pacman:add(icon)
        pacman:add(pacman_text)
    end

    return pacman
end
-- }}}

-- Weather {{{
local weather               = lain.widgets.yawn(418442)
-- }}}

-- Redshift {{{
local redshift = {}

function redshift:init(args)
    self.command = args.command or self.command or '/usr/bin/redshift'
    self.options = args.options or self.options or ''
    self.notify  = args.notify  or self.notify  or false
    self.timer   = timer({ timeout = 60 })

    self.timer:connect_signal('timeout',
        function()
            local tmp = self.notify 
            self.notify = false
            self:toggle(1)
            self.notify = tmp 
        end)

    local tmp = self.notify 
    self.notify = false
    self:toggle(1)
    self.notify = tmp 
end

function redshift:toggle(value)
    local info, icon 
    self.state = value or self.state or 0
    
    if self.state == 0 then 
        os.execute(self.command..' -m randr -x '..self.options)
        self.timer:stop()
        info = 'Stop'
        icon = beautiful.notify.redshift_off
        if self.widget then self.widget:set_image(beautiful.redshift_off) end
    else 
        os.execute(self.command..' -m randr -o '..self.options)
        self.timer:start()
        info = 'Start'
        icon = beautiful.notify.redshift_on
        if self.widget then self.widget:set_image(beautiful.redshift_on) end
    end

    if self.notify == true then 
        naughty.destroy(self.noti)
        self.noti = naughty.notify ({
            title       = "Redshift",
            text        = info,
            timeout     = 2,
            icon        = icon,
            screen      = mouse.screen
        })
    end

    self.state = 1 - self.state
end

local function widget_redshift()
    if not redshift.widget then
        redshift.widget = wibox.widget.imagebox(beautiful.redshift_on)
        redshift.widget:buttons(awful.util.table.join(awful.button({}, 1, 
            function() if redshift then redshift:toggle() end end
        )))
    end
    return redshift.widget 
end

-- }}}

redshift:init({ options = '-l -16.3988:-71.5369', notify = true })
-- }}}

-- Wibox {{{
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width = 250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({  prompt = markup("Exec: ", 
                                            beautiful.fg_urgent, nil, 
                                            beautiful.bg_urgent) })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 24 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(space())
    left_layout:add(mylayoutbox[s])
    left_layout:add(space())
    left_layout:add(mypromptbox[s])
    left_layout:add(space(2))
    left_layout:add(widget_mpd())
    left_layout:add(widget_volume())
    left_layout:add(space())

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(widget_temperature())
    right_layout:add(space())
    right_layout:add(widget_net("wlp3s0"))
    right_layout:add(space())
    right_layout:add(widget_mem())
    right_layout:add(space())
    right_layout:add(widget_cpu())
    right_layout:add(space(2))
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    -- right_layout:add(widget_redshift())
    right_layout:add(space(2))
    right_layout:add(widget_calendar())
    right_layout:add(space())
    right_layout:add(widget_clock())
    right_layout:add(space(2))
    right_layout:add(widget_mail())
    right_layout:add(widget_pacman())
    right_layout:add(space(2))
    right_layout:add(widget_shutdown())

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- -- Mouse bindings {{{
-- root.buttons(awful.util.table.join(
--     awful.button({ }, 3, function () mymainmenu:toggle() end),
--     awful.button({ }, 4, awful.tag.viewnext),
--     awful.button({ }, 5, awful.tag.viewprev)
-- ))
-- -- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Tag browsing
    key({ modkey }, "Left",   function() lain.util.tag_view_nonempty(-1) end --[[awful.tag.viewprev]]       ),
    key({ modkey }, "Right",  function() lain.util.tag_view_nonempty( 1) end --[[awful.tag.viewnext]]       ),
    key({ modkey }, "Escape", awful.tag.history.restore),
    key({ modkey }, "w",      revelation),

    -- Default client focus
    key({ altkey }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    key({ altkey }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- By direction client focus
    key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show Menu
    -- key({ modkey }, "p",
    --     function ()
    --         mymainmenu:show({ keygrabber = true })
    --     end),

    -- Show Shutdown Menu
    key({ altkey }, "Escape", function ()
            shutdownmenu:show({ keygrabber = true })
        end),

    -- Show/Hide Wibox
    key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),

    -- On the fly useless gaps change
    -- key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end),
    -- key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end),

    -- Layout manipulation
    key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    key({ modkey,           }, "u", awful.client.urgent.jumpto),
    key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end),
    key({ altkey, }, "Tab",
        function()
            awful.menu.clients()
            awful.menu.menu_keys.down = {"Down", "Tab"}
        end),
    key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
    key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    key({ altkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    key({ altkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    key({ modkey, "Control" }, "n",      awful.client.restore),

    -- Prompt
    key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
    key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Copy to clipboard
    -- key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

    -- Standard program
    key({ modkey,           }, "Return", function () exec(terminal_tmux) end),
    key({ modkey, "Control" }, "r",      awesome.restart),
    -- key({ modkey, "Shift"   }, "q",      awesome.quit),

    -- User programs
    key({ modkey            }, "e",         function () exec("thunar") end),
    key({ altkey, "Control" }, "Delete",    function () exec("lxtask") end),

    -- User scripts
    key({        }, "Print", function () os.execute(bin .. "/screenshot -v &") end),
    key({ modkey }, "Print", function () os.execute("sleep 0.5 && " .. bin .. "/screenshot -m select -v &") end),
    key({ modkey, "Control" }, "Print", function () os.execute(bin .. "/screenshot -m focused -v &") end),

    -- Widgets popups
    key({ altkey }, "c", function () lain.widgets.calendar:show(5) end),
    key({ altkey }, "w", 
        function () 
            yawn_notification_preset = { font = 'monospace 9', screen = mouse.screen }
            weather.show(7) 
        end),
    key({ altkey }, "g", function () notify_mail(7) end),

    key({ modkey }, "F12", function() redshift:toggle() end),
    -- key({ modkey }, "F11", function() dpms:toggle() end),

    -- ALSA volume control
    key({ altkey }, "Up",   function() volume.up() end),
    key({ altkey }, "Down", function() volume.down() end),
    key({ altkey }, "m",    function() volume.toggle() end),

    -- MPD control
    key({ altkey, "Control" }, "Up",    function() mpd_cmd("toggle")end),
    key({ altkey, "Control" }, "Down",  function() mpd_cmd("stop")  end),
    key({ altkey, "Control" }, "Left",  function() mpd_cmd("prev")  end),
    key({ altkey, "Control" }, "Right", function() mpd_cmd("next")  end)

    -- key({ modkey }, "space", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    key({ modkey,           }, "q",      function (c) c:kill()                         end),
    key({ modkey,           }, "s",      awful.client.floating.toggle                     ),
    key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    key({ modkey,           }, "y",      function (c) c.sticky = not c.sticky          end),
    key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    -- { rule = { class = "URxvt" },
    --       properties = { opacity = 0.99 } },

    { rule = { role = "pop-up" },
        properties = { floating = true } },

    { rule = { class = "URxvt", name = "Music" }, properties = { floating = true } },
    { rule = { class = "URxvt", name = "alsamixer" }, properties = { floating = true } },

    { rule = { class = "Thunar", name = "Progreso de operación de archivo" },
        properties = { floating = true } },

    { rule_any = { class = { "mplayer", "Lxtask", "Gpicview", "XCalc", "Lxappearance", "Wine", "feh", "M64py" } },
          properties = { floating = true } },

    { rule = { class = "Pidgin"  }, except = { role = "buddy_list" },
        properties = { floating = true } },

    { rule = { instance = "plugin-container" },
        properties = { floating = true } },

    { rule_any = { instance = { "Navigator", "dwb", "Google-chrome-stable" } },
          properties = { tag = tags[1][2] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
        properties = { maximized_horizontal = true, 
                        maximized_vertical = true } },

    { rule = { class = "Gimp" },
        properties = { tag = tags[1][4] } },

    { rule_any = { class = { "Eclipse", "jetbrains-idea", "jetbrains-idea-ce" } },
        properties = { tag = tags[1][5] } },

    { rule_any = { class = { "Evince", "Wps", "Wpp", "Et" } },
        properties = { tag = tags[1][7] } },

    { rule_any = { class = { "Pidgin" } },
        properties = { tag = tags[1][8] } },

    { rule_any = { class = { "JDownloader", "Spotify", "Liferea" } },
        properties = { tag = tags[1][9] } },

    { rule = { class = "Synapse" }, 
        properties = { border_width = 0 } },
}
-- }}}

-- Signals {{{
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.closebutton(c))
        left_layout:add(awful.titlebar.widget.maximizedbutton(c))
        left_layout:add(awful.titlebar.widget.ontopbutton(c))
        left_layout:add(awful.titlebar.widget.stickybutton(c))
        left_layout:add(awful.titlebar.widget.floatingbutton(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(space(2))
        right_layout:add(awful.titlebar.widget.iconwidget(c))
        right_layout:buttons(buttons)

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("right")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

-- client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
-- client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
