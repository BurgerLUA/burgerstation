/obj/item/device/keypad
	name = "keypad"
	desc = "An access keypad. Only works if you know the code."
	icon_state = "keypad_red"
	interactable = TRUE

	var/code = 1337

/obj/item/device/keypad/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	var/entered_code = input("Please enter the correct keycode.","Keycode") as num

	INTERACT_CHECK

	if(loc && code == entered_code)
		loc.trigger(caller,src,-1,-1)

	return TRUE