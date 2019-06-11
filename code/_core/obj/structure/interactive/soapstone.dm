obj/structure/interactive/soapstone_message
	name = "soapstone message"
	desc = "A message left by a traveler."
	icon = 'icons/obj/structure/soapstone.dmi'
	icon_state = "message"
	anchored = 1

	var/owner
	var/ckey
	var/soapstone_text
	var/date
	var/time

	alpha = 180

obj/structure/interactive/soapstone_message/New(var/desired_loc,var/desired_dir,var/desired_color,desired_owner,desired_ckey,desired_text,desired_date,desired_time)
	dir = desired_dir
	color = desired_color
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