/obj/projectile/bullet/firearm
	icon = 'icons/obj/projectiles/bullet.dmi'

/obj/projectile/bullet/firearm/revolver
	name = "revolver bullet"
	icon_state = "bullet_small"

/obj/projectile/bullet/firearm/sniper
	name = "sniper bullet"
	icon_state = "bullet_massive"

/obj/projectile/bullet/firearm/sniper/explosive/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,3,owner,weapon,iff_tag)

/obj/projectile/bullet/firearm/rifle
	name = "rifle bullet"
	icon_state = "bullet_large"

/obj/projectile/bullet/firearm/smg
	name = "smg bullet"
	icon_state = "bullet_small"

/obj/projectile/bullet/firearm/pistol
	name = "pistol bullet"
	icon_state = "bullet_small"


/obj/projectile/bullet/firearm/pistol/smart
	name = "smart pistol bullet"
	icon_state = "bullet_small"
	var/smart = FALSE

/obj/projectile/bullet/firearm/pistol/smart/New(var/desired_loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed, var/desired_damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/desired_penetrations_left=0)
	. = ..()

	if(istype(weapon,/obj/item/weapon/ranged/bullet/magazine/smg/smart))
		smart = TRUE

	if(smart && iff_tag && target_turf)
		var/mob/living/best_target
		var/best_distance = INFINITY
		for(var/mob/living/L in range(target_turf,3))
			if(L.dead)
				continue
			if(L.iff_tag == iff_tag)
				continue
			var/dist = get_dist(target_turf,L)
			if(dist < best_distance)
				best_target = L
				best_distance = dist
		if(best_target)
			target_atom = best_target

	if(!is_living(target_atom))
		smart = FALSE


/obj/projectile/bullet/firearm/pistol/smart/update_projectile(var/tick_rate=1)

	. = ..()

	if(. && smart && target_atom && target_atom.z == src.z)
		var/lock_mod = 0.1
		var/list/offsets = get_directional_offsets(current_loc,target_atom)
		vel_x = round(offsets[1]*TILE_SIZE*0.5*lock_mod + vel_x*(1-lock_mod),0.001)
		vel_y = round(offsets[2]*TILE_SIZE*0.5*lock_mod + vel_y*(1-lock_mod),0.001)
		var/current_angle = -ATAN2(vel_x,vel_y) + 90
		var/new_angle = -ATAN2(offsets[1],offsets[2]) + 90
		var/matrix/M = get_base_transform()
		M.Turn(current_angle)
		transform = M
		if(abs(current_angle - new_angle) >= 45) //Out of FOV basically.
			smart = FALSE

	if(target_atom && target_atom.loc == current_loc) //Basically missed the target.
		smart = FALSE

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
	muzzleflash_effect = null