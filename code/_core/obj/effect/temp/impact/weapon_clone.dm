/obj/effect/temp/impact/weapon_clone
	name = "weapon clone"
	duration = 2
	alpha = 175

/obj/effect/temp/impact/weapon_clone/New(var/desired_loc,var/desired_time,var/atom/victim,var/atom/attacker,var/atom/weapon)

	. = ..()



	if(!victim)
		log_error("Warning: [src.get_debug_name()] didn't have a victim set in New()!")
		return

	if(!attacker)
		log_error("Warning: [src.get_debug_name()] didn't have a attacker set in New()!")
		return

	if(!weapon)
		log_error("Warning: [src.get_debug_name()] didn't have a weapon set in New()!")
		return

	var/list/offsets = get_directional_offsets(attacker,victim)
	src.appearance = weapon.appearance
	src.mouse_opacity = 0
	src.plane = PLANE_EFFECT
	src.alpha = 0
	animate(
		src,
		alpha = initial(alpha),
		pixel_x = offsets[1]*TILE_SIZE,
		pixel_y = offsets[2]*TILE_SIZE,
		time = duration*0.4,
		easing = QUAD_EASING | EASE_OUT
	)

