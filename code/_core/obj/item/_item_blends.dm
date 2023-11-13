/obj/item/proc/initialize_worn_blends(var/desired_icon_state)

	if(length(polymorphs))
		var/icon/initial_icon = initial(icon)
		var/layer_mod = 0
		for(var/polymorph_name in polymorphs)
			var/polymorph_color = polymorphs[polymorph_name]
			add_blend(
				"polymorph_[polymorph_name]",
				desired_icon = initial_icon,
				desired_icon_state = "[desired_icon_state]_[polymorph_name]",
				desired_color = polymorph_color,
				desired_blend = ICON_OVERLAY,
				desired_type = ICON_BLEND_OVERLAY,
				desired_should_save = TRUE,
				desired_layer = worn_layer + (layer_mod * 0.001)
			)
			layer_mod++

	if(enable_blood_stains)
		add_blend(
			"bloodstain",
			desired_icon = 'icons/mob/living/advanced/overlays/blood_overlay.dmi',
			desired_icon_state = blood_stain_intensity ? "[CEILING(blood_stain_intensity,1)]" : null,
			desired_color = blood_stain_color,
			desired_blend = ICON_ADD,
			desired_type = ICON_BLEND_MASK,
			desired_should_save = FALSE,
			desired_layer = worn_layer + 0.011
		)

	if(enable_damage_overlay)
		var/desired_damage_num = get_damage_icon_number()
		add_blend(
			"damage_overlay_noise",
			desired_icon = 'icons/mob/living/advanced/overlays/damage_clothing.dmi',
			desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null,
			desired_blend = ICON_MULTIPLY,
			desired_type = ICON_BLEND_MASK,
			desired_should_save = FALSE,
			desired_layer = worn_layer + 0.012
		)

	if(enable_torn_overlay)
		var/desired_damage_num = max(0,get_damage_icon_number() - 1)
		add_blend(
			"damage_overlay",
			desired_icon = 'icons/mob/living/advanced/overlays/damage_overlay.dmi',
			desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null,
			desired_blend = ICON_OVERLAY,
			desired_type = ICON_BLEND_CUT,
			desired_should_save = FALSE,
			desired_layer = worn_layer + 0.013
		)

	return TRUE

/obj/item/proc/remove_blend(var/desired_id)

	if(!additional_blends || !additional_blends[desired_id])
		return FALSE

	var/icon_blend/IB = additional_blends[desired_id]
	additional_blends -= desired_id
	qdel(IB)

	return TRUE

/obj/item/proc/add_blend(var/desired_id,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type, var/desired_should_save,var/desired_layer)

	//Existing blend.
	if(additional_blends && additional_blends[desired_id])
		var/icon_blend/IB = additional_blends[desired_id]
		if(desired_icon)
			IB.icon = desired_icon

		if(desired_icon_state)
			IB.icon_state = desired_icon_state

		if(desired_color)
			IB.color = desired_color

		if(desired_blend)
			IB.blend = desired_blend

		if(desired_type)
			IB.special_type = desired_type

		if(desired_should_save)
			IB.can_save = desired_should_save

		if(desired_layer)
			IB.layer = desired_layer

		return IB

	//New blend.
	var/icon_blend/IB = new(desired_id, desired_icon, desired_icon_state, desired_color, desired_blend, desired_type, desired_should_save, desired_layer)
	if(!additional_blends)
		additional_blends = list()
	additional_blends[desired_id] = IB

	return IB

/obj/item/proc/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/remove=FALSE,var/update=FALSE,var/worn=FALSE,var/icon_state_override)

	if(remove)
		A.remove_overlay("\ref[src]")

	if(add)
		if(worn)
			var/obj/hud/inventory/I = src.loc
			var/desired_layer = src.worn_layer
			if(I.advanced_layering && length(I.contents) > 1)
				var/key = I.contents.Find(src)
				if(key != 1)
					var/obj/item/I2 = I.contents[1]
					desired_layer = I2.worn_layer + (key)*0.01
			A.add_overlay_tracked(
				"\ref[src]",
				src,
				desired_layer = desired_layer,
				desired_icon = initial(src.icon),
				desired_icon_state = icon_state_override,
				desired_no_initial = src.no_initial_blend,
				desired_pixel_x = src.worn_pixel_x,
				desired_pixel_y = src.worn_pixel_y,
				desired_color=src.color
			)

	if(update)
		A.update_overlay_tracked(
			"\ref[src]",
			desired_color=src.color,
			desired_icon_state = icon_state_override,
		)


	return TRUE