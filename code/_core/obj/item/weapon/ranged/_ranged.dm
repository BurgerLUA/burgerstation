/obj/item/weapon/ranged/

	var/list/shoot_sounds = list()
	var/shoot_alert = ALERT_LEVEL_CAUTION

	var/automatic = FALSE
	var/max_bursts = 0 //Set to a number greater than 0 to limit automatic fire.
	var/current_bursts = 0 //Read only.
	var/shoot_delay = 4 //In deciseconds
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
	update_attachments()
	return .

/obj/item/weapon/ranged/proc/get_ranged_damage_type()
	return ranged_damage_type

/obj/item/weapon/ranged/proc/update_attachments()

	automatic = initial(automatic)
	zoom_mul = initial(zoom_mul)
	heat_per_shot = initial(heat_per_shot)

	var/list/list_to_check = list(attachment_barrel,attachment_sight,attachment_undermount,attachment_stock)

	for(var/k in list_to_check)
		if(!k)
			continue
		var/obj/item/attachment/A = k
		if(A.attachment_force_automatic)
			automatic = TRUE
		if(A.attachment_zoom_mul)
			zoom_mul *= A.attachment_zoom_mul
		if(A.attachment_heat_mul)
			heat_per_shot *= A.attachment_heat_mul

	return TRUE

/obj/item/weapon/ranged/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	var/atom/defer_object = object.defer_click_on_object(location,control,params)

	if(istype(defer_object,/obj/item/attachment))
		var/obj/item/attachment/A = defer_object

		if(!length(attachment_whitelist))
			caller.to_chat(span("notice","This weapon does not accept attachments!"))
			return FALSE

		if(!attachment_whitelist[A.type])
			caller.to_chat(span("notice","\The [A.name] cannot fit on \the [src.name]!"))
			return FALSE

		if(istype(A,/obj/item/attachment/barrel))
			if(attachment_barrel)
				caller.to_chat(span("notice","There is already \a [attachment_barrel.name] attached to \the [src.name]!"))
			else
				caller.to_chat(span("notice","You attach \the [A.name] to \the [src.name]."))
				A.drop_item(src)
				attachment_barrel = A
				update_attachments()
				update_sprite()
		else if(istype(A,/obj/item/attachment/sight))
			if(attachment_sight)
				caller.to_chat(span("notice","There is already \a [attachment_sight.name] attached to \the [src.name]!"))
			else
				caller.to_chat(span("notice","You attach \the [A.name] to \the [src.name]."))
				A.drop_item(src)
				attachment_sight = A
				update_attachments()
				update_sprite()
		else if(istype(A,/obj/item/attachment/undermount))
			if(attachment_undermount)
				caller.to_chat(span("notice","There is already \a [attachment_undermount.name] attached to \the [src.name]!"))
			else
				caller.to_chat(span("notice","You attach \the [A.name] to \the [src.name]."))
				A.drop_item(src)
				attachment_undermount = A
				update_attachments()
				update_sprite()
		else if(istype(A,/obj/item/attachment/stock))
			if(attachment_stock)
				caller.to_chat(span("notice","There is already \a [attachment_stock.name] attached to \the [src.name]!"))
			else
				caller.to_chat(span("notice","You attach \the [A.name] to \the [src.name]."))
				A.drop_item(src)
				attachment_stock = A
				update_attachments()
				update_sprite()


		return TRUE

	else if(!use_loyalty_tag && is_item(defer_object))
		var/obj/item/I = defer_object
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)
			var/choice_list = list()
			if(attachment_barrel) choice_list[attachment_barrel.name] = "barrel"
			if(attachment_sight) choice_list[attachment_sight.name] = "sight"
			if(attachment_undermount) choice_list[attachment_undermount.name] = "undermount"
			if(attachment_stock) choice_list[attachment_stock.name] = "stock"
			var/attachment_choice = input("What would you like to remove?","Attachment Removal") as null|anything in choice_list
			switch(choice_list[attachment_choice])
				if("barrel")
					caller.to_chat(span("notice","You remove \the [attachment_barrel.name] from \the [src.name]."))
					attachment_barrel.drop_item(get_turf(caller))
					attachment_barrel = null
					update_attachments()
					update_sprite()
				if("sight")
					caller.to_chat(span("notice","You remove \the [attachment_sight.name] from \the [src.name]."))
					attachment_sight.drop_item(get_turf(caller))
					attachment_sight = null
					update_attachments()
					update_sprite()
				if("undermount")
					caller.to_chat(span("notice","You remove \the [attachment_undermount.name] from \the [src.name]."))
					attachment_undermount.drop_item(get_turf(caller))
					attachment_undermount = null
					update_attachments()
					update_sprite()
				if("stock")
					caller.to_chat(span("notice","You remove \the [attachment_stock.name] from \the [src.name]."))
					attachment_stock.drop_item(get_turf(caller))
					attachment_stock = null
					update_attachments()
					update_sprite()
				else
					caller.to_chat(span("notice","You decide not to remove anything."))
			return TRUE

		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			if(istype(firing_pin))
				firing_pin.force_move(get_turf(src))
				caller.to_chat(span("notice","You remove \the [firing_pin.name] from \the [src.name]."))
				firing_pin = null
			else
				caller.to_chat(span("notice","There is no firing pin inside \the [src.name]!"))
			return TRUE
		if(istype(I,/obj/item/firing_pin/))
			if(istype(firing_pin))
				caller.to_chat(span("notice","There is already a [firing_pin.name] installed in \the [src.name]! Remove it with a screwdriver first!"))
			else
				I.drop_item(src)
				firing_pin = I
				caller.to_chat(span("notice","You carefully slide in and install \the [I.name] into \the [src.name]."))
			return TRUE

	return ..()

