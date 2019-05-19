/obj/item/weapon/ranged/

	var/list/shoot_sounds = list()
	var/bullet_speed = 31
	var/bullet_count = 1
	var/obj/projectile/projectile = /obj/projectile/
	var/automatic = FALSE
	var/shoot_delay = 4 //In deciseconds
	var/next_shoot_time = 0

	damage_type = /damagetype/blunt/pistol

	block_mul = list(
		ATTACK_TYPE_MELEE = 0.5,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	var/list/empty_sounds = list()

/obj/item/weapon/ranged/proc/get_static_spread() //Base spread
	return 0.1

/obj/item/weapon/ranged/proc/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))

/obj/item/weapon/ranged/proc/get_ammo_count() //How much ammo is in the gun.
	return 1 //Unlimited

/obj/item/weapon/ranged/proc/can_owner_shoot(var/mob/caller)
	if(!caller.can_attack())
		return FALSE

	return TRUE

/obj/item/weapon/ranged/proc/can_gun_shoot(var/mob/caller)

	if(next_shoot_time > curtime)
		return FALSE

	return TRUE

/obj/item/weapon/ranged/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(wield_only && !wielded)
		caller.to_chat(span("notice","You can only fire this when wielded! (CTRL+CLICK)"))
		return TRUE

	if(!automatic)
		if(shoot(caller,object,location,params))
			return TRUE
		else
			return ..()

	return TRUE

obj/item/weapon/ranged/proc/handle_ammo(var/mob/caller)
	return FALSE

obj/item/weapon/ranged/proc/handle_empty(var/mob/caller)
	caller.to_chat(span("danger","*click click*"))
	var/area/A = get_area(caller.loc)

	if(length(empty_sounds))
		play_sound(pick(empty_sounds),all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)

	return FALSE

obj/item/weapon/ranged/proc/shoot(var/atom/caller,var/atom/object,location,params)

	if(!object)
		return FALSE

	//caller.move_delay = max(caller.move_delay,0.5)
	caller.face_atom(object)
	if(is_mob(caller))
		var/mob/M = caller
		M.attack_turn = curtime + M.attack_turn_delay

	/*
	if(!caller.can_attack(object,params))
		return ..()
	*/

	if(!can_owner_shoot(caller))
		return FALSE

	if(!object.x && !object.y && !object.z)
		return FALSE

	if(!can_gun_shoot(caller))
		return TRUE

	if(get_ammo_count() <= 0)
		handle_empty(caller)
		return FALSE

	next_shoot_time = curtime + shoot_delay

	var/obj/projectile/projectile_to_use = projectile
	var/list/shoot_sounds_to_use = shoot_sounds
	var/damage_type_to_use = damage_type

	var/obj/item/bullet/spent_bullet = handle_ammo(caller)
	if(spent_bullet)
		if(spent_bullet.projectile)
			projectile_to_use = spent_bullet.projectile
		if(spent_bullet.shoot_sounds && length(spent_bullet.shoot_sounds))
			shoot_sounds_to_use = spent_bullet.shoot_sounds
		if(spent_bullet.damage_type)
			damage_type_to_use = spent_bullet.damage_type

	update_icon()

	if(projectile_to_use)

		var/area/A = get_area(caller)

		if(length(shoot_sounds))
			play_sound(pick(shoot_sounds_to_use),all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)

		var/icon_pos_x = 0
		var/icon_pos_y = 0

		if(params && params["icon-x"])
			icon_pos_x = text2num(params["icon-x"])

		if(params && params["icon-y"])
			icon_pos_y = text2num(params["icon-y"])

		var/object_fake_x = object.x*TILE_SIZE + icon_pos_x - 16
		var/object_fake_y = object.y*TILE_SIZE + icon_pos_y - 16

		var/accuracy_loss = get_static_spread()
		if(is_living(caller))
			var/mob/living/L = caller
			accuracy_loss += get_skill_spread(L)

		for(var/i=1,i<=bullet_count,i++)

			var/list/xy_list = get_projectile_path(caller,object_fake_x,object_fake_y,i,accuracy_loss)

			var/new_x = xy_list[1]
			var/new_y = xy_list[2]

			var/highest = max(abs(new_x),abs(new_y))

			if(highest > 0)
				var/normx = new_x/highest
				var/normy = new_y/highest

				var/turf/T = get_turf(caller)

				bullet_speed = min(bullet_speed,31)

				var/obj/projectile/P = new projectile_to_use(T,caller,src,normx * bullet_speed,normy * bullet_speed,icon_pos_x,icon_pos_y, get_turf(object), damage_type_to_use)

				world.log << P.icon
				world.log << P.icon_state
				world.log << P.type
				world.log << projectile

				world.log << damage_type_to_use

				if(get_dist(caller,object) <= 1 && is_mob(object))
					P.on_hit(object)
			else
				continue

	return TRUE

obj/item/weapon/ranged/proc/get_projectile_path(var/atom/caller,var/desired_x,var/desired_y,var/bullet_num,var/accuracy)

	var/caller_fake_x = caller.x*TILE_SIZE + caller.pixel_x
	var/caller_fake_y = caller.y*TILE_SIZE + caller.pixel_y

	var/diffx = desired_x - caller_fake_x
	var/diffy = desired_y - caller_fake_y
	var/distance = sqrt(diffx ** 2 + diffy ** 2)
	var/inaccuracy_x = rand(-distance*accuracy,distance*accuracy)
	var/inaccuracy_y = rand(-distance*accuracy,distance*accuracy)

	diffx += inaccuracy_x
	diffy += inaccuracy_y

	var/highest = max(abs(diffx),abs(diffy))

	if(highest > 0)
		var/normx = diffx/highest
		var/normy = diffy/highest

		return list(normx,normy)

	return list(0,0)


obj/item/weapon/ranged/do_automatic(var/mob/caller,var/atom/object,location,params)
	if(!automatic || (object && object.plane >= PLANE_HUD))
		return TRUE

	return shoot(caller,object,location,params)

