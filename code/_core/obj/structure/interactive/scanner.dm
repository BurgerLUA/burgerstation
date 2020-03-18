/obj/structure/interactive/scanner
	name = "body scanner"
	desc = "YOU. SHALL NOT. PASS."
	desc_extended = "A very invasive full body scanner that magically blocks movement based on the conditions coded inside."
	icon = 'icons/obj/structure/scanner.dmi'
	icon_state = "pad"

/obj/structure/interactive/scanner/iff
	name = "\improper IFF body scanner"
	desc = "YOU. SHALL NOT. PASS. Unless the conditions are met."
	desc_extended = "A very invasive full body scanner that magically blocks movement based on the conditions coded inside. This one is programmed to prevent those without IFF implants from accessing the area."

/obj/structure/interactive/scanner/iff/Cross/(var/atom/movable/M)

	if(is_advanced(M))
		var/mob/living/advanced/A = M
		if(!A.iff_tag)
			A.to_chat("The barrier prevents you from moving!")
			A.to_chat("<font size='2'>[src.name] beeps, \"IFF implant not detected. Please move to the front desk to recieve your IFF implant.\"</font>")
			return FALSE

	return ..()


/obj/structure/interactive/scanner/iff_reverse
	name = "\improper anti-IFF body scanner"
	desc = "YOU. SHALL NOT. PASS. Unless the conditions are met."
	desc_extended = "A very invasive full body scanner that magically blocks movement based on the conditions coded inside. This one is programmed to prevent those WITH IFF implants from accessing the area."

/obj/structure/interactive/scanner/iff_reverse/Cross/(var/atom/movable/M)

	if(is_advanced(M))
		var/mob/living/advanced/A = M
		if(A.iff_tag)
			A.to_chat("The barrier prevents you from moving!")
			A.to_chat("<font size='2'>[src.name] beeps, \"IFF implant detected. Your employment is not over.\"</font>")
			return FALSE

	return ..()

/obj/structure/interactive/scanner/living
	name = "door safety scanner"
	desc = "Don't block the doors!"
	desc_extended = "A general proximity scanner that detects whether or not a person is present in the tile."
	icon_state = "door"

	plane = PLANE_WALL_ATTACHMENTS

/obj/structure/interactive/scanner/living/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	for(var/mob/living/L in loc.contents)
		source.trigger(L,src,signal_freq,signal_code)
		flick("door_bad",src)
		return FALSE

	flick("door_good",src)

	return TRUE
