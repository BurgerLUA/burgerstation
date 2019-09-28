/obj/projectile/bullet/
	name = "bullet"
	impact_effect_turf = /obj/effect/temp/impact/bullet

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/bullet/on_hit(var/atom/hit_atom)

	if(hit_atom != target_atom && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(L.status & FLAG_STATUS_DEAD || L.status & FLAG_STATUS_STUN)
			return FALSE

	if(damage_type && all_damage_types[damage_type])
		var/damagetype/DT = all_damage_types[damage_type]

		var/list/params = list()
		params[PARAM_ICON_X] = shoot_x
		params[PARAM_ICON_Y] = shoot_y

		var/atom/object_to_damage = hit_atom.get_object_to_damage(owner,hit_atom,params)
		if(hit_atom.perform_block(owner,weapon,object_to_damage,DT)) return TRUE
		if(hit_atom.perform_dodge(owner,weapon,object_to_damage,DT)) return FALSE
		if(DT.perform_miss(owner,weapon,object_to_damage)) return FALSE

		DT.do_damage(owner,hit_atom,weapon,object_to_damage,blamed)
	else
		LOG_ERROR("Warning: [damage_type] is an invalid damagetype!.")

	return ..()

/obj/projectile/bullet/revolver
	name = "revolver bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_small"

/obj/projectile/bullet/sniper
	name = "sniper bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_massive"

/obj/projectile/bullet/revolver_44
	name = "revolver bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_large"

/obj/projectile/bullet/rifle
	name = "rifle bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_large"

/obj/projectile/bullet/smg
	name = "smg bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_small"

/obj/projectile/bullet/pistol
	name = "pistol bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_small"

/obj/projectile/bullet/shotgun_pellet
	name = "shotgun pellet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "pellet"

/obj/projectile/bullet/shotgun_slug
	name = "shotgun slug"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_large"

/obj/projectile/bullet/bolt
	name = "crossbow bolt"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "bolt"