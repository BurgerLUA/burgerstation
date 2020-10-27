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

	var/offset_x = get_offset_x(victim,attacker)
	var/offset_y = get_offset_y(victim,attacker)

	animate(src, alpha = 175, pixel_x = offset_x, pixel_y = offset_y, time = duration*0.4, easing = QUAD_EASING | EASE_OUT)

	return .