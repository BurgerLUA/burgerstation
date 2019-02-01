/menu/appearance/
	name = "Appearance Editor"
	id = "appearance_editor"
	file = 'html/new.html'
	resources = list(
		"button_blue.png" = 'html/button_blue.png',
		"button_grey.png" = 'html/button_grey.png',
		"tile.png" = 'html/tile.png'
	)
	size = "800x800"

/menu/appearance/cache_resources(var/user)
	..()
	for(var/k in hair_icons)
		var/v = hair_icons[k]
		user << browse_rsc(v,"[k].png")

/menu/appearance/open(var/user)
	..()
	user << "Window: [id]"
	user << length(hair_names)
	user << length(hair_icons)
	user << output(list2params(list("hi","hello")), "[id].browser:initialize")