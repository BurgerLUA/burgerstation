/obj/reflector/

	name = "Reflector"
	desc = "Retuuuuurn to sender!"

	icon = 'icons/obj/projectiles/spray.dmi'
	icon_state = "airblast"

	var/projectile_blacklist = list()

	var/owner
	var/loyalty_tag
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	can_rotate = FALSE

	density = TRUE

	plane = PLANE_MOVABLE
	anchored = FALSE

	alpha = 150

	var/vel_x
	var/vel_y

/obj/reflector/New(var/atom/desired_loc,var/atom/desired_owner,var/desired_loyalty_tag,var/time_to_live=10)

	owner = desired_owner
	loyalty_tag = desired_loyalty_tag
	animate(src,alpha=0,pixel_x=src.pixel_x + vel_x*TILE_SIZE,pixel_y=src.pixel_y + vel_y*TILE_SIZE,time=time_to_live)

	CALLBACK("\ref[src]_do_delete",time_to_live,src,src::do_delete())

	. = ..()

/obj/reflector/proc/do_delete()
	qdel(src)
	return TRUE


/obj/reflector/projectile_should_collide(var/obj/projectile/P,var/turf/old_turf,var/turf/new_turf)

	if(src.loyalty_tag && P.loyalty_tag != src.loyalty_tag)
		return FALSE

	. = ..()

/obj/reflector/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	//Can still be hit.
	return FALSE


/obj/reflector/on_projectile_hit(var/obj/projectile/P,var/turf/old_loc,var/turf/new_loc)

	P.start_turf = new_loc
	P.previous_loc = new_loc
	P.current_loc = new_loc

	P.vel_x *= -1 //Full reflect.
	P.vel_y *= -1 //Full reflect.

	var/matrix/M = P.get_base_transform()
	var/new_angle = ATAN2(P.vel_x,P.vel_y) - 90
	M.Turn(new_angle)
	P.transform = M

	P.owner = src.owner
	P.blamed = src.owner
	P.loyalty_tag = loyalty_tag
	P.penetrations_left += 1

	P.damage_multiplier += 2.5 // CRITICAL


