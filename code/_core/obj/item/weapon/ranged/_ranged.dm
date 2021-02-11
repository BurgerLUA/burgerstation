/obj/item/weapon/ranged/

	var/list/shoot_sounds = list()
	var/shoot_alert = ALERT_LEVEL_CAUTION

	var/automatic = FALSE
	var/max_bursts = 0 //Set to a number greater than 0 to limit automatic fire.
	var/current_bursts = 0 //Read only.
	var/shoot_delay = 4 //In deciseconds
	var/burst_delay = 0 //In deciseconds. Set to 0 to just use shoot_delay*bursts
	var/next_shoot_time = 0

	var/ranged_damage_type
	var/projectile_speed = 31 //Fallback value
	var/obj/projectile/projectile = /obj/projectile/ //Fallback value
	var/bullet_count = 1 //Fallback value. How many bullets it should shoot.
	damage_type = /damagetype/melee/club/gun_butt

	var/list/empty_sounds = list()

	//Dynamic accuracy.
	var/heat_per_shot = 0.05
	var/heat_current = 0
	var/heat_max = 0.2

	var/movement_spread_base = 0.05
	var/movement_spread_mul = 0.1

	var/bullet_color = "#FFFFFF"

	var/view_punch = 0

	var/requires_bullets = FALSE

	var/ai_heat_sensitivity = 1 //How much heat matters when trying to make a shot. Should be less for weapons that you're supposed to spray and pray with, basically.

	var/obj/item/firing_pin/firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen //Unless stated otherwise, all guns can only be fired by NanoTrasen personel.

	var/inaccuracy_modifer = 1 //The modifer for target doll inaccuracy. Lower values means more accurate.

	var/use_loyalty_tag = FALSE //Set to true if this weapon uses a loyalty tag instead of a firing pin. Used for spells.

	var/list/attachment_whitelist = list()
	var/obj/item/attachment/attachment_barrel
	var/attachment_barrel_offset_x = 0
	var/attachment_barrel_offset_y = 0
	var/obj/item/attachment/attachment_sight
	var/attachment_sight_offset_x = 0
	var/attachment_sight_offset_y = 0
	var/obj/item/attachment/attachment_undermount
	var/attachment_undermount_offset_x = 0
	var/attachment_undermount_offset_y = 0
	var/obj/item/attachment/stock/attachment_stock
	var/attachment_stock_offset_x = 0
	var/attachment_stock_offset_y = 0

	drop_sound = 'sound/items/drop/gun.ogg'

	var/list/attachment_stats = list()

/obj/item/weapon/ranged/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("firing_pin")
	SAVEATOM("attachment_barrel")
	SAVEATOM("attachment_sight")
	SAVEATOM("attachment_undermount")
	SAVEATOM("attachment_stock")
	return .

/obj/item/weapon/ranged/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("firing_pin")
	LOADATOM("attachment_barrel")
	LOADATOM("attachment_sight")
	LOADATOM("attachment_undermount")
	LOADATOM("attachment_stock")
	update_attachment_stats()
	return .

/obj/item/weapon/ranged/Finalize()

	. = ..()

	if(!istype(firing_pin))
		firing_pin = null

	return .


/obj/item/weapon/ranged/proc/get_ranged_damage_type()
	return ranged_damage_type

/obj/item/weapon/ranged/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object



	if(istype(object,/obj/item/attachment))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		add_attachment(caller,object)
		return TRUE

	else if(!use_loyalty_tag && is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			remove_attachment(caller)
			return TRUE
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(istype(firing_pin))
				firing_pin.drop_item(get_turf(src))
				caller.visible_message(span("notice","\The [caller.name] removes a firing pin from \the [src.name]."),span("notice","You remove \the [firing_pin.name] from \the [src.name]."))
				firing_pin = null
			else
				caller.to_chat(span("warning","There is no firing pin inside \the [src.name]!"))
			return TRUE
		if(istype(I,/obj/item/firing_pin/))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(istype(firing_pin))
				caller.to_chat(span("warning","There is already a [firing_pin.name] installed in \the [src.name]! Remove it with a screwdriver first!"))
			else
				I.drop_item(src)
				firing_pin = I
				caller.visible_message(span("notice","\The [caller.name] installs a firing pin into \the [src.name]."),span("notice","You carefully slide in and install \the [I.name] into \the [src.name]."))
			return TRUE

	return ..()

/obj/item/weapon/ranged/Generate()
	if(!use_loyalty_tag && ispath(firing_pin))
		firing_pin = new firing_pin(src)
		INITIALIZE(firing_pin)
		GENERATE(firing_pin)
		FINALIZE(firing_pin)
	return ..()

/obj/item/weapon/ranged/proc/get_heat_spread()
	return heat_current

/obj/item/weapon/ranged/proc/get_static_spread()
	return 0.025

/obj/item/weapon/ranged/proc/get_skill_spread(var/mob/living/L)
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/proc/get_movement_spread(var/mob/living/L)
	return clamp(movement_spread_base + movement_spread_mul*(TICKS_TO_SECONDS(L.move_delay)),0,movement_spread_base)

/obj/item/weapon/ranged/proc/get_ammo_count() //How much ammo is in the gun.
	return 1 //Unlimited

/obj/item/weapon/ranged/proc/can_owner_shoot(var/mob/caller,var/atom/object,location,params)

	if(!caller.can_attack(object,src,location,params))
		return FALSE

	return TRUE

/obj/item/weapon/ranged/proc/can_gun_shoot(var/mob/caller,var/atom/object,location,params)

	if(quality <= 0)
		return FALSE

	if(!use_loyalty_tag)
		if(ispath(firing_pin))
			log_error("WARNING: WEAPON OF TYPE [src.type] HAD A PATH AS A FIRING PIN.")
			firing_pin = null

		if(!firing_pin)
			caller.to_chat(span("warning","This gun doesn't have a firing pin installed!"))
			return FALSE

		if(!firing_pin.can_shoot(caller,src))
			//Messages are handled in the above proc.
			return FALSE

	if(next_shoot_time > world.time)
		return FALSE

	return TRUE

/obj/item/weapon/ranged/think()

	if(next_shoot_time + min(10,shoot_delay*1.25) < world.time)
		heat_current = max(heat_current-0.1,0)

	. = ..()

	return . && heat_current > 0

/obj/item/weapon/ranged/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(wield_only && !wielded)
		caller.to_chat(span("warning","You can only fire this when wielded! (CTRL+CLICK)"))
		return ..()

	if(istype(object,/obj/parallax))
		object = object.defer_click_on_object(caller,location,control,params) //Only time defer_click_on_object should be used like this.

	if(object.z && shoot(caller,object,location,params))
		return TRUE

	return ..()

obj/item/weapon/ranged/proc/handle_ammo(var/mob/caller)
	return FALSE

obj/item/weapon/ranged/proc/handle_empty(var/mob/caller)
	if(length(empty_sounds))
		var/turf/T = get_turf(src)
		play_sound(pick(empty_sounds),T,range_max = VIEW_RANGE*0.5)

	return FALSE


obj/item/weapon/ranged/proc/get_shoot_delay(var/mob/caller,var/atom/target,location,params)

	. = shoot_delay

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		if(A.ai)
			. *= max(1,(heat_current*ai_heat_sensitivity)*(get_dist(caller,target)/VIEW_RANGE)*RAND_PRECISE(0.9,1.1))

	return .

obj/item/weapon/ranged/proc/play_shoot_sounds(var/mob/caller,var/list/shoot_sounds_to_use = list(),var/shoot_alert_to_use = ALERT_LEVEL_NONE)

	if(length(shoot_sounds_to_use))
		var/turf/T = get_turf(src)
		play_sound(pick(shoot_sounds_to_use),T,range_max=VIEW_RANGE + ZOOM_RANGE*3)
		if(shoot_alert_to_use)
			create_alert(VIEW_RANGE + ZOOM_RANGE*3,T,caller,shoot_alert_to_use)
		return TRUE

	return FALSE

obj/item/weapon/ranged/proc/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1)

	if(!object)
		return FALSE

	var/turf/object_turf = get_turf(object)

	if(!object_turf)
		return FALSE

	if(!object_turf.x && !object_turf.y && !object_turf.z)
		return FALSE

	caller.face_atom(object)

	if(ismob(caller))
		var/mob/M = caller
		M.attack_turn = world.time + M.attack_turn_delay

	if(!can_owner_shoot(caller,object,location,params))
		return FALSE

	if(!can_gun_shoot(caller,object,location,params))
		return FALSE

	var/quality_bonus = get_quality_bonus(0.5,2)
	var/quality_penalty = 1/get_quality_bonus(0.25,2)

	var/obj/projectile/projectile_to_use = projectile
	var/list/shoot_sounds_to_use = shoot_sounds
	var/damage_type_to_use = get_ranged_damage_type()
	var/bullet_count_to_use = bullet_count
	var/bullet_spread_to_use = 0
	var/projectile_speed_to_use = projectile_speed*quality_penalty
	var/bullet_color_to_use = bullet_color
	var/inaccuracy_modifer_to_use = inaccuracy_modifer
	var/view_punch_to_use = view_punch
	var/shoot_delay_to_use = get_shoot_delay(caller,object,location,params)
	var/max_bursts_to_use = max_bursts
	var/shoot_alert_to_use = shoot_alert
	var/damage_multiplier_to_use = damage_multiplier

	if(ranged_damage_type) damage_multiplier_to_use *= quality_bonus

	var/obj/item/bullet_cartridge/spent_bullet = handle_ammo(caller)

	if(spent_bullet)
		SET(projectile_to_use,spent_bullet.projectile)
		SET(shoot_sounds_to_use,spent_bullet.shoot_sounds)
		SET(damage_type_to_use,spent_bullet.damage_type_bullet)
		SET(bullet_count_to_use,spent_bullet.projectile_count)
		ADD(bullet_spread_to_use,spent_bullet.base_spread)
		SET(projectile_speed_to_use,spent_bullet.projectile_speed)
		SET(bullet_color_to_use,spent_bullet.bullet_color)
		MUL(inaccuracy_modifer_to_use,spent_bullet.inaccuracy_modifer)
		damage_multiplier_to_use *= quality_bonus

	else if(requires_bullets)
		handle_empty(caller)
		return FALSE

	if(projectile_to_use)

		if(!params || !length(params))
			params = list()

		if(!params[PARAM_ICON_X])
			params[PARAM_ICON_X] = rand(0,32)

		if(!params[PARAM_ICON_Y])
			params[PARAM_ICON_Y] = rand(0,32)

		var/icon_pos_x = text2num(params[PARAM_ICON_X])
		var/icon_pos_y = text2num(params[PARAM_ICON_Y])

		var/prone = FALSE
		var/static_spread = get_static_spread() * quality_penalty
		var/heat_spread = get_heat_spread() * quality_penalty
		var/skill_spread = 0
		var/movement_spread = 0
		var/loyalty_tag = null

		var/prone_mod = 0.75

		if(is_living(caller))
			var/mob/living/L = caller
			skill_spread = get_skill_spread(L)
			movement_spread = get_movement_spread(L)
			heat_spread *= (1 - L.get_skill_power(SKILL_RANGED)*0.5)
			if(L.horizontal) prone = TRUE
			if(use_loyalty_tag) loyalty_tag = L.loyalty_tag

		if(length(attachment_stats))
			SET(shoot_sounds_to_use,attachment_stats["shoot_sounds"])
			SET(shoot_alert_to_use,attachment_stats["shoot_alert"])
			SET(damage_type_to_use,attachment_stats["damage_type"])
			ADD(bullet_count_to_use,attachment_stats["bullet_count"])
			MUL(bullet_spread_to_use,attachment_stats["bullet_spread"])
			MUL(projectile_speed_to_use,attachment_stats["projectile_speed"])
			SET(bullet_color_to_use,attachment_stats["bullet_color"])
			MUL(inaccuracy_modifer_to_use,attachment_stats["inaccuracy_modifer"])
			MUL(damage_multiplier_to_use,attachment_stats["damage_multiplier"])
			MUL(static_spread,attachment_stats["static_spread"])
			MUL(heat_spread,attachment_stats["heat_spread"])
			MUL(skill_spread,attachment_stats["skill_spread"])
			MUL(movement_spread,attachment_stats["movement_spread"])
			MUL(view_punch_to_use,attachment_stats["view_punch"])
			MUL(shoot_delay_to_use,attachment_stats["shoot_delay"])
			ADD(max_bursts_to_use,attachment_stats["bursts_to_use"])
			MUL(prone_mod,attachment_stats["prone_mod"])

		play_shoot_sounds(caller,shoot_sounds_to_use,shoot_alert_to_use)

		var/accuracy_loss = clamp(static_spread + heat_spread + skill_spread + movement_spread,0,0.5)
		if(prone) accuracy_loss *= prone_mod
		projectile_speed_to_use = min(projectile_speed_to_use,TILE_SIZE - 1)

		var/view_punch_time = shoot_delay
		shoot_projectile(caller,object,location,params,projectile_to_use,damage_type_to_use,icon_pos_x,icon_pos_y,accuracy_loss,projectile_speed_to_use,bullet_count_to_use,bullet_color_to_use,view_punch_to_use,view_punch_time,damage_multiplier_to_use, istype(firing_pin) ? firing_pin.iff_tag : null,loyalty_tag ? loyalty_tag : null,inaccuracy_modifer_to_use)

	next_shoot_time = world.time + shoot_delay_to_use
	heat_current = min(heat_max, heat_current + heat_per_shot)
	start_thinking(src)

	if(!use_loyalty_tag && firing_pin)
		firing_pin.on_shoot(caller,src)

	if(automatic && is_player(caller))
		spawn(next_shoot_time - world.time)
			var/mob/living/advanced/player/P = caller
			if(P && P.client && ((params["left"] && P.attack_flags & CONTROL_MOD_LEFT) || (params["right"] && P.attack_flags & CONTROL_MOD_RIGHT) || max_bursts_to_use) )
				var/list/screen_loc_parsed = parse_screen_loc(P.client.last_params["screen-loc"])
				if(!length(screen_loc_parsed))
					log_error("Warning: [caller] had no screen loc parsed.")
					return TRUE
				var/turf/caller_turf = get_turf(caller)
				var/desired_x = FLOOR(screen_loc_parsed[1]/TILE_SIZE,1) + caller_turf.x - VIEW_RANGE
				var/desired_y = FLOOR(screen_loc_parsed[2]/TILE_SIZE,1) + caller_turf.y - VIEW_RANGE
				var/turf/T = locate(desired_x,desired_y,caller.z)
				if(T)
					next_shoot_time = 0 //This is needed.
					if((max_bursts_to_use <= 0 || current_bursts < (max_bursts_to_use-1)) && shoot(caller,T,P.client.last_location,P.client.last_params,damage_multiplier))
						if(max_bursts_to_use > 0) //Not above because of shoot needing to run.
							current_bursts += 1
					else if(max_bursts_to_use > 0)
						next_shoot_time = world.time + (burst_delay ? burst_delay : shoot_delay*current_bursts)
						current_bursts = 0
				else
					log_error("Warning: [caller] tried shooting in an inavlid turf: [desired_x],[desired_y],[caller.z].")
			else if(max_bursts_to_use > 0)
				next_shoot_time = world.time + (burst_delay ? burst_delay : shoot_delay*current_bursts)
				current_bursts = 0

	update_sprite()

	return TRUE

