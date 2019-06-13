/menu/examine/
	name = "Examine Menu"
	id = "examine"

	file = 'html/examine.html'
	resources = list(
		"tile.png" = 'html/tile.png',
	)

/menu/examine/open(var/user)
	user << output(file, "info.browser")

/menu/examine/close(var/user)


/menu/examine/on_load(var/user)
	if(!is_player(user))
		return FALSE

/menu/examine/run_function(var/user, var/function_name,var/args)
	user << output("[function_name]([args]);", "info.browser:eval")

/menu/examine/Topic(href,href_list)
	return