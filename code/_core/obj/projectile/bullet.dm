/obj/projectile/bullet/
	name = "bullet"

/obj/projectile/bullet/on_hit(var/atom/hit_atom)

	if(weapon && is_ranged_gun(weapon))
		var/obj/item/weapon/ranged/G = weapon
		if(G.ranged_damage_type)
			var/damagetype/DT = G.ranged_damage_type
			var/list/params = list()
			params["icon-x"] = shoot_x
			params["icon-y"] = shoot_y

			var/atom/object_to_damage = hit_atom.get_object_to_damage(owner,hit_atom,params)
			var/can_attack = DT.can_attack(owner,hit_atom,weapon,object_to_damage)

			if(!can_attack)
				return FALSE

			switch(DT.handle_dodge(owner,hit_atom,weapon,object_to_damage))
				if(DODGE_MISS)
					DT.perform_miss(owner,hit_atom,weapon,object_to_damage)
					return FALSE
				if(DODGE_BLOCK)
					hit_atom.perform_block(owner,weapon,object_to_damage,DT)
					return FALSE
				if(DODGE_PARRY)
					hit_atom.perform_parry(owner,weapon,object_to_damage,DT)
					return FALSE
				if(DODGE_DODGE)
					hit_atom.perform_dodge(owner,weapon,object_to_damage,DT)
					return FALSE

			DT.do_damage(owner,hit_atom,weapon,object_to_damage)

	..()

/obj/projectile/bullet/revolver
	name = "revolver bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_small"

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