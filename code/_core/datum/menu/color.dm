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

/menu/color/chargen/hair_head
	id = "hair_head"

/menu/color/chargen/hair_head/on_load(var/mob/user)
	..()
	run_function(usr,"quick_generate_hair","")



/menu/color/chargen/hair_face
	id = "hair_face"

/menu/color/chargen/hair_face/on_load(var/mob/user)
	..()
	run_function(usr,"quick_generate_hair","")



/menu/color/chargen/skin
	id = "skin"

/menu/color/chargen/skin/on_load(var/mob/user)
	..()
	run_function(usr,"quick_generate_skintones","")


/menu/color/chargen/blush
	id = "skin"

/menu/color/chargen/blush/on_load(var/mob/user)
	..()
	run_function(usr,"quick_generate_skintones","")


/menu/color/chargen/lips
	id = "lips"

/menu/color/chargen/lips/on_load(var/mob/user)
	..()
	run_function(usr,"quick_generate_skintones","")


/menu/color/chargen/eyes
	id = "eyes"

/menu/color/chargen/eyes/on_load(var/mob/user)
	..()
	run_function(usr,"quick_generate_eyes","")