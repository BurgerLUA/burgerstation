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