/obj/hud/button/stat/body
	name = "limb health"
	desc = "Health for your limbs."
	id = "body"

	icon = 'icons/hud/hud.dmi'
	icon_state = "invisible"

	screen_loc = "RIGHT,BOTTOM:12+5"

	user_colors = FALSE

	var/list/labeled_overlays = list()

	layer = 0

/obj/hud/button/stat/body/Destroy()
	labeled_overlays?.Cut()
	. = ..()

/obj/hud/button/stat/body/update_owner(var/mob/desired_owner)

	. = ..()

	labeled_overlays.Cut()
	vis_contents.Cut()

	//Generate the organs.
	if(. && is_advanced(owner))
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
			var/obj/hud/I = new
			I.appearance = src.appearance
			I.icon = icon
			I.icon_state = O.hud_id
			I.color = "#000000"
			labeled_overlays[o_id] = I
			add_vis_content(I)
		update()

/obj/hud/button/stat/body/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_living(caller))
		var/mob/living/L = caller
		for(var/k in L.get_damage_description(caller,FALSE))
			caller.to_chat(k)

	return ..()

/obj/hud/button/stat/body/update()

	if(!is_advanced(owner))
		return FALSE

	var/mob/living/advanced/A = owner

	var/good_color = "#00FF00"

	var/bad_color = "#FF0000"

	if(owner && owner.client)
		var/color_scheme = owner.client.settings.loaded_data["hud_colors"]
		good_color = color_scheme[2]

		bad_color = color_scheme[6]

	for(var/o_id in labeled_overlays)

		var/obj/hud/I = labeled_overlays[o_id]
		var/obj/item/organ/O = A.labeled_organs[o_id]

		if(!O || !O.health || !O.hud_id || O.health.health_max <= 0)
			I.color = "#000000"
			continue

		var/health_mod = CEILING( (O.health.health_current - O.health.get_loss(PAIN)) / O.health.health_max, 0.01)

		var/color_mod = "#000000" //Final color
		if(health_mod <= 0)
			color_mod = "#303030"
		else if(health_mod >= 1)
			color_mod = good_color
		else
			color_mod = blend_colors(bad_color,good_color,health_mod*0.9)

		if(I.color == "#000000")
			I.color = color_mod
		else
			animate(I,color=color_mod,time=TICKS_TO_DECISECONDS(LIFE_TICK))

		labeled_overlays[o_id] = I

	. = ..()


/obj/hud/button/stat/body/get_examine_list(var/mob/examiner)
	return examiner.get_examine_list(examiner)