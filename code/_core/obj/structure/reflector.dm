/obj/structure/reflector/
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

	var/reflects_left
	var/ticks_to_live

	var/delete_time = 0

/obj/structure/reflector/Finalize()
	START_THINKING(src)
	. = ..()

/obj/structure/reflector/think()
	if(world.time >= delete_time)
		STOP_THINKING(src)
		qdel(src)
	alpha = clamp(alpha-15,0,255)
	. = ..()


/obj/structure/reflector/New(desired_loc,var/atom/desired_owner,var/desired_loyalty_tag,var/desired_x = 0,var/desired_y = 0,var/desired_reflects_left=3,var/ticks_to_live = SECONDS_TO_DECISECONDS(1.5))

	if(!desired_owner)
		log_error("WARNING: REFLECTOR [src.get_debug_name()] DID NOT HAVE AN OWNER!")
		qdel(src)
		return FALSE

	owner = desired_owner
	loyalty_tag = desired_loyalty_tag
	reflects_left = desired_reflects_left

	delete_time = world.time + ticks_to_live

	vel_x = desired_x
	vel_y = desired_y

	var/turf/T = get_turf(src)

	var/diff_x = desired_x - (T.x * TILE_SIZE) - (TILE_SIZE * 0.5)
	var/diff_y = desired_y - (T.y * TILE_SIZE) - (TILE_SIZE * 0.5)

	var/transform_angle = - ATAN2(diff_x,diff_y) + 90
	var/matrix/M = get_base_transform()
	M.Turn(transform_angle)
	transform = M

	. = ..()


/obj/structure/reflector/on_projectile_hit(atom/hit_atom, turf/old_loc, turf/new_loc)
	if(projectile_blacklist[hit_atom])
		return FALSE

	projectile_blacklist[hit_atom] = TRUE

	. = FALSE //Haven't hit anything yet.

	if(istype(hit_atom, /obj/projectile))
		//log_debug("Reflector Hit Projectile!")
		var/obj/projectile/HP = hit_atom
		var/turf/T = get_turf(hit_atom)
		if(HP.loyalty_tag == loyalty_tag)
			HP.penetrations_left++ // Note: This doesnt actually give the projectile a penetration, because it hitting this consumed one.
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
			HP.blamed = owner
			HP.loyalty_tag = loyalty_tag
			HP.penetrations_left++ //Same as above.

			HP.damage_multiplier += 2.5 // CRITICAL
			//log_debug("RETUUUUUUURNT TO SENDA!")
		. = TRUE //Reply we hit something

		reflects_left--

		if(reflects_left <= 0)
			qdel(src)
	return .


