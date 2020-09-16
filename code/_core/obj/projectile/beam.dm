//Failed code here.

/obj/projectile/beam/
	name = "beam"
	icon = 'icons/obj/projectiles/beam.dmi'
	icon_state = "laser"

	impact_effect_turf = /obj/effect/temp/impact/bullet/laser

	muzzleflash_effect = /obj/effect/temp/muzzleflash/laser

	collision_bullet_flags = FLAG_COLLISION_BULLET_LIGHT


/obj/projectile/beam/on_enter_tile(var/turf/old_loc,var/turf/new_loc)

	. = ..()

	var/obj/effect/temp/T = new(new_loc,20)
	T.appearance = src.appearance
	T.plane = plane
	T.layer = layer - 0.1
	T.icon = icon
	T.mouse_opacity = 0
	var/new_angle = ATAN2(vel_x,vel_y) - 90
	T.transform = turn(matrix(),-new_angle)
	if(.) //Hit!
		T.icon_state = "impact_[icon_state]"
	else //Not a hit.
		T.icon_state = icon_state

	return .