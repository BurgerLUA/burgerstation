/obj/item/weapon/ranged/

	var/list/shoot_sounds = list()

	var/bullet_speed = 31

	var/bullet_count = 1

	var/obj/projectile/projectile = /obj/projectile/

	var/automatic = TRUE

	var/shoot_delay = 4 //In deciseconds

	var/next_shoot_time = 0


	damage_type = /damagetype/blunt/pistol
	var/damagetype/ranged_damage_type //This is the damage type for a ranged attack

/obj/item/weapon/ranged/proc/get_static_spread() //Base spread
	return 0.1

/obj/item/weapon/ranged/proc/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))

/obj/item/weapon/ranged/New()
	if(ranged_damage_type)
		ranged_damage_type = new ranged_damage_type
	..()

/obj/item/weapon/ranged/proc/get_ammo_count() //How much ammo is in the gun.
	return 1 //Unlimited

/obj/item/weapon/ranged/proc/can_owner_shoot(var/mob/caller)
	return next_shoot_time <= curtime

/obj/item/weapon/ranged/proc/can_gun_shoot(var/mob/caller)

	if(get_ammo_count() <= 0)
		return FALSE

	return TRUE

/obj/item/weapon/ranged/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!automatic)
		if(shoot(caller,object,location,params))
			return TRUE
		else
			return ..()

	return TRUE

obj/item/weapon/ranged/proc/handle_ammo(var/mob/caller)
	return TRUE

obj/item/weapon/ranged/proc/shoot(var/mob/caller as mob,var/atom/object,location,params)

	if(!object)
		return ..()

	//caller.move_delay = max(caller.move_delay,0.5)
	caller.face_atom(object)

	/*
	if(!caller.can_attack(object,params))
		return ..()
	*/

	if(!can_owner_shoot(caller))
		return

	if(!object.x && !object.y && !object.z)
		return ..()

	next_shoot_time = curtime + shoot_delay

	if(!can_gun_shoot(caller))
		caller.to_chat(span("danger","*click click*"))
		var/area/A = get_area(caller.loc)
		play_sound('sounds/weapon/misc/empty.ogg',all_mobs,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
		return FALSE

	handle_ammo(caller)
	update_icon()


	if(projectile)

		var/area/A = get_area(caller)
		play_sound(pick(shoot_sounds),all_mobs,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)

		var/caller_fake_x = caller.x*TILE_SIZE + caller.pixel_x
		var/caller_fake_y = caller.y*TILE_SIZE + caller.pixel_y

		var/icon_pos_x = 0
		var/icon_pos_y = 0

		if(params["icon-x"])
			icon_pos_x = text2num(params["icon-x"])

		if(params["icon-y"])
			icon_pos_y = text2num(params["icon-y"])

		var/object_fake_x = object.x*TILE_SIZE + icon_pos_x - 16
		var/object_fake_y = object.y*TILE_SIZE + icon_pos_y - 16

		var/accuracy_loss = get_static_spread()
		if(is_living(caller))
			var/mob/living/L = caller
			accuracy_loss += get_skill_spread(L)

		for(var/i=1,i<=bullet_count,i++)
			var/diffx = object_fake_x - caller_fake_x
			var/diffy = object_fake_y - caller_fake_y
			var/distance = sqrt(diffx ** 2 + diffy ** 2)
			var/inaccuracy_x = rand(-distance*accuracy_loss,distance*accuracy_loss)
			var/inaccuracy_y = rand(-distance*accuracy_loss,distance*accuracy_loss)

			diffx += inaccuracy_x
			diffy += inaccuracy_y

			var/highest = max(abs(diffx),abs(diffy))

			if(highest > 0)
				var/normx = diffx/highest
				var/normy = diffy/highest

				var/turf/T = get_turf(caller)


				bullet_speed = min(bullet_speed,31)

				var/obj/projectile/P = new projectile(T,caller,src,normx * bullet_speed,normy * bullet_speed,icon_pos_x,icon_pos_y)
				if(get_dist(caller,object) <= 1 && is_mob(object))
					P.on_hit(object)



			else
				return FALSE

	return TRUE

obj/item/weapon/ranged/do_automatic(var/mob/caller,var/atom/object,location,params)
	if(!automatic || defer_attack(caller,object,location,null,params) || object.plane > 1)
		return TRUE
	shoot(caller,object,location,params)

