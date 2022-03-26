/obj/effect/temp/impact/weapon_clone
	name = "weapon clone"
	duration = 2
	alpha = 100

/obj/effect/temp/impact/weapon_clone/New(var/desired_loc,var/desired_time,var/atom/victim,var/atom/attacker,var/atom/weapon)

	. = ..()

	src.appearance = weapon.appearance
	src.mouse_opacity = 0
	src.plane = PLANE_EFFECT
	src.alpha = 0

	var/list/offsets = get_directional_offsets(victim,attacker)
	animate(src, alpha = 175, pixel_x = offsets[1], pixel_y = offsets[2], time = duration*0.4, easing = QUAD_EASING | EASE_OUT)

