/obj/item/weapon/ranged/

	var/list/shoot_sounds = list()

	var/automatic = FALSE
	var/max_bursts = 0 //Set to a number greater than 0 to limit automatic fire.
	var/current_bursts = 0
	var/shoot_delay = 4 //In deciseconds
	var/next_shoot_time = 0

	var/projectile_speed = 31 //Fallback value
	var/obj/projectile/projectile = /obj/projectile/ //Fallback value
	var/bullet_count = 1 //Fallback value
	damage_type = "gun_butt"

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

	//Dynamic accuracy.
	var/heat_per_shot = 0.05
	var/heat_current = 0
	var/heat_max = 0.2

	var/movement_spread_base = 0.1
	var/movement_spread_mul = 0.2

	var/bullet_color = "#FFFFFF"

	var/view_punch = 0

	var/requires_bullets = FALSE

	var/obj/item/firing_pin/firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen //Unless stated otherwise, all guns can only be fired by NanoTrasen personel.

/obj/item/weapon/ranged/on_spawn()
	firing_pin = new firing_pin(src)
	return ..()

/obj/item/weapon/ranged/proc/get_heat_spread()
	return heat_current

/obj/item/weapon/ranged/proc/get_static_spread() //Base spread
	return 0.025

/obj/item/weapon/ranged/proc/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/proc/get_movement_spread(var/mob/living/L)
	return clamp(movement_spread_base + movement_spread_mul*(TICKS_TO_SECONDS(L.move_delay)),0,movement_spread_base)

/obj/item/weapon/ranged/proc/get_ammo_count() //How much ammo is in the gun.
	return 1 //Unlimited

/obj/item/weapon/ranged/proc/can_owner_shoot(var/mob/caller)

	if(!caller.can_attack(null,src))
		return FALSE

	return TRUE

/obj/item/weapon/ranged/proc/can_gun_shoot(var/mob/caller)

	if(!firing_pin || !firing_pin.can_shoot(caller,src))
		return FALSE

	if(next_shoot_time > world.time)
		return FALSE

	return TRUE

/obj/item/weapon/ranged/think()

	if(next_shoot_time + min(10,shoot_delay*2) < world.time)
		heat_current = max(heat_current-1,0)

	. = ..()

	return . && heat_current > 0

/obj/item/weapon/ranged/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(wield_only && !wielded)
		caller.to_chat(span("notice","You can only fire this when wielded! (CTRL+CLICK)"))
		return ..()

	if(shoot(caller,object,location,params))
		return TRUE

	return ..()

obj/item/weapon/ranged/proc/handle_ammo(var/mob/caller)
	return FALSE

obj/item/weapon/ranged/proc/handle_empty(var/mob/caller)
	caller.to_chat(span("danger","*click*"))
	var/area/A = get_area(caller.loc)
	if(length(empty_sounds))
		play_sound(pick(empty_sounds),all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment,volume = 50)

	return FALSE

obj/item/weapon/ranged/proc/shoot(var/atom/caller,var/atom/object,location,params,var/damage_multiplier=1)

	if(!object)
		return FALSE

	caller.face_atom(object)

	if(ismob(caller))
		var/mob/M = caller
		M.attack_turn = world.time + M.attack_turn_delay

	if(!can_owner_shoot(caller))
		return FALSE

	if(!object.x && !object.y && !object.z)
		return FALSE

	if(!can_gun_shoot(caller))
		return FALSE

	next_shoot_time = world.time + shoot_delay

	var/obj/projectile/projectile_to_use = projectile
	var/list/shoot_sounds_to_use = shoot_sounds
	var/damage_type_to_use = damage_type
	var/bullet_count_to_use = bullet_count
	var/bullet_spread = 0
	var/projectile_speed_to_use = projectile_speed

	var/obj/item/bullet_cartridge/spent_bullet = handle_ammo(caller)

	if(spent_bullet)
		if(spent_bullet.projectile)
			projectile_to_use = spent_bullet.projectile
		if(spent_bullet.shoot_sounds && length(spent_bullet.shoot_sounds))
			shoot_sounds_to_use = spent_bullet.shoot_sounds
		if(spent_bullet.damage_type)
			damage_type_to_use = spent_bullet.damage_type
		if(spent_bullet.projectile_count)
			bullet_count_to_use = spent_bullet.projectile_count
		if(spent_bullet.base_spread)
			bullet_spread = spent_bullet.base_spread
		if(spent_bullet.projectile_speed)
			projectile_speed_to_use = spent_bullet.projectile_speed
	else if(requires_bullets)
		handle_empty(caller)
		return FALSE

	projectile_speed_to_use = min(projectile_speed_to_use,31)

	update_icon()

	if(projectile_to_use)

		var/area/A = get_area(caller)

		if(length(shoot_sounds))
			play_sound(pick(shoot_sounds_to_use),all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)

		if(!params || !length(params))
			params = list()

		if(!params[PARAM_ICON_X])
			params[PARAM_ICON_X] = rand(0,32)

		if(!params[PARAM_ICON_Y])
			params[PARAM_ICON_Y] = rand(0,32)

		var/icon_pos_x = text2num(params[PARAM_ICON_X])
		var/icon_pos_y = text2num(params[PARAM_ICON_Y])

		var/accuracy_loss = get_static_spread() + get_heat_spread() + bullet_spread
		if(is_living(caller))
			var/mob/living/L = caller
			accuracy_loss += (get_skill_spread(L) + get_movement_spread(L))


		accuracy_loss = clamp(accuracy_loss,0,0.5)

		var/view_punch_time = shoot_delay

		shoot_projectile(caller,object,location,params,projectile_to_use,damage_type_to_use,icon_pos_x,icon_pos_y,accuracy_loss,projectile_speed_to_use,bullet_count_to_use,bullet_color,view_punch,view_punch_time,damage_multiplier,firing_pin ? firing_pin.iff_tag : null)

	heat_current = min(heat_max, heat_current + heat_per_shot)
	start_thinking(src)

	if(firing_pin)
		firing_pin.on_shoot(caller,src)

	if(automatic)
		spawn(next_shoot_time - world.time)
			var/mob/living/advanced/player/P

			if(is_player(caller))
				P = caller
			else if(istype(caller,/mob/living/vehicle/))
				var/mob/living/vehicle/V = caller
				if(length(V.passengers) && is_player(V.passengers[1]))
					P = V.passengers[1]

			if(P && P.client && ((P.right_item = src && P.attack_flags & ATTACK_HELD_RIGHT) || (P.left_item = src && P.attack_flags & ATTACK_HELD_LEFT)) )
				next_shoot_time = 0 //This is needed.
				if((max_bursts <= 0 || current_bursts < (max_bursts-1)) && shoot(caller,P.client.last_object,P.client.last_location,P.client.last_params,damage_multiplier))
					current_bursts += 1
				else if(max_bursts > 0)
					next_shoot_time = world.time + shoot_delay*current_bursts
					current_bursts = 0

			else if(max_bursts > 0)
				next_shoot_time = world.time + shoot_delay*current_bursts
				current_bursts = 0

	return TRUE

