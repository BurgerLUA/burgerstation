/obj/hud/button/health/body
	name = "limb health"
	desc = "Health for your limbs."
	id = "body"

	icon = 'icons/hud/new.dmi'
	icon_state = "body_full"

	screen_loc = "RIGHT,BOTTOM+2.2"

	flags = FLAGS_HUD_MOB

	user_colors = FALSE

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

			var/list/type_count = list()

			for(var/wound/W in O.health.wounds)
				type_count[W.id] += 1

			var/list/wound_information = list()

			for(var/k in type_count)
				var/word_to_use = ""
				switch(type_count[k])
					if(1)
						word_to_use = "a"
					if(2)
						word_to_use = "a couple of"
					if(3)
						word_to_use = "a few"
					else
						word_to_use = "several"

				var/plural = type_count[k] > 1 ? "s" : ""

				wound_information += "[word_to_use] [k][plural]"

			var/list/damage_desc = list()

			if(O.health.damage[BRUTE])
				damage_desc += "bruised"

			if(O.health.damage[BURN])
				damage_desc += "burned"

			if(O.health.damage[OXY])
				damage_desc += "pale"

			if(O.health.damage[TOX])
				damage_desc += "sickly"

			if(O.health.damage[FATIGUE])
				damage_desc += "limp"

			var/is_injured = length(damage_desc) || length(wound_information)

			returning += div(is_injured ? "warning" : "notice","Your [O.name] is [english_list(damage_desc,nothing_text="healthy")] ([O.health.health_current]/[O.health.health_max]). It has [english_list(wound_information,nothing_text = "no visible wounds")].")

	return returning