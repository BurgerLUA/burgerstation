/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	var/size = 1 //Size in.. uh...
	var/weight = 1 //Weight in kg

	var/obj/inventory/inventory //Inherint Inventory

	var/held_icon_right
	var/held_icon_left
	var/held_icon_state

/obj/item/New(var/desired_loc)
	src.loc = desired_loc
	if(inventory)
		inventory = new inventory(src)
	. = ..()


/obj/item/radio
	name = "radio"
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "radio"

	var/sound_to_play = 'sounds/music/clown.ogg'

/obj/item/radio/attack_self(var/atom/caller)
	//play_sound(sound_to_play,all_mobs,vector(caller.x,caller.y,caller.z))