/menu/color/
	name = "Color Selection"
	id = "color_selection"
	file = 'html/color_selector.html'
	resources = list(
		"button_blue_extended.png" = 'html/button_blue_extended.png',
		"tile.png" = 'html/tile.png'
	)
	size = "800x800"

/menu/color/on_load(var/mob/user)
	run_function(usr,"set_reference","'\ref[src]'")

/menu/color/chargen/Topic(href,href_list)
	if(length(href_list) && href_list["color"])
		var/menu/M = all_menus["appearance_editor"]
		var/color_fix = replacetext(href_list["color"],"#","")
		var/total_message = "'[id]','[color_fix]'"
		M.run_function(usr,"send_color",total_message)
