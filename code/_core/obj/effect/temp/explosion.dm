/obj/effect/temp/explosion
	name = "explosion effect"
	mouse_opacity = 0
	icon = 'icons/obj/effects/explosion_large.dmi'
	icon_state = "explosion"
	duration = SECONDS_TO_DECISECONDS(3)
	layer = LAYER_EFFECT + 0.1
	pixel_x = -32
	pixel_y = -32

/obj/effect/temp/explosion/New(var/desired_location,var/desired_time,var/desired_color)
	. = ..()
	var/matrix/M = get_base_transform()
	if(desired_time > 5)
		M.Scale(desired_time/5,desired_time/5)
	animate(src,transform = M, alpha=0, easing = CUBIC_EASING | EASE_OUT, time = desired_time)

/obj/effect/temp/explosion_particle
	name = "explosion particle"
	icon = 'icons/obj/effects/explosion.dmi'
	icon_state = "explosion_particle"

/obj/effect/temp/explosion_particle/New(var/desired_location,var/desired_time,var/desired_color,var/desired_dir)

	if(desired_dir)
		dir = desired_dir

	. = ..()

	var/list/pixel_offsets = direction_to_pixel_offset(dir)

	animate(src, alpha = 0, pixel_x = pixel_offsets[1]*TILE_SIZE*desired_time*0.1, pixel_y = pixel_offsets[2]*TILE_SIZE*desired_time*0.1, easing = CUBIC_EASING | EASE_OUT, time = desired_time-1)