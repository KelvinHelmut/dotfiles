-------------------------
-- Kland awesome theme --
-------------------------

theme = {}

local kland         = os.getenv("HOME") .. "/.config/awesome/themes/kland"

theme.wallpaper     = kland .. "/background.jpg"

theme.font          = "sans 8"

-- Colors common {{{
theme.bg_normal     = "#000000"
-- theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#5a1f1e"
-- theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#00bbee"
theme.fg_urgent     = "#cc9393"
theme.fg_minimize   = "#555555"

theme.border_width  = 1
theme.border_normal = "#252525"
theme.border_focus  = theme.border_normal
theme.border_marked = "#91231c"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
-- TagList {{{
theme.taglist_fg_focus  = "#ffffff"
theme.taglist_bg_focus  = "png:" .. kland .. "/taglist/bg_focus.png"

-- Display the taglist squares
-- theme.taglist_squares_sel   = kland .. "/taglist/square_sel.png"
-- theme.taglist_squares_unsel = kland .. "/taglist/square_unsel.png"
-- }}}
-- Tasklist {{{
theme.tasklist_fg_normal    = "#888888"
theme.tasklist_fg_focus     = "#ffffff"
-- }}}
-- Titlebar{{{
theme.titlebar_bg_normal    = theme.border_normal
theme.titlebar_bg_focus     = theme.border_normal
theme.titlebar_fg_focus     = "#ffffff"
theme.titlebar_fg_normal    = "#888888"
-- }}}

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- Menu {{{
theme.menu_submenu_icon = kland .. "/submenu.png"

theme.menu_height       = 20
theme.menu_width        = 400
-- }}}

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"
-- Icons Images {{{
theme.pacman                = kland .. "/pacman.png"
theme.dpms_on               = kland .. "/dpms_on.png"
theme.dpms_off              = kland .. "/dpms_off.png"
theme.redshift_on           = kland .. "/redshift_on.png"
theme.redshift_off          = kland .. "/redshift_off.png"
theme.shutdown              = kland .. "/power_off.png"
theme.reboot                = kland .. "/restart.png"
theme.suspend               = kland .. "/suspend.png"
theme.lock                  = kland .. "/lock.png"
theme.logout                = kland .. "/logout.png"
theme.switch                = kland .. "/switch.png"

theme.notify                = {}
theme.notify.redshift_on    = kland .. "/notify/redshift_on.png"
theme.notify.redshift_off   = kland .. "/notify/redshift_off.png"
theme.notify.dpms_on        = kland .. "/notify/dpms_on.png"
theme.notify.dpms_off       = kland .. "/notify/dpms_off.png"
theme.notify.cover          = kland .. "/notify/cover.png"
theme.notify.mail           = kland .. "/notify/mail.png"
theme.notify.pacman         = kland .. "/notify/pacman.png"
-- }}}


-- You can use your own layout icons like this:
-- Layouts {{{
theme.layout_fairh      = kland .. "/layouts/fairh.png"
theme.layout_fairv      = kland .. "/layouts/fairv.png"
theme.layout_floating   = kland .. "/layouts/floating.png"
theme.layout_magnifier  = kland .. "/layouts/magnifier.png"
theme.layout_max        = kland .. "/layouts/max.png"
theme.layout_fullscreen = kland .. "/layouts/fullscreen.png"
theme.layout_tilebottom = kland .. "/layouts/tilebottom.png"
theme.layout_tileleft   = kland .. "/layouts/tileleft.png"
theme.layout_tile       = kland .. "/layouts/tile.png"
theme.layout_tiletop    = kland .. "/layouts/tiletop.png"
theme.layout_spiral     = kland .. "/layouts/spiral.png"
theme.layout_dwindle    = kland .. "/layouts/dwindle.png"
-- }}}


-- Titlebar Icons {{{
theme.titlebar_close_button_focus  = kland .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = kland .. "/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = kland .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = kland .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = kland .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = kland .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = kland .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = kland .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = kland .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = kland .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = kland .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = kland .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = kland .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = kland .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = kland .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = kland .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = kland .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = kland .. "/titlebar/maximized_normal_inactive.png"
-- }}}


theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
