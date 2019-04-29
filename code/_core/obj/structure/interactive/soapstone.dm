obj/structure/interactive/soapstone_message
	name = "soapstone message"
	desc = "It's like twitter except arguably more evil."
	icon = 'icons/obj/structure/future/furniture.dmi'
	icon_state = "bed"
	density = 0
	anchored = 1

	var/owner
	var/ckey
	var/soapstone_text
	var/date
	var/time

obj/structure/interactive/soapstone_message/New(var/desired_loc,desired_owner,desired_ckey,desired_text,desired_date,desired_time)
	owner = desired_owner
	ckey = desired_ckey
	soapstone_text = desired_text
	date = desired_date
	time = desired_time
	..()
	update_icon()

obj/structure/interactive/soapstone_message/update_icon()
	desc_extended = "It reads: \"[soapstone_text]\""
	..()