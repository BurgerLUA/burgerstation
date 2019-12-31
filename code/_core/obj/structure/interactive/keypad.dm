obj/structure/interactive/keypad
	name = "keypad"
	desc = "An access keypad. Only works if you know the code."
	icon = 'icons/obj/structure/keypad.dmi'
	icon_state = "keypad_locked"
	var/code = 1337
	plane = PLANE_WALL_ATTACHMENTS

obj/structure/interactive/keypad/clicked_on_by_object(caller,object,location,control,params)

	INTERACT_CHECK

	var/entered_code = input("Please enter the correct keycode.","Keycode") as num

	world.log << entered_code
	INTERACT_CHECK

	//if(entered_code && entered_code == code)



	return TRUE