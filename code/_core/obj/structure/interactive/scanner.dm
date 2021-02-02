/obj/structure/interactive/scanner
	name = "body scanner"
	desc = "YOU. SHALL NOT. PASS."
	desc_extended = "A very invasive full body scanner that magically blocks movement based on the conditions coded inside."
	icon = 'icons/obj/structure/scanner.dmi'
	icon_state = "pad"

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#00FF00"

/obj/structure/interactive/scanner/iff
	name = "\improper IFF body scanner"
	desc = "YOU. SHALL NOT. PASS. Unless the conditions are met."
	desc_extended = "A very invasive full body scanner that magically blocks movement based on the conditions coded inside. This one is programmed to prevent those without IFF implants from accessing the area."

/obj/structure/interactive/scanner/iff/Cross/(var/atom/movable/M)

	if(is_advanced(M))
		var/mob/living/advanced/A = M
		if(!A.iff_tag)
			A.to_chat(span("warning","The barrier prevents you from moving!"))
			src.do_say("IFF implant not detected.")
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
			A.to_chat(span("warning","The barrier prevents you from moving!"))
			src.do_say("IFF implant detected. Your employment is not over.")
			return FALSE

	return ..()

/obj/structure/interactive/scanner/living
	name = "door safety scanner"
	desc = "Don't block the doors!"
	desc_extended = "A general proximity scanner that detects whether or not a person is present in the tile."
	icon_state = "door"

	plane = PLANE_OBJ

	desired_light_power = 0

/obj/structure/interactive/scanner/living/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	for(var/mob/living/L in loc.contents)
		source.trigger(L,src,signal_freq,signal_code)
		flick("door_bad",src)
		return FALSE

	flick("door_good",src)

	return TRUE



/obj/structure/interactive/scanner/anti_dead
	name = "\improper living body scanner"
	desc = "YOU. SHALL NOT. PASS. Unless the conditions are met."
	desc_extended = "A very invasive full body scanner that magically blocks movement based on the conditions coded inside. This one is programmed to only allow living silicons and carbons."

/obj/structure/interactive/scanner/anti_dead/Cross/(var/atom/movable/M)

	if(!is_living(M))
		return FALSE
	var/mob/living/L = M
	if(L.dead)
		return FALSE

	return ..()


/obj/structure/interactive/scanner/crate_only
	name = "\improper crate scanner"
	desc = "YOU. SHALL NOT. PASS. Unless the conditions are met."
	desc_extended = "A very invasive full body scanner that magically blocks movement based on the conditions coded inside. This one is programmed to only allow secure crates."

/obj/structure/interactive/scanner/crate_only/Cross/(var/atom/movable/M)

	if(!istype(M,/obj/structure/interactive/crate/secure))
		return FALSE

	return ..()



/obj/structure/interactive/scanner/cop
	name = "cop scanner"
	desc = "Don't block the doors!"
	desc_extended = "A general proximity scanner that detects whether or not a person is a cop"
	icon_state = "door"

	plane = PLANE_OBJ

	desired_light_power = 0

/obj/structure/interactive/scanner/cop/Cross/(var/atom/movable/M)

	if(!is_living(M))
		return FALSE

	var/mob/living/L = M
	if(L.loyalty_tag != "Space Cop")
		return FALSE

	return ..()


/obj/structure/interactive/scanner/rich
	name = "rich person scanner"
	desc = "Poor people get out."
	desc_extended = "A proximity door scanner that prevents those with less than 20,000 credits from entering. Or leaving..."
	icon_state = "door"

/obj/structure/interactive/scanner/rich/Cross/(var/atom/movable/M)

	if(!is_player(M))
		return FALSE

	var/mob/living/advanced/player/P = M

	if(P.currency < 20000)
		P.to_chat(span("warning","You are too poor to cross the rich person scanner..."))
		return FALSE

	return ..()