/obj/projectile/bullet/
	name = "bullet"

/obj/projectile/bullet/on_hit(var/atom/hit_atom)


	if(is_living(owner) && is_living(hit_atom) && hit_atom != owner)
		var/mob/living/living_owner = owner
		var/mob/living/living_target = hit_atom

		if(length(living_target.factions) && length(living_owner.factions))
			for(var/id in living_owner.factions)
				if(!living_target.factions[id])
					continue
				var/faction/F = all_factions[id]
				if(!F.can_damage_team())
					return FALSE

	if(damage_type)
		var/damagetype/DT = all_damage_types[damage_type]
		var/list/params = list()
		params["icon-x"] = shoot_x
		params["icon-y"] = shoot_y

		var/atom/object_to_damage = hit_atom.get_object_to_damage(owner,hit_atom,params)
		var/can_attack = DT.can_attack(owner,hit_atom,weapon,object_to_damage)

		if(!can_attack)
			return FALSE

		if(hit_atom.perform_block(owner,weapon,object_to_damage,DT)) return TRUE
		if(hit_atom.perform_dodge(owner,weapon,object_to_damage,DT)) return FALSE

		DT.do_damage(owner,hit_atom,weapon,object_to_damage)

	..()

/obj/projectile/bullet/revolver
	name = "revolver bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_small"

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

/obj/projectile/bullet/shotgun
	name = "shotgun bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "pellet"

/obj/projectile/bullet/sniper
	name = "sniper bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_massive"

/obj/projectile/bullet/bolt
	name = "crossbow bolt"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "bolt"