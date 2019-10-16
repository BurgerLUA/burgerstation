/obj/hud/button/health/body
	name = "limb health"
	desc = "Health for your limbs."
	id = "body"

	icon = 'icons/obj/health/base.dmi'
	icon_state = "body_full"

	screen_loc = "RIGHT,BOTTOM+2.2"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/body/update_icon() //Wait, isn't this a clone of something? TODO HEALTH

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(!is_advanced(owner))
		return FALSE

	var/mob/living/advanced/A = owner

	var/icon/I = new/icon(icon,icon_state)

	for(var/obj/item/organ/O in A.organs)

		if(!O.health)
			continue

		if(!O.hud_id)
			continue

		if(!O.health.health_max)
			continue

		var/icon/IO = new/icon(icon,O.hud_id)
		var/health_mod = O.health.health_current / O.health.health_max
		var/color_mod = "#FFFFFF"
		if(health_mod <= 0)
			color_mod = "#666666"
		else
			color_mod = rgb(93 + (1-health_mod)*(255-93),150 * health_mod,160 * health_mod)

		IO.Blend(color_mod,ICON_MULTIPLY)
		I.Blend(IO,ICON_OVERLAY)

	icon = I


/obj/hud/button/health/body/get_examine_text(var/mob/examiner)

	. = ..()

	var/returning = ""

	if(is_advanced(examiner))

		var/mob/living/advanced/A = examiner

		for(var/obj/item/organ/O in A.organs)

			if(!O.health)
				continue

			if(!O.hud_id)
				continue

			var/health_percent = O.health.health_current / O.health.health_max

			var/is_injured = health_percent < 1 || length(O.health.wounds)

			var/organ_information = span("","Your [O.name] is [is_injured ? "injured" : "healthy"]")

			var/wound_information = list()

			for(var/wound/W in O.health.wounds)
				wound_information += W.get_simple_examine_text()

			returning += div(is_injured ? "warning" : "notice","[organ_information]. It has [english_list(wound_information,nothing_text = "no visible wounds")].")


	return ..() + returning