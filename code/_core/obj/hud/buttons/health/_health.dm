/obj/hud/button/stat/
	name = "limb health"
	desc = "Health for your limbs."
	var/id = "body"

	icon = 'icons/hud/hud.dmi'
	icon_state = "invisible"

	screen_loc = "RIGHT,BOTTOM:12+5"

	layer = LAYER_HUD
	plane = PLANE_HUD
	flags = FLAGS_HUD_MOB

	user_colors = FALSE

	var/list/labeled_overlays = list()

/obj/hud/button/stat/Destroy()
	labeled_overlays?.Cut()
	. = ..()

/obj/hud/button/stat/update_owner(var/mob/desired_owner)

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.remove_health_element(src)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.add_health_element(src)
		L.health_icons_to_update |= src
		update_sprite()

	labeled_overlays.Cut()
	vis_contents.Cut()

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
			I.color = "#FFFFFF"
			labeled_overlays[o_id] = I
			add_vis_content(I)
		A.
		update_vis_contents()

/obj/hud/button/stat/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_living(caller))
		var/mob/living/L = caller
		for(var/k in L.get_damage_description(caller,FALSE))
			caller.to_chat(k)

	return ..()

/obj/hud/button/stat/proc/update()

	if(!is_advanced(owner))
		return

	var/mob/living/advanced/A = owner

	for(var/o_id in labeled_overlays)

		var/obj/hud/I = labeled_overlays[o_id]
		var/obj/item/organ/O = A.labeled_organs[o_id]

		if(!O || !O.health || !O.hud_id || O.health.health_max <= 0)
			I.color = "#000000"
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

		animate(I,color=color_mod,time=LIFE_TICK)
		labeled_overlays[o_id] = I

	return TRUE


/obj/hud/button/stat/get_examine_list(var/mob/examiner)
	return examiner.get_examine_list(examiner)