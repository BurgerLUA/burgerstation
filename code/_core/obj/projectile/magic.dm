/obj/projectile/bullet/fireball
	name = "fireball"
	icon = 'icons/obj/projectiles/fire.dmi'
	icon_state = "ball"


/obj/projectile/bullet/chaos
	name = "chaos ball"
	icon = 'icons/obj/projectiles/chaos.dmi'
	icon_state = "ball"

/obj/projectile/bullet/chaos/post_on_hit(var/atom/hit_atom)

	if(!hit_atom)
		return FALSE

	new /obj/projectile/bullet/chaos_no_respawn(hit_atom.loc,owner,weapon,vel_x,vel_y,shoot_x,shoot_y)
	new /obj/projectile/bullet/chaos_no_respawn(hit_atom.loc,owner,weapon,vel_x*-1,vel_y,shoot_x,shoot_y)
	new /obj/projectile/bullet/chaos_no_respawn(hit_atom.loc,owner,weapon,vel_x,vel_y*-1,shoot_x,shoot_y)
	new /obj/projectile/bullet/chaos_no_respawn(hit_atom.loc,owner,weapon,vel_x*-1,vel_y*-1,shoot_x,shoot_y)

	return TRUE

/obj/projectile/bullet/chaos_no_respawn
	name = "chaos ball"
	icon = 'icons/obj/projectiles/chaos.dmi'
	icon_state = "ball"