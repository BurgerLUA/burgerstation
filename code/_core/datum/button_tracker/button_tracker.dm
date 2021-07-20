//Credit to Kaiochao for the button tracker and Anymacro framework
/button_tracker/
	var/list/pressed_list = list()
	var/client/owner

/button_tracker/Destroy()
	owner = null
	. = ..()

/button_tracker/New(var/client/spawning_client)
	owner = spawning_client

/button_tracker/proc/get_pressed()
	return pressed_list

/button_tracker/proc/set_pressed(var/button)
	if(!pressed_list[button])
		pressed_list[button] = TRUE
		on_pressed(button)
		return TRUE

/button_tracker/proc/set_released(var/button)
	if(pressed_list[button])
		pressed_list -= button
		on_released(button)
		return TRUE

/button_tracker/proc/on_pressed(button)
	return owner.macros.on_pressed(button)

/button_tracker/proc/on_released(button)
	return owner.macros.on_released(button)
