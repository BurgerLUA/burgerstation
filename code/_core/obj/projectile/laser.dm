/obj/projectile/bullet/laser/
	name = "laser"
	id = "laser"
	icon = 'icons/obj/projectiles/laser.dmi'
	icon_state = "laser"

	impact_effect_turf = /obj/effect/temp/impact/bullet/laser

	collision_bullet_flags = FLAG_COLLISION_BULLET_LIGHT

/obj/projectile/bullet/laser/update_icon()

	var/icon/I = new/icon(initial(icon),initial(icon_state))
	I.Blend(bullet_color,ICON_MULTIPLY)

	var/icon/I2 = new/icon(initial(icon),"core")
	I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()

