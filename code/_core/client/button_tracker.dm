//Credit to Kaiochao for the button tracker and Anymacro framework
/datum/button_tracker/
	var/list/pressed_list
	var/client/owner

/datum/button_tracker/New(var/client/spawning_client)
	owner = spawning_client
	pressed_list = new

/datum/button_tracker/proc/get_pressed()
	return pressed_list

/datum/button_tracker/proc/set_pressed(var/button)
	if(is_released(button))
		pressed_list += button
		on_pressed(button)
		return TRUE

/datum/button_tracker/proc/set_released(var/button)
	if(is_pressed(button))
		pressed_list -= button
		on_released(button)
		return TRUE

/datum/button_tracker/proc/is_pressed(button)
	return (button in pressed_list)

/datum/button_tracker/proc/is_released(button)
	return !(button in pressed_list)

/datum/button_tracker/proc/on_pressed(button)
	return owner.macros.on_pressed(button)

/datum/button_tracker/proc/on_released(button)
	return owner.macros.on_released(button)




