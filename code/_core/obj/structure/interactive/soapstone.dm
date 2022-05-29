obj/structure/interactive/soapstone_message
	name = "soapstone message"
	desc = "A message left by a traveler."
	icon = 'icons/obj/structure/soapstone.dmi'
	icon_state = "message"
	anchored = TRUE

	var/owner
	var/ckey
	var/soapstone_text
	var/date
	var/time

	alpha = 180

	layer = LAYER_FLOOR_DECAL

/obj/structure/interactive/soapstone_message/New(var/desired_loc)
	. = ..()

/obj/structure/interactive/soapstone_message/Finalize()
	. = ..()
	update_sprite()

obj/structure/interactive/soapstone_message/update_icon()

	. = ..()

	if(icon_state == "death")
		name = "cursed message"
		alpha = 255
		desc = "From byond the grave."
		desc_extended = "Here lies the recorded last words of a fallen soul, slain by one of their own.<br>It whispers: \"[soapstone_text]...\""
		color = "#FFFFFF"
	else
		desc_extended = "It reads: \"[soapstone_text]\"<br>Signed by [owner]."