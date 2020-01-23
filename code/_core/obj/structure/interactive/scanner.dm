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