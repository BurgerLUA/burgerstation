/obj/item/weapon/ranged/

	var/list/shoot_sounds = list()

	var/bullet_speed = 31

	var/obj/projectile/projectile = /obj/projectile/

	var/automatic = FALSE

	var/shoot_delay = 4 //In deciseconds

	var/next_shoot_time = 0

	damage_type //This is the damage type for a melee attack
	var/damagetype/ranged_damage_type //This is the damage type for a ranged attack


/obj/item/weapon/ranged/proc/get_ammo_count() //How much ammo is in the gun.
	return 1 //Unlimited

/obj/item/weapon/ranged/proc/can_shoot()
	return next_shoot_time <= curtime

/obj/item/weapon/ranged/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(..())
		return TRUE


	if(!automatic)
		return shoot(caller,object,location,params)
	else
		return TRUE

obj/item/weapon/ranged/proc/shoot(var/mob/caller as mob,var/atom/object,location,params)

	if(!can_shoot())
		return

	if(!caller.can_attack(object,params))
		return ..()

	if(!object)
		return ..()

	if(!object.x && !object.y && !object.z)
		return ..()

	if(get_dist(caller,object) <= 1)
		return ..()

	if(projectile)

		var/area/A = get_area(caller)
		play_sound(pick(shoot_sounds),all_mobs,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)

		var/caller_fake_x = caller.x*TILE_SIZE + caller.pixel_x
		var/caller_fake_y = caller.y*TILE_SIZE + caller.pixel_y

		var/object_fake_x = object.x*TILE_SIZE + text2num(params["icon-x"]) - 16
		var/object_fake_y = object.y*TILE_SIZE + text2num(params["icon-y"]) - 16

		var/diffx = object_fake_x - caller_fake_x
		var/diffy = object_fake_y - caller_fake_y

		var/highest = max(abs(diffx),abs(diffy))

		if(highest > 0)
			var/normx = diffx/highest
			var/normy = diffy/highest

			var/turf/T = get_turf(caller)

			bullet_speed = min(bullet_speed,31)

			new projectile(T,caller,src,normx * bullet_speed,normy * bullet_speed)

		else
			return FALSE

	next_shoot_time = curtime + shoot_delay
	caller.move_delay += max(0.3,shoot_delay)
	caller.face_atom(object)

	return TRUE

obj/item/weapon/ranged/do_automatic(var/mob/caller,var/atom/object,location,params)
	if(defer_attack(caller,object,location,null,params))
		return TRUE
	shoot(caller,object,location,params)