/atom/proc/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color,var/view_punch=0,var/view_punch_time=2,var/damage_multiplier=1,var/desired_iff_tag)

	//icon_pos_x and icon_pos_y are basically where the bullet is supposed to travel relative to the tile, NOT where it's going to hit on someone's body

	var/target_fake_x = target.x*TILE_SIZE + icon_pos_x - 16
	var/target_fake_y = target.y*TILE_SIZE + icon_pos_y - 16

	var/final_pixel_target_x = rand(-8,8)
	var/final_pixel_target_y = rand(-8,8)

	if(is_living(caller))
		var/mob/living/L = caller
		var/list/target_cords = L.get_current_target_cords(params)
		final_pixel_target_x = target_cords[1]
		final_pixel_target_y = target_cords[2]

	for(var/i=1,i<=bullet_count_to_use,i++)

		var/list/xy_list = get_projectile_path(caller,target_fake_x,target_fake_y,i,accuracy_loss)

		var/new_x = xy_list[1]
		var/new_y = xy_list[2]

		var/highest = max(abs(new_x),abs(new_y))

		if(highest > 0)
			var/normx = new_x/highest
			var/normy = new_y/highest

			var/turf/T = get_turf(caller)

			projectile_speed_to_use = min(projectile_speed_to_use,TILE_SIZE-1)

			if(i == CEILING(bullet_count_to_use/2,1) && is_player(caller) && view_punch && view_punch_time > 1)
				var/mob/living/advanced/player/P = caller
				if(P.client)
					var/client/C = P.client
					animate(C,pixel_x = -normx*view_punch, pixel_y = -normy*view_punch, time = (view_punch_time-1)*0.5)
					animate(C,pixel_x = 0, pixel_y = 0, time = view_punch_time-1)

			new projectile_to_use(T,caller,src,normx * projectile_speed_to_use,normy * projectile_speed_to_use,final_pixel_target_x,final_pixel_target_y, get_turf(target), damage_type_to_use, target, bullet_color, caller, damage_multiplier, desired_iff_tag)


/atom/proc/get_projectile_path(var/atom/caller,var/desired_x,var/desired_y,var/bullet_num,var/accuracy)

	var/caller_fake_x = caller.x*TILE_SIZE + caller.pixel_x
	var/caller_fake_y = caller.y*TILE_SIZE + caller.pixel_y

	var/diffx = desired_x - caller_fake_x
	var/diffy = desired_y - caller_fake_y
	var/distance = sqrt(diffx ** 2 + diffy ** 2)
	var/inaccuracy_x = RAND_PRECISE(-distance*accuracy,distance*accuracy)
	var/inaccuracy_y = RAND_PRECISE(-distance*accuracy,distance*accuracy)

	diffx += inaccuracy_x
	diffy += inaccuracy_y

	var/highest = max(abs(diffx),abs(diffy))

	if(highest > 0)
		var/normx = diffx/highest
		var/normy = diffy/highest

		return list(normx,normy)

	return list(0,0)