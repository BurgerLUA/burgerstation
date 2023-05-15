/obj/projectile/airblast
	name = "airblast"
	desc = "RETUUUUURN TO SENDER!"

	icon = 'icons/obj/projectiles/spray.dmi'
	icon_state = "airblast"
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
	collides_with_projectiles = TRUE

	penetrations_left = 3

	hostile = FALSE
	alpha = 200

/obj/projectile/airblast/on_projectile_hit(atom/hit_atom, turf/old_loc, turf/new_loc)
	if(projectile_blacklist[hit_atom])
		return FALSE

	projectile_blacklist[hit_atom] = TRUE

	. = FALSE //Haven't hit anything yet.

	if(istype(hit_atom, /obj/projectile)) //If we hit a projectile.
		//log_debug("Airblast Hit Projectile!")
		var/obj/projectile/HP = hit_atom
		var/turf/T = get_turf(hit_atom)
		if(HP.loyalty_tag == loyalty_tag) // Dont coun't our teams projectiles.
			return FALSE
		if(T)
			HP.start_turf = T
			HP.previous_loc = T
			HP.current_loc = T

			var/oldx = HP.vel_x
			var/oldy = HP.vel_y

			HP.vel_x = -oldx
			HP.vel_y = -oldy

			var/matrix/M = get_base_transform()
			var/new_angle = -ATAN2(HP.vel_x,HP.vel_y) + 90
			M.Turn(new_angle)
			HP.transform = M

			HP.owner = owner
			HP.blamed = blamed
			HP.loyalty_tag = loyalty_tag // It is now the airblasters team.
			HP.damage_multiplier += 4 // CRITICAL
			//log_debug("RETUUUUUUURNT TO SENDA!")
		. = TRUE //Reply we hit something
	return .
/obj/projectile/airblast/update_projectile(tick_rate = 1)
	. = ..()
	if(.)
		vel_x *= 0.8
		vel_y *= 0.8
		alpha = clamp(alpha-20,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			return FALSE
