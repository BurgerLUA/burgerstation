/obj/projectile/bullet/laser/
	name = "laser"
	icon = 'icons/obj/projectiles/laser.dmi'
	icon_state = "normal"

	impact_effect_turf = /obj/effect/temp/impact/bullet/laser

	muzzleflash_effect = /obj/effect/temp/muzzleflash/laser

	collision_bullet_flags = FLAG_COLLISION_BULLET_LIGHT

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

/obj/projectile/bullet/laser/sniper
	icon_state = "sniper"

/obj/projectile/bullet/laser/opticor
	icon_state = "sniper"

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
			return FALSE

/obj/projectile/bullet/laser/plasma_cutter
	icon_state = "cutter"
	penetrations_left = 4 //OwO
	steps_allowed = 8 // uwu
	collision_bullet_flags = FLAG_COLLISION_WALL

/* It also doesn't work that way so yeh
//So it basically accelerates and then self-obliterates to act as some funny alternative to KA.
/obj/projectile/bullet/laser/plasma_cutter/update_projectile(var/tick_rate=1)
	. = ..()

	if(.)

		var/vel_x_change = vel_x * 1.25
		var/vel_y_change = vel_y * 1.25

		if(prob(50))
			vel_x += clamp(vel_y_change * rand(-1,1),-(TILE_SIZE-1),TILE_SIZE-1)

		if(prob(50))
			vel_y += clamp(vel_x_change * rand(-1,1),-(TILE_SIZE-1),TILE_SIZE-1)
*/

//it's not laser but it burns
/obj/projectile/bullet/flamer
	name = "flames"
	icon = 'icons/obj/projectiles/spray.dmi'
	icon_state = "flamer"

/obj/projectile/bullet/flamer/update_projectile(var/tick_rate=1)
	. = ..()
	if(.)
		vel_x *= 0.95
		vel_y *= 0.95
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			return FALSE

/obj/projectile/bullet/flamer/on_enter_tile(turf/old_loc, turf/new_loc)
	. = ..()
	if(new_loc != get_turf(owner)) // this stops you setting fire to yourself, unless you walk into the flames...
		firebomb(new_loc,2,owner,weapon,iff_tag,multiplier = 0.5)
