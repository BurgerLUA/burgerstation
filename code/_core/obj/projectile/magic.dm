/obj/projectile/bullet/fireball
	name = "fireball"
	icon = 'icons/obj/projectiles/fire.dmi'
	icon_state = "ball"

/obj/projectile/bullet/chaos
	name = "chaos ball"
	icon = 'icons/obj/projectiles/chaos.dmi'
	icon_state = "ball"

/obj/projectile/bullet/magic_missile
	name = "magic missile"
	icon = 'icons/obj/projectiles/arrow.dmi'
	icon_state = "arrow"

/obj/projectile/bullet/rift
	name = "magic rift"
	icon = 'icons/obj/projectiles/rift.dmi'
	icon_state = "rift"

/obj/projectile/bullet/rift/post_on_hit(var/atom/hit_atom)
	new /obj/trigger/rift/forest_debug(previous_loc)