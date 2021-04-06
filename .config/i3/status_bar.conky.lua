-- ~/.config/i3/status_bar.conky.lua

local net_interface = 'wlp9s0'
local cpu_id = 'cpu0'
local battery_id = 'BAT1'
local temperature_device = '3' 	-- See /sys/class/hwmon/
local temperature_sensor = '1'
local mixer_id = 'Master,0' 	-- See amixer
local time_format = '%I:%M %P' 	-- See strftime
local date_format = '%A, %d de %B'

local temperature = string.format('${hwmon %s temp %s}', temperature_device, temperature_sensor)
local net_down_float = string.format('${downspeedf %s}', net_interface)
local net_down = string.format('${downspeed %s}', net_interface)
local net_up_float = string.format('${upspeedf %s}', net_interface)
local net_up = string.format('${upspeed %s}', net_interface)
local memory_percent = '${memperc}'
local memory = '${memeasyfree}'
local cpu = string.format('${cpu %s}', cpu_id)
local battery = string.format('${battery_percent %s}', battery_id)
local volume = string.format("${exec amixer sget %s | egrep -m 1 -o '([0-9]+%%)'}", mixer_id)
local date = string.format(' ${time %s}', date_format)
local time = string.format(' ${time %s}  ', time_format)

local GREEN = [[\#aaf096]]
local YELLOW = [[\#f0dc64]]
local ORANGE = [[\#ff9933]]
local RED = [[\#ff3333]]

local temperature_colors = {
	{55, RED},
	{50, ORANGE},
	{45, YELLOW},
	{0, GREEN},
}
local net_down_colors = {
	{1000, RED},
	{700, [[\#68b1e8]]},
	{300, [[\#db70b8]]},
	{100, [[\#9470db]]},
	{0, GREEN},
}
local net_up_colors = {
	{35, RED},
	{15, [[\#9470db]]},
	{0, GREEN},
}
local memory_colors = {
	{85, RED},
	{60, ORANGE},
	{30, YELLOW},
	{0, GREEN},
}
local cpu_colors = {
	{70, RED},
	{50, ORANGE},
	{25, YELLOW},
	{0, GREEN},
}
local battery_colors = {
	{50, GREEN},
	{25, YELLOW},
	{10, ORANGE},
	{0, RED},
}


local function widget(values)
	local widget = '{'

	values.separator = values.separator or false

	if values.type == 'icon' then
		values.full_text = string.format("<span font='10'>%s</span>", values.full_text)
		values.markup = 'pango'
	elseif values.type == 'separator' then
		-- Powerline symbols: ⮂ ⮃ ⮀ ⮁ ⭤
		values.full_text = "<span weight='heavy' font='17'> ⮂</span>"
		values.markup = 'pango'
		values.separator_block_width = 0
		values.border_top = 0
		values.border_bottom = 0
		values.border_left = 0
		values.border_right = 6
		values.border = values.color
	else
		values.full_text = string.format("<span font='8.5'>%s</span>", values.full_text)
		values.markup = 'pango'
	end

	for k, v in pairs(values) do
		if type(v) == 'string' then
			v = string.format('"%s"', v)
		end
		widget = widget .. string.format([["%s": %s,]], k, v)
	end

	widget = widget:gsub(',$', '') .. '},'

	return widget
end


local function get_color(expr, values)
	local color = ''

	for i=1, #values do
		color = color .. string.format(
				"${if_match %s >= %s}%s${else}",
				expr,
				values[i][1],
				values[i][2]
			)
	end

	for i=1, #values do
		color = color .. "${endif}"
	end

	return color
end


conky.config = {
	out_to_x = false ,
	out_to_console = true,
	short_units = true,
	update_interval = 1.0
}

conky.text = '['
.. widget{
		full_text=temperature,
		color=get_color(temperature, temperature_colors),
		background=[[\#191a06cc]],
		min_width=30,
		align='right',
		separator_block_width=0
	}
.. widget{
		full_text=' 糖 ',
		type='icon',
		color=[[\#ffff00]],
		background=[[\#191a06cc]],
		min_width=20,
		separator_block_width=1
	}
.. widget{
		full_text=net_down,
		color=get_color(net_down_float, net_down_colors),
		background=[[\#061a07cc]],
		min_width=60,
		align='right',
		separator_block_width=0
	}
.. widget{
		full_text='   ',
		type='icon',
		color=[[\#06b800]],
		background=[[\#061a07cc]],
		min_width=20,
		separator_block_width=1
	}
.. widget{
		full_text=net_up,
		color=get_color(net_up_float, net_up_colors),
		background=[[\#06081acc]],
		min_width=60,
		align='right',
		separator_block_width=0
	}
.. widget{
		full_text='   ',
		type='icon',
		color=[[\#53b1ff]],
		background=[[\#06081acc]],
		min_width=20,
		separator_block_width=1
	}
.. widget{
		full_text=memory,
		color=get_color(memory_percent, memory_colors),
		background=[[\#12061acc]],
		min_width=60,
		align='right',
		separator_block_width=0
	}
.. widget{
		full_text=' 難  ',
		type='icon',
		color=[[\#ba52ff]],
		background=[[\#12061acc]],
		min_width=20,
		separator_block_width=1
	}
.. widget{
		full_text=cpu .. '%',
		color=get_color(cpu, cpu_colors),
		background=[[\#1a0610cc]],
		min_width=40,
		align='right',
		separator_block_width=0
	}
.. widget{
		full_text='   ',
		type='icon',
		color=[[\#ff73bd]],
		background=[[\#1a0610cc]],
		min_width=20,
		separator_block_width=1
	}
.. widget{
		full_text=battery .. '%',
		color=get_color(battery, battery_colors),
		background=[[\#061a11cc]],
		min_width=40,
		align='right',
		separator_block_width=0
	}
.. widget{
		full_text='   ',
		type='icon',
		color=[[\#54ffaa]],
		background=[[\#061a11cc]],
		min_width=20,
		separator_block_width=1
	}
.. widget{
		full_text=volume,
		color=[[\#00cccc]],
		background=[[\#06181acc]],
		min_width=40,
		align='right',
		separator_block_width=0
	}
.. widget{
		full_text='  ',
		type='icon',
		color=[[\#00cccc]],
		background=[[\#06181acc]],
		min_width=20,
		separator_block_width=0
	}
.. widget{type='separator', color=[[\#ad94ffcc]], background=[[\#06181acc]]}
.. widget{
		full_text=' ',
		type='icon',
		background=[[\#ad94ffcc]],
		separator_block_width=0
	}
.. widget{
		full_text=date,
		background=[[\#ad94ffcc]],
		separator_block_width=0
	}
.. widget{type='separator', color=[[\#94ffd1cc]], background=[[\#ad94ffcc]]}
.. widget{
		full_text=' ',
		type='icon',
		background=[[\#94ffd1cc]],
		separator_block_width=0
	}
.. widget{
		full_text=time,
		background=[[\#94ffd1cc]],
		separator_block_width=0
	}
.. widget{full_text=''}:gsub(',$', '') -- :gsub(',$', '') last widget remove end ","
.. '],'
