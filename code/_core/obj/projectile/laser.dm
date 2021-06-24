/obj/projectile/bullet/laser/
	name = "laser"
	icon = 'icons/obj/projectiles/laser.dmi'
	icon_state = "normal"

	impact_effect_turf = /obj/effect/temp/impact/bullet/laser

	muzzleflash_effect = /obj/effect/temp/muzzleflash/laser

	collision_bullet_flags = FLAG_COLLISION_BULLET_LIGHT

	plane = PLANE_EFFECT_LIGHTING

/obj/projectile/bullet/laser/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"[icon_state]_outline")
	I.color = bullet_color
	underlays += I

/obj/projectile/bullet/laser/strong
	icon_state = "strong"

/obj/projectile/bullet/laser/weak
	icon_state = "weak"

/obj/projectile/bullet/laser/ion
	icon_state = "ion"


/obj/projectile/bullet/spit
	icon = 'icons/obj/projectiles/spit.dmi'
	icon_state = "spit"


/obj/projectile/bullet/laser/emitter
	name = "emitter laser"


/obj/projectile/bullet/laser/kinetic
	icon_state = "kinetic"

/obj/projectile/bullet/laser/kinetic/update_projectile(var/tick_rate=1)
	. = ..()
	if(.)
		vel_x *= 0.95
		vel_y *= 0.95
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			qdel(src)
			return FALSE