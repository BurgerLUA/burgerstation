obj/effect/temp/muzzleflash
	name = "muzzleflash effect"
	icon = 'icons/obj/effects/muzzleflash.dmi'
	icon_state = "muzzle_bullet"
	duration = 1
	plane = PLANE_EFFECT_LIGHTING

	desired_light_range = VIEW_RANGE*0.4
	desired_light_power = 0.75
	desired_light_color = "#FFFBBE"
	desired_light_angle = LIGHT_OMNI

obj/effect/temp/muzzleflash/update_atom_light()
	if(desired_light_power > 0)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle,offset_x=pixel_x*2,offset_y=pixel_y*2)
	return TRUE

obj/effect/temp/muzzleflash/laser
	icon_state = "muzzle_laser"