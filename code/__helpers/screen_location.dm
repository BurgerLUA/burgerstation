var/global/regex/ScreenLocRegex = regex("(\\d+):(\\d+),(\\d+):(\\d+)")

/proc/parse_screen_loc(var/screen_loc)

	if(ScreenLocRegex.Find(screen_loc))
		var/list/data = ScreenLocRegex.group

		var/list/returning = list(
			text2num(data[2]) + (text2num(data[1]) - 1) * TILE_SIZE,
			text2num(data[4]) + (text2num(data[3]) - 1) * TILE_SIZE
		)

		return returning

	return null