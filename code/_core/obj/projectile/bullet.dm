/obj/projectile/bullet/
	name = "bullet"
	impact_effect_turf = /obj/effect/temp/impact/bullet
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	muzzleflash_effect = /obj/effect/temp/muzzleflash/

/obj/projectile/bullet/revolver
	name = "revolver bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_small"

/obj/projectile/bullet/sniper
	name = "sniper bullet"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_massive"

/obj/projectile/bullet/revolver_large
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

/obj/projectile/bullet/shotgun_pellet/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1)
	icon_state = "pellets_[rand(1,4)]"
	return ..()

/obj/projectile/bullet/shotgun_slug
	name = "shotgun slug"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_large"

/obj/projectile/bullet/bolt
	name = "crossbow bolt"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "bolt"

/obj/projectile/bullet/syringe
	name = "launched syringe"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "syringe"