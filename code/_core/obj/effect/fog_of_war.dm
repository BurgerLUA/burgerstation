var/global/list/all_fog = list()

/obj/effect/fog_of_war
	name = "fog of war"
	desc = "Muh immersion."
	desc_extended = "A completely and utterly arbitrary anomaly of nature that prevents living beings from passing it."
	icon = 'icons/obj/effects/fog.dmi'
	icon_state = "fog"
	plane = PLANE_AREA
	layer = 100
	alpha = 255

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	density = TRUE

	mouse_opacity = 2

/obj/effect/fog_of_war/Cross(var/atom/movable/O)
	if(is_living(O))
		return FALSE
	return TRUE

/obj/effect/fog_of_war/New(var/desired_loc)
	all_fog += src
	alpha = 200
	return ..()

/obj/effect/fog_of_war/proc/remove()
	animate(src,alpha = 0)
	density = FALSE
	mouse_opacity = 0