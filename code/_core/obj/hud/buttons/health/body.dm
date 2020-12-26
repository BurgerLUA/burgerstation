/obj/hud/button/health/body
	name = "limb health"
	desc = "Health for your limbs."
	id = "body"

	icon = 'icons/hud/hud.dmi'
	icon_state = "invisible"

	screen_loc = "RIGHT,CENTER-2"

	user_colors = FALSE

	var/list/labeled_overlays = list()

/obj/hud/button/health/body/Destroy()
	labeled_overlays.Cut()
	return ..()

/obj/hud/button/health/body/update_owner(var/mob/desired_owner)

	. = ..()

	labeled_overlays.Cut()

	if(.)
		if(is_advanced(owner)) //Initial Creation.
			var/mob/living/advanced/A = owner
			for(var/o_id in A.labeled_organs)
				var/obj/item/organ/O = A.labeled_organs[o_id]
				if(!O)
					continue
				if(!O.health)
					continue
				if(!O.hud_id)
					continue
				if(!O.health.health_max)
					continue
				var/image/I = new/image(icon,O.hud_id)
				I.color = "#FF0000"
				labeled_overlays[o_id] = I
				add_overlay(I)

		update_sprite()

	return .

/obj/hud/button/health/body/update_overlays()

	. = ..()

	if(!is_advanced(owner))
		return .

	var/mob/living/advanced/A = owner

	for(var/o_id in labeled_overlays)

		var/image/I = labeled_overlays[o_id]
		var/obj/item/organ/O = A.labeled_organs[o_id]

		if(!O)
			labeled_overlays -= o_id
			continue

		if(!O.health)
			labeled_overlays -= o_id
			continue

		if(!O.hud_id)
			labeled_overlays -= o_id
			continue

		if(!O.health.health_max)
			labeled_overlays -= o_id
			continue

		var/health_mod = (O.health.health_current - O.health.get_loss(PAIN)) / O.health.health_max

		var/good_color = "#00FF00"
		var/bad_color = "#FF0000"
		var/color_mod = "#000000" //Final color

		if(owner && owner.client)
			var/color_scheme = owner.client.settings.loaded_data["hud_colors"]
			good_color = color_scheme[3]
			bad_color = color_scheme[6]

		if(health_mod <= 0)
			color_mod = "#303030"
		else if(health_mod >= 1)
			color_mod = good_color
		else
			color_mod = blend_colors(bad_color,good_color,health_mod*0.9)

		I.color = color_mod
		labeled_overlays[o_id] = I
		add_overlay(I)

	return .

/obj/hud/button/health/body/get_examine_list(var/mob/examiner)
	return examiner.get_examine_list(examiner)