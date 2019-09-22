/obj/hud/button/health/body
	name = "limb health"
	desc = "Health for your limbs."
	id = "body"

	icon = 'icons/obj/health/base.dmi'
	icon_state = "body_full"

	screen_loc = "RIGHT,BOTTOM+2.2"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/body/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)

	var/mob/living/advanced/A = owner

	for(var/obj/item/organ/O in A.organs)

		if(!O.hud_id)
			continue

		var/icon/IO = new/icon(icon,O.hud_id)

		var/health_mod = O.health_current / O.health_max
		var/color_mod = rgb(93 + (1-health_mod)*(255-93),150 * health_mod,160 * health_mod)

		IO.Blend(color_mod,ICON_MULTIPLY)
		I.Blend(IO,ICON_OVERLAY)

	icon = I


/obj/hud/button/health/body/get_examine_text(var/mob/examiner)

	. = ..()

	var/returning = ""

	if(is_advanced(examiner))

		var/mob/living/advanced/A = examiner

		for(var/obj/item/organ/O in A.organs)

			if(!O.hud_id)
				continue

			var/health_percent = O.health_current / O.health_max

			var/is_injured = health_percent < 1 || length(O.wounds)

			var/organ_information = span("","Your [O.name] is [is_injured ? "injured" : "healthy"]")

			var/wound_information = list()

			for(var/wound/W in O.wounds)
				wound_information += W.get_simple_examine_text()

			returning += div(is_injured ? "warning" : "notice","[organ_information]. It has [english_list(wound_information,nothing_text = "no visible wounds")].")


	return ..() + returning