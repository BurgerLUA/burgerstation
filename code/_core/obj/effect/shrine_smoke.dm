/obj/effect/ritual_smoke
	name = "ritual smoke"
	desc = "LET ME IN, LET ME IIIIIIIN."
	desc_extended = "A completely and utterly arbitrary anomaly of nature that prevents living beings from passing it."
	icon = 'icons/obj/structure/shrine_smoke.dmi'
	icon_state = "smoke"
	plane = PLANE_AREA
	layer = 100
	alpha = 255

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	density = TRUE
	opacity = TRUE

	mouse_opacity = 2

/obj/effect/ritual_smoke/Cross(atom/movable/O,atom/oldloc)
	if(is_living(O))
		return FALSE
	return TRUE

/obj/effect/ritual_smoke/proc/remove()
	animate(src,alpha = 0)
	density = FALSE
	mouse_opacity = 0

/obj/effect/ritual_smoke/inner
	icon_state = "inner"

/obj/effect/ritual_smoke/outer
	icon_state = "outer"