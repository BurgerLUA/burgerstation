/obj/effect/temp/impact/weapon_clone
	name = "weapon clone"
	duration = 2
	alpha = 175

/obj/effect/temp/impact/weapon_clone/New(var/desired_loc,var/desired_time,var/atom/victim,var/atom/attacker,var/atom/weapon)

	. = ..()

	src.appearance = weapon.appearance
	src.mouse_opacity = 0
	src.plane = PLANE_EFFECT
	src.alpha = 0

	var/list/offsets = get_directional_offsets(attacker,victim)
	animate(src, alpha = initial(alpha), pixel_x = offsets[1]*TILE_SIZE, pixel_y = offsets[2]*TILE_SIZE, time = duration*0.4, easing = QUAD_EASING | EASE_OUT)

