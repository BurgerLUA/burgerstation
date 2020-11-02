/obj/projectile/bullet/firearm
	icon = 'icons/obj/projectiles/bullet.dmi'
	plane = PLANE_EFFECT_LIGHTING

/obj/projectile/bullet/firearm/revolver
	name = "revolver bullet"
	icon_state = "bullet_small"

/obj/projectile/bullet/firearm/sniper
	name = "sniper bullet"
	icon_state = "bullet_massive"

/obj/projectile/bullet/revolver_large
	name = "revolver bullet"
	icon_state = "bullet_large"

/obj/projectile/bullet/firearm/rifle
	name = "rifle bullet"
	icon_state = "bullet_large"

/obj/projectile/bullet/firearm/smg
	name = "smg bullet"
	icon_state = "bullet_small"

/obj/projectile/bullet/firearm/pistol
	name = "pistol bullet"
	icon_state = "bullet_small"

/obj/projectile/bullet/firearm/shotgun_pellet
	name = "shotgun pellet"
	icon_state = "pellet"

/obj/projectile/bullet/firearm/shotgun_pellet/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1)
	icon_state = "pellets_[rand(1,4)]"
	return ..()

/obj/projectile/bullet/firearm/shotgun_flechette
	name = "shotgun flechette"
	icon_state = "flechette"

/obj/projectile/bullet/firearm/shotgun_flechette/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1)
	icon_state = "flechettes_[rand(1,4)]"
	return ..()


/obj/projectile/bullet/firearm/shotgun_slug
	name = "shotgun slug"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_large"

/obj/projectile/bullet/firearm/pistol/stealth
	name = "stealth pistol bullet"
	icon_state = "stealth"