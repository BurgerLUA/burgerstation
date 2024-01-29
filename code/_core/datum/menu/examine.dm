/menu/examine/
	name = "Examine Menu"
	id = "examine"

	file = 'html/examine.html'
	resources = list(
		"tile.png" = 'html/tile.png',
	)

/menu/examine/open(user)
	user << output(file, "info.browser")

/menu/examine/close(user)


/menu/examine/on_load(user)
	if(!is_player(user))
		return FALSE

/menu/examine/run_function(user, function_name,args)
	user << output("[function_name]([args]);", "info.browser:eval")

/menu/examine/Topic(href,href_list)
	return