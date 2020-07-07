/obj/projectile/bullet/
	name = "bullet"
	impact_effect_turf = /obj/effect/temp/impact/bullet
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	muzzleflash_effect = /obj/effect/temp/muzzleflash/
	alpha = 255

/obj/projectile/bullet/update_icon()
	. = ..()
	color = bullet_color
	return .

/obj/projectile/bullet/bolt
	name = "crossbow bolt"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "bolt"

/obj/projectile/bullet/tungsten
	name = "tungsten bolt"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "tungsten"

/obj/projectile/bullet/syringe
	name = "launched syringe"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "syringe"
	ignore_iff = TRUE
	var/reagent_to_add = /reagent/medicine/omnizine
	var/volume_to_add = 15

/obj/projectile/bullet/syringe/damage_atom(var/atom/hit_atom)

	if(is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(L.iff_tag == iff_tag)
			var/list/params = list()
			params[PARAM_ICON_X] = shoot_x
			params[PARAM_ICON_Y] = shoot_y
			var/atom/object_to_damage = hit_atom.get_object_to_damage(owner,src,params,FALSE,FALSE)
			if(ismovable(object_to_damage))
				var/atom/movable/M = object_to_damage
				if(M.reagents)
					M.reagents.add_reagent(reagent_to_add,volume_to_add)
				return TRUE

	return ..()

/obj/projectile/bullet/gyrojet
	name = "gyrojet"
	icon = 'icons/obj/projectiles/rocket.dmi'
	icon_state = "gyrojet"

/obj/projectile/bullet/gyrojet/post_on_hit(var/atom/hit_atom)
	. = ..()

	if(.)
		explode(get_turf(hit_atom),1,owner,src,iff_tag)

	return .

/obj/projectile/bullet/gyrojet/update_projectile()

	. = ..()

	if(.)

		var/vel_x_change = vel_x * 0.05
		var/vel_y_change = vel_y * 0.05

		if(prob(50))
			vel_x += clamp(vel_y_change * rand(-1,1),-(TILE_SIZE-1),TILE_SIZE-1)

		if(prob(50))
			vel_y += clamp(vel_x_change * rand(-1,1),-(TILE_SIZE-1),TILE_SIZE-1)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_hit(current_loc,TRUE)
			return FALSE

	return .