/atom/proc/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color="#FFFFFF",var/view_punch=0,var/view_punch_time=2,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifer=1,var/base_spread = get_base_spread())

	if(!target)
		CRASH_SAFE("There is no target defined!")
		return FALSE

	//icon_pos_x and icon_pos_y are basically where the bullet is supposed to travel relative to the tile, NOT where it's going to hit on someone's body

	var/target_fake_x = 0
	var/target_fake_y = 0

	var/final_pixel_target_x = 0
	var/final_pixel_target_y = 0

	if(is_living(caller))
		var/mob/living/L = caller
		var/list/target_cords = L.get_current_target_cords(params)
		final_pixel_target_x = target_cords[1]
		final_pixel_target_y = target_cords[2]
	else
		final_pixel_target_x = 16 + rand(-4,4)
		final_pixel_target_y = 16 + rand(-4,4)

	if(caller && length(params) && params["screen-loc"])
		var/list/screen_loc_parsed = parse_screen_loc(params["screen-loc"])
		target_fake_x = caller.x*TILE_SIZE + screen_loc_parsed[1] - (VIEW_RANGE * TILE_SIZE)
		target_fake_y = caller.y*TILE_SIZE + screen_loc_parsed[2] - (VIEW_RANGE * TILE_SIZE)
		if(ismob(caller))
			var/mob/M = caller
			if(M.client)
				target_fake_x = caller.x*TILE_SIZE + screen_loc_parsed[1] - (M.client.view * TILE_SIZE)
				target_fake_y = caller.y*TILE_SIZE + screen_loc_parsed[2] - (M.client.view * TILE_SIZE)
				target_fake_x += M.client.pixel_x
				target_fake_y += M.client.pixel_y
	else
		target_fake_x = target.x*TILE_SIZE + icon_pos_x
		target_fake_y = target.y*TILE_SIZE + icon_pos_y

	var/list/xy_list = get_projectile_path(caller,target_fake_x,target_fake_y,accuracy_loss)

	. = list()

	var/turf/T = get_turf(src)

	for(var/i=1,i<=bullet_count_to_use,i++)

		var/list/local_xy_list = get_projectile_offset(xy_list[1],xy_list[2],i,bullet_count_to_use,base_spread) //Needs to be unique to each shot.

		var/new_x = local_xy_list[1]
		var/new_y = local_xy_list[2]

		var/highest = max(abs(new_x),abs(new_y))

		if(highest > 0)
			var/normx = new_x/highest
			var/normy = new_y/highest

			projectile_speed_to_use = min(projectile_speed_to_use,TILE_SIZE-1)

			if(i == 1 && view_punch && ismob(caller))
				var/mob/M = caller
				if(M.client)
					M.client.desired_recoil_x -= normx*view_punch*2
					M.client.desired_recoil_y -= normy*view_punch*2

			var/mod = HYPOTENUSE(normx,normy)
			var/x_vel = normx * projectile_speed_to_use / mod
			var/y_vel = normy * projectile_speed_to_use / mod

			var/obj/projectile/P = new projectile_to_use(T,caller,src,x_vel,y_vel,final_pixel_target_x,final_pixel_target_y, isturf(target) ? target : get_turf(target), damage_type_to_use, target, bullet_color, caller, damage_multiplier, desired_iff_tag, desired_loyalty_tag, desired_inaccuracy_modifer)
			INITIALIZE(P)
			FINALIZE(P)
			. += P

	return .

/atom/proc/get_base_spread() //Random spread for when it shoots more than one projectile.
	return 0

/atom/proc/get_projectile_path(var/atom/caller,var/desired_x,var/desired_y,var/accuracy)

	//desired_x and desired_y is in pixels.

	//This is where the caller is in the world. Pixel coords.
	var/caller_fake_x = caller.x*TILE_SIZE + caller.pixel_x + 16
	var/caller_fake_y = caller.y*TILE_SIZE + caller.pixel_y + 16

	//Distance. In pixels.
	var/diffx = desired_x - caller_fake_x
	var/diffy = desired_y - caller_fake_y

	var/new_angle = ATAN2(diffx,diffy)
	new_angle += RAND_PRECISE(-accuracy,accuracy)*90

	return list(cos(new_angle),sin(new_angle))

/atom/proc/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)
	var/new_angle = ATAN2(initial_offset_x,initial_offset_y)
	if(bullet_num_max > 1) new_angle += RAND_PRECISE(-accuracy,accuracy)*90
	return list(cos(new_angle),sin(new_angle))

/obj/item/weapon/ranged/proc/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)
	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(1 + get_dist(L,target))*inaccuracy_modifier

/obj/item/weapon/ranged/update_overlays()

	. = ..()

	if(attachment_barrel)
		var/image/I = new/image(attachment_barrel.icon,"[attachment_barrel.icon_state]_attached")
		I.plane = FLOAT_PLANE
		I.pixel_x = attachment_barrel.attachment_offset_x + attachment_barrel_offset_x
		I.pixel_y = attachment_barrel.attachment_offset_y + attachment_barrel_offset_y
		add_overlay(I)

	if(attachment_sight)
		var/image/I = new/image(attachment_sight.icon,"[attachment_sight.icon_state]_attached")
		I.plane = FLOAT_PLANE
		I.pixel_x = attachment_sight.attachment_offset_x + attachment_sight_offset_x
		I.pixel_y = attachment_sight.attachment_offset_y + attachment_sight_offset_y
		add_overlay(I)

	if(attachment_undermount)
		var/image/I = new/image(attachment_undermount.icon,"[attachment_undermount.icon_state]_attached")
		I.plane = FLOAT_PLANE
		I.pixel_x = attachment_undermount.attachment_offset_x + attachment_undermount_offset_x
		I.pixel_y = attachment_undermount.attachment_offset_y + attachment_undermount_offset_y
		add_overlay(I)

	if(attachment_stock)
		var/image/I = new/image(attachment_stock.icon,"[attachment_stock.icon_state]_attached")
		I.plane = FLOAT_PLANE
		I.pixel_x = attachment_stock.attachment_offset_x + attachment_stock_offset_x
		I.pixel_y = attachment_stock.attachment_offset_y + attachment_stock_offset_y
		add_overlay(I)

	return .