/obj/item/weapon/ranged/Generate()
	if(!use_loyalty_tag && ispath(firing_pin))
		firing_pin = new firing_pin(src)
		INITIALIZE(firing_pin)
		GENERATE(firing_pin)
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

/obj/item/weapon/ranged/proc/can_owner_shoot(var/mob/caller,var/atom/object,location,params)

	if(!caller.can_attack(object,src,location,params))
		return FALSE

	return TRUE

/obj/item/weapon/ranged/proc/can_gun_shoot(var/mob/caller,var/atom/object,location,params)

	if(!use_loyalty_tag)
		if(ispath(firing_pin))
			log_error("WARNING: WEAPON OF TYPE [src.type] HAD A PATH AS A FIRING PIN.")
			firing_pin = null

		if(!firing_pin)
			caller.to_chat("This gun doesn't have a firing pin installed!")
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

	return . && (heat_current > 0 || istype(src,/obj/item/weapon/ranged/energy/recharging)) //Shitcode ahoy.

/obj/item/weapon/ranged/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(wield_only && !wielded)
		caller.to_chat(span("notice","You can only fire this when wielded! (CTRL+CLICK)"))
		return ..()

	if(istype(object,/obj/parallax))
		object = object.defer_click_on_object(location,control,params)

	if(object.z && shoot(caller,object,location,params))
		return TRUE

	return ..()

obj/item/weapon/ranged/proc/handle_ammo(var/mob/caller)
	return FALSE

obj/item/weapon/ranged/proc/handle_empty(var/mob/caller)
	caller.to_chat(span("danger","*click*"))
	if(length(empty_sounds))
		play(pick(empty_sounds),src,range_max = 3)
		create_alert(VIEW_RANGE,src,caller,ALERT_LEVEL_NOISE)

	return FALSE


obj/item/weapon/ranged/proc/get_shoot_delay(var/mob/caller,var/atom/target,location,params)

	. = shoot_delay

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		if(A.ai)
			. *= max(1,(heat_current*ai_heat_sensitivity)*(get_dist(caller,target)/VIEW_RANGE)*RAND_PRECISE(0.9,1.1))

	return .

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

	var/obj/projectile/projectile_to_use = projectile
	var/list/shoot_sounds_to_use = shoot_sounds
	var/damage_type_to_use = get_ranged_damage_type()
	var/bullet_count_to_use = bullet_count
	var/bullet_spread = 0
	var/projectile_speed_to_use = projectile_speed
	var/bullet_color_to_use = bullet_color
	var/inaccuracy_modifer_to_use = inaccuracy_modifer
	var/view_punch_to_use = view_punch
	var/shoot_delay_to_use = get_shoot_delay(caller,object,location,params)
	var/max_bursts_to_use = max_bursts
	var/shoot_alert_to_use = shoot_alert
	var/damage_multiplier_to_use = damage_multiplier

	var/obj/item/bullet_cartridge/spent_bullet = handle_ammo(caller)

	if(spent_bullet)
		if(spent_bullet.projectile)
			projectile_to_use = spent_bullet.projectile
		if(spent_bullet.shoot_sounds && length(spent_bullet.shoot_sounds))
			shoot_sounds_to_use = spent_bullet.shoot_sounds
		if(spent_bullet.damage_type_bullet)
			damage_type_to_use = spent_bullet.damage_type_bullet
		if(spent_bullet.projectile_count)
			bullet_count_to_use = spent_bullet.projectile_count
		if(spent_bullet.base_spread)
			bullet_spread = spent_bullet.base_spread
		if(spent_bullet.projectile_speed)
			projectile_speed_to_use = spent_bullet.projectile_speed
		if(spent_bullet.bullet_color)
			bullet_color_to_use = spent_bullet.bullet_color
		if(spent_bullet.inaccuracy_modifer)
			inaccuracy_modifer_to_use = inaccuracy_modifer_to_use * spent_bullet.inaccuracy_modifer //Use both the gun and the bullet.
	else if(requires_bullets)
		handle_empty(caller)
		return FALSE

	var/list/attachment_list = list(attachment_barrel,attachment_sight,attachment_undermount,attachment_stock)

	for(var/k in attachment_list)
		if(!k)
			continue
		var/obj/item/attachment/A = k
		if(A.attachment_accuracy_mod) bullet_spread *= A.attachment_accuracy_mod
		if(A.attachment_damage_mod) damage_multiplier_to_use *= A.attachment_damage_mod
		if(A.attachment_recoil_mod) view_punch_to_use *= A.attachment_recoil_mod
		if(A.attachment_delay_mod) shoot_delay_to_use *= A.attachment_delay_mod
		if(A.attachment_burst_add) max_bursts_to_use += A.attachment_burst_add
		if(A.attachment_inaccuracy_mod) inaccuracy_modifer_to_use *= A.attachment_inaccuracy_mod
		if(A.attachment_shoot_alert) shoot_alert_to_use = A.attachment_shoot_alert
		if(A.attachment_shoot_sound) shoot_sounds_to_use = A.attachment_shoot_sound

	next_shoot_time = world.time + shoot_delay_to_use
	projectile_speed_to_use = min(projectile_speed_to_use,31)

	if(projectile_to_use)

		var/loyalty_tag = null
		if(is_living(caller) && use_loyalty_tag)
			var/mob/living/L = caller
			loyalty_tag = L.loyalty_tag

		if(length(shoot_sounds))
			play(pick(shoot_sounds_to_use),src)
			if(shoot_alert_to_use)
				create_alert(VIEW_RANGE,src,caller,shoot_alert_to_use)

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
		shoot_projectile(caller,object,location,params,projectile_to_use,damage_type_to_use,icon_pos_x,icon_pos_y,accuracy_loss,projectile_speed_to_use,bullet_count_to_use,bullet_color_to_use,view_punch_to_use,view_punch_time,damage_multiplier_to_use, istype(firing_pin) ? firing_pin.iff_tag : null,loyalty_tag ? loyalty_tag : null,inaccuracy_modifer_to_use)

	heat_current = min(heat_max, heat_current + heat_per_shot)
	start_thinking(src)

	if(!use_loyalty_tag && firing_pin)
		firing_pin.on_shoot(caller,src)

	if(automatic && is_player(caller))
		spawn(next_shoot_time - world.time)
			var/mob/living/advanced/player/P = caller
			if(P && P.client && ((params["left"] && P.attack_flags & ATTACK_HELD_LEFT) || (params["right"] && P.attack_flags & ATTACK_HELD_RIGHT)) )
				var/list/screen_loc_parsed = parse_screen_loc(P.client.last_params["screen-loc"])
				if(!length(screen_loc_parsed))
					return TRUE
				var/turf/caller_turf = get_turf(caller)
				var/desired_x = FLOOR(screen_loc_parsed[1]/TILE_SIZE,1) + caller_turf.x - VIEW_RANGE
				var/desired_y = FLOOR(screen_loc_parsed[2]/TILE_SIZE,1) + caller_turf.y - VIEW_RANGE
				var/turf/T = locate(desired_x,desired_y,caller.z)
				if(T)
					next_shoot_time = 0 //This is needed.
					if((max_bursts_to_use <= 0 || current_bursts < (max_bursts_to_use-1)) && shoot(caller,T,P.client.last_location,P.client.last_params,damage_multiplier))
						current_bursts += 1
					else if(max_bursts_to_use > 0)
						next_shoot_time = world.time + shoot_delay*current_bursts
						current_bursts = 0
			else if(max_bursts_to_use > 0)
				next_shoot_time = world.time + shoot_delay*current_bursts
				current_bursts = 0

	update_sprite()

	return TRUE

/atom/proc/shoot_projectile(var/mob/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color,var/view_punch=0,var/view_punch_time=2,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifer=1,var/base_spread = get_base_spread())

	if(!target)
		CRASH_SAFE("There is no target defined!")
		return FALSE

	//icon_pos_x and icon_pos_y are basically where the bullet is supposed to travel relative to the tile, NOT where it's going to hit on someone's body

	var/target_fake_x = target.x*TILE_SIZE + icon_pos_x - 16
	var/target_fake_y = target.y*TILE_SIZE + icon_pos_y - 16

	var/final_pixel_target_x = rand(-8,8) //Fallback.
	var/final_pixel_target_y = rand(-8,8) //Fallback.

	if(is_living(caller))
		var/mob/living/L = caller
		var/list/target_cords = L.get_current_target_cords(params)
		final_pixel_target_x = target_cords[1]
		final_pixel_target_y = target_cords[2]

	if(length(params) && params["screen-loc"])
		var/list/screen_loc_parsed = parse_screen_loc(params["screen-loc"])
		target_fake_x = caller.x*TILE_SIZE + screen_loc_parsed[1] - (VIEW_RANGE * TILE_SIZE)
		target_fake_y = caller.y*TILE_SIZE + screen_loc_parsed[2] - (VIEW_RANGE * TILE_SIZE)
		if(ismob(caller))
			var/mob/M = caller
			target_fake_x += M.client.pixel_x
			target_fake_y += M.client.pixel_y

	var/list/xy_list = get_projectile_path(caller,target_fake_x,target_fake_y,accuracy_loss)

	. = list()

	for(var/i=1,i<=bullet_count_to_use,i++)

		var/list/local_xy_list = get_projectile_offset(xy_list[1],xy_list[2],i,base_spread)

		var/new_x = local_xy_list[1]
		var/new_y = local_xy_list[2]

		var/highest = max(abs(new_x),abs(new_y))

		if(highest > 0)
			var/normx = new_x/highest
			var/normy = new_y/highest

			var/turf/T = get_turf(src)

			projectile_speed_to_use = min(projectile_speed_to_use,TILE_SIZE-1)

			if(i == 1 && view_punch && ismob(caller))
				var/mob/M = caller
				if(M.client)
					M.client.desired_recoil_x -= normx*view_punch*2
					M.client.desired_recoil_y -= normy*view_punch*2

			var/mod = HYPOTENUSE(normx,normy)
			var/x_vel = normx * projectile_speed_to_use / mod
			var/y_vel = normy * projectile_speed_to_use / mod

			var/obj/projectile/P = new projectile_to_use(T,caller,src,x_vel,y_vel,final_pixel_target_x,final_pixel_target_y, get_turf(target), damage_type_to_use, target, bullet_color, caller, damage_multiplier, desired_iff_tag, desired_loyalty_tag, desired_inaccuracy_modifer)
			INITIALIZE(P)
			. += P

	return .

/atom/proc/get_base_spread() //Random spread for when it shoots more than one projectile.
	return 0.01

/atom/proc/get_projectile_path(var/mob/caller,var/desired_x,var/desired_y,var/accuracy)

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

/atom/proc/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/accuracy)
	var/new_angle = ATAN2(initial_offset_x,initial_offset_y)
	new_angle += RAND_PRECISE(-accuracy,accuracy)*90
	return list(cos(new_angle),sin(new_angle))

/obj/item/weapon/ranged/proc/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)
	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(1 + get_dist(L,target))*inaccuracy_modifier

/obj/item/weapon/ranged/update_overlays()

	. = ..()

	if(attachment_barrel)
		var/image/I = new/image(attachment_barrel.icon,"[attachment_barrel.icon_state]_attached")
		I.pixel_x = attachment_barrel.attachment_offset_x + attachment_barrel_offset_x
		I.pixel_y = attachment_barrel.attachment_offset_y + attachment_barrel_offset_y
		add_overlay(I)

	if(attachment_sight)
		var/image/I = new/image(attachment_sight.icon,"[attachment_sight.icon_state]_attached")
		I.pixel_x = attachment_sight.attachment_offset_x + attachment_sight_offset_x
		I.pixel_y = attachment_sight.attachment_offset_y + attachment_sight_offset_y
		add_overlay(I)

	if(attachment_undermount)
		var/image/I = new/image(attachment_undermount.icon,"[attachment_undermount.icon_state]_attached")
		I.pixel_x = attachment_undermount.attachment_offset_x + attachment_undermount_offset_x
		I.pixel_y = attachment_undermount.attachment_offset_y + attachment_undermount_offset_y
		add_overlay(I)

	if(attachment_stock)
		var/image/I = new/image(attachment_stock.icon,"[attachment_stock.icon_state]_attached")
		I.pixel_x = attachment_stock.attachment_offset_x + attachment_stock_offset_x
		I.pixel_y = attachment_stock.attachment_offset_y + attachment_stock_offset_y
		add_overlay(I)

	return .