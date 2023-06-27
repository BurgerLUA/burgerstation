/obj/item/weapon/ranged/

	var/list/shoot_sounds = list()
	var/shoot_alert = ALERT_LEVEL_COMBAT

	var/damage_mod = 1 //Inherit damage multiplier for the gun. Should be increased if the gun has a longer barrel length.

	var/automatic = FALSE
	var/max_bursts = 0 //Inherint maximum amount of bursts.
	var/current_maxmium_bursts = 0 //Read only. Controlled by firemode changing.
	var/current_bursts = 1 //Read only.
	var/shoot_delay = 4 //In deciseconds
	var/burst_delay = 0 //In deciseconds. Set to 0 to just use shoot_delay*bursts*1.25
	var/next_shoot_time = 0
	var/last_shoot_time = 0 //Only used for revolvers but still.

	var/recoil_delay = 0 //As a factor. Lower values mean slower kicks, higher values mean faster kicks.
	var/queued_recoil = 0

	var/damagetype/ranged_damage_type
	var/projectile_speed = TILE_SIZE - 1 //Fallback value
	var/obj/projectile/projectile //Don't make this a fallback.
	var/bullet_count = 1 //Fallback value. How many bullets it should shoot.

	var/view_punch_to_add = 0 //Fallback value.
	var/view_punch_mod = 1 //Inherit recoil absorbtion from the gun. Lesser values means less recoil.

	var/heat_per_shot_to_add = 0 //Fallback value.
	var/heat_per_shot_mod = 1 //Inherit heat kickback. Lesser values means less spread per bullet shot.

	var/list/empty_sounds = list()

	//Dynamic accuracy.
	var/heat_current = 0 //Do not change.
	var/heat_max = 0.2

	var/inaccuracy_modifier = 1 //The modifier for target doll inaccuracy. Lower values means more accurate. 1 = 32 pixels, 0.5 = 16 pixels.
	var/movement_inaccuracy_modifier = 0 //The additional modifier target doll inaccuracy while adding. Lower values means more accurate. This value is added while moving.

	var/movement_spread_base = 0.05 //half this at walking speed, this at running speed, this times two at sprinting speed

	var/bullet_color = "#FFFFFF"

	var/requires_bullets = FALSE

	var/ai_heat_sensitivity = 1 //How much heat matters when trying to make a shot. Should be less for weapons that you're supposed to spray and pray with, basically.

	var/obj/item/firing_pin/firing_pin = /obj/item/firing_pin

	var/use_iff_tag = FALSE
	var/use_loyalty_tag = FALSE

	var/list/attachment_stats = list()
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
	var/obj/item/attachment/stock_mod/stock_mod
	var/obj/item/attachment/barrel_mod/barrel_mod

	damage_type = /damagetype/melee/club/gun_butt //Melee.

	drop_sound = 'sound/items/drop/gun.ogg'

	dan_mode = TRUE

	var/current_firemode = 1
	var/list/firemodes = list()

	combat_range = VIEW_RANGE

/obj/item/weapon/ranged/PreDestroy()
	QDEL_NULL(attachment_stock)
	QDEL_NULL(attachment_undermount)
	QDEL_NULL(attachment_sight)
	QDEL_NULL(attachment_barrel)
	QDEL_NULL(firing_pin)
	QDEL_NULL(stock_mod)
	QDEL_NULL(barrel_mod)
	. = ..()



/obj/item/weapon/ranged/proc/change_firemode(var/mob/caller)
	if(length(firemodes) <= 1)
		return FALSE
	current_firemode++
	if(current_firemode > length(firemodes))
		current_firemode = 1
	on_firemode_changed(caller)
	return TRUE

/obj/item/weapon/ranged/proc/on_firemode_changed(var/mob/caller)
	var/selected_firemode = firemodes[current_firemode]
	switch(selected_firemode)
		if("automatic")
			automatic = TRUE
			current_maxmium_bursts = 0
		if("semi-automatic")
			automatic = FALSE
		if("burst")
			automatic = TRUE
			current_maxmium_bursts = max_bursts
	caller?.to_chat(span("notice","You switch to [selected_firemode] mode."))
	return TRUE

/obj/item/weapon/ranged/get_examine_list(var/mob/examiner)
	. = ..()

	if(length(firemodes) > 1)
		. += div("notice","You can change between [length(firemodes)] firemodes by alt-clicking while holding this weapon. ")


/obj/item/weapon/ranged/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("firing_pin")
	SAVEATOM("attachment_barrel")
	SAVEATOM("attachment_sight")
	SAVEATOM("attachment_undermount")
	SAVEATOM("attachment_stock")
	SAVEATOM("stock_mod")
	SAVEATOM("barrel_mod")

/obj/item/weapon/ranged/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("firing_pin")
	LOADATOM("attachment_barrel")
	LOADATOM("attachment_sight")
	LOADATOM("attachment_undermount")
	LOADATOM("attachment_stock")
	LOADATOM("stock_mod")
	LOADATOM("barrel_mod")

/obj/item/weapon/ranged/Finalize()

	. = ..()

	if(use_iff_tag && ispath(firing_pin))
		firing_pin = new firing_pin(src)
		INITIALIZE(firing_pin)
		GENERATE(firing_pin)
		FINALIZE(firing_pin)

	if(!istype(firing_pin))
		firing_pin = null

	update_attachment_stats()

	if(!length(firemodes))
		if(max_bursts > 1)
			firemodes = list("burst")
		else if(automatic)
			firemodes = list("automatic")
		else
			firemodes = list("semi-automatic")

	if(max_bursts < 1 && ("burst" in firemodes))
		max_bursts = 3

	on_firemode_changed()

	update_sprite()

/obj/item/weapon/ranged/proc/get_ranged_damage_type()
	return ranged_damage_type

/obj/item/weapon/ranged/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(is_item(object))
		var/obj/item/I = object
		if(istype(I,/obj/item/attachment))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			add_attachment(caller,I)
			return TRUE

		if(use_iff_tag)
			if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				INTERACT_DELAY(5)

				if(remove_attachment(caller))
					return TRUE

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

	. = ..()

/obj/item/weapon/ranged/proc/get_heat_spread()
	return heat_current

/obj/item/weapon/ranged/proc/get_static_spread()
	return 0.1

/obj/item/weapon/ranged/proc/get_skill_spread(var/mob/living/L)
	return 0.01 - (0.02 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/proc/get_movement_spread(var/mob/living/L)

	if(L.next_move <= 0)
		return 0

	. = movement_spread_base

	switch(L.move_mod)
		if(1)
			. *= 0.5
		if(3)
			. *= 3


/obj/item/weapon/ranged/proc/get_ammo_count() //How much ammo is in the gun.
	return 1 //Unlimited

/obj/item/weapon/ranged/proc/can_owner_shoot(var/mob/caller,var/atom/object,location,params)

	if(!caller.can_attack(caller))
		return FALSE

	if(is_living(caller))
		var/mob/living/L = caller
		if(L.grabbing_hand)
			return FALSE

	return TRUE

/obj/item/weapon/ranged/proc/can_gun_shoot(var/mob/caller,var/atom/object,location,params,var/check_time=TRUE,var/messages=TRUE)

	if(quality <= 0)
		caller.to_chat(span("warning","\The [src.name] is completely broken!"))
		return FALSE

	if(use_iff_tag)
		if(ispath(firing_pin))
			log_error("WARNING: WEAPON OF TYPE [src.type] HAD A PATH AS A FIRING PIN.")
			firing_pin = null

		if(!firing_pin)
			caller.to_chat(span("warning","This gun doesn't have a firing pin installed!"))
			return FALSE

		if(!firing_pin.can_shoot(caller,src))
			//Messages are handled in the above proc.
			return FALSE

	if(check_time && next_shoot_time > world.time)
		return FALSE

	return TRUE

/obj/item/weapon/ranged/think()

	if(heat_max && last_shoot_time + min(shoot_delay*(weight/10),15) < world.time)
		var/heat_to_remove = CEILING(0.03/max(1,weight) + heat_current*0.1,0.001)
		heat_current = max(0,heat_current - heat_to_remove)
		queued_recoil = 0
	else if(queued_recoil > 0)
		var/heat_to_add = CEILING(queued_recoil*0.25,0.001)
		heat_current = min(heat_max,heat_current + heat_to_add)
		queued_recoil = max(0,queued_recoil - heat_to_add)

	. = ..()

	return . && (heat_current > 0 || (recoil_delay > 0 && queued_recoil > 0))

/obj/item/weapon/ranged/click_self(var/mob/caller,location,control,params)

	if(caller.attack_flags & CONTROL_MOD_DISARM)
		change_firemode(caller)
		return TRUE

	. = ..()

/obj/item/weapon/ranged/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(SSclient.queued_automatics[src]) //Already doing something.
		return TRUE

	. = ..()

	if(.)
		return .

	if(!object || !object.z || object.plane >= PLANE_HUD)
		return .

	if(wield_only && !wielded)
		caller.to_chat(span("warning","You can only fire this when wielded! (CTRL+CLICK)"))
		return .

	INTERACT_CHECK_NO_DELAY(src)

	if(istype(object,/obj/parallax))
		object = object.defer_click_on_object(caller,location,control,params) //Only time defer_click_on_object should be used like this.

	return shoot(caller,object,location,params,click_called=TRUE)

obj/item/weapon/ranged/proc/handle_ammo(var/mob/caller)
	return null

obj/item/weapon/ranged/proc/handle_empty(var/mob/caller)
	if(length(empty_sounds))
		var/turf/T = get_turf(src)
		play_sound(pick(empty_sounds),T,range_max = VIEW_RANGE*0.5)
	return FALSE


obj/item/weapon/ranged/proc/get_shoot_delay(var/mob/caller,var/atom/target,location,params)
	return shoot_delay

obj/item/weapon/ranged/proc/play_shoot_sounds(var/mob/caller,var/list/shoot_sounds_to_use = list(),var/shoot_alert_to_use = ALERT_LEVEL_NONE)

	if(length(shoot_sounds_to_use))
		var/turf/T = get_turf(src)
		play_sound(pick(shoot_sounds_to_use),T,range_min = VIEW_RANGE*0.5, range_max=VIEW_RANGE + ZOOM_RANGE*3,tracked = "\ref[src]")
		if(src.stored_spellswap && src.stored_spellswap.desired_sound)
			play_sound(src.stored_spellswap.desired_sound,T,range_max=VIEW_RANGE)
		if(shoot_alert_to_use)
			var/use_caller = TRUE
			if(is_living(caller))
				var/mob/living/L = caller
				if(L.ai) use_caller = FALSE
			create_alert(VIEW_RANGE + ZOOM_RANGE*3,T,use_caller ? caller : null,shoot_alert_to_use)
		return TRUE

	return FALSE


/obj/item/weapon/ranged/proc/pre_shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1)

	if(!object)
		return FALSE

	var/turf/object_turf = get_turf(object)

	if(!object_turf)
		return FALSE

	caller.face_atom(object)

	if(ismob(caller))
		var/mob/M = caller
		M.attack_turn = world.time + M.attack_turn_delay

	if(!can_owner_shoot(caller,object,location,params))
		return FALSE

	if(!can_gun_shoot(caller,object,location,params))
		return FALSE

	return TRUE

obj/item/weapon/ranged/proc/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1,var/click_called=FALSE,var/projectile_override = null)

	if(!pre_shoot(caller,object,location,params,damage_multiplier))
		return FALSE

	var/quality_bonus = get_quality_bonus(0.5,2)
	var/quality_penalty = max(1,1/get_quality_bonus(0.25,2))

	var/obj/projectile/projectile_to_use = projectile_override ? projectile_override : projectile
	var/list/shoot_sounds_to_use = shoot_sounds
	var/damage_type_to_use = get_ranged_damage_type()
	var/bullet_count_to_use = bullet_count
	var/bullet_spread_to_use = 0
	var/projectile_speed_to_use = projectile_speed*quality_penalty*damage_mod
	var/bullet_color_to_use = bullet_color
	var/inaccuracy_modifier_to_use = get_bullet_inaccuracy(caller,object)
	var/shoot_delay_to_use = get_shoot_delay(caller,object,location,params)
	var/max_bursts_to_use = current_maxmium_bursts
	var/shoot_alert_to_use = shoot_alert
	var/damage_multiplier_to_use = damage_multiplier * damage_mod
	var/penetrations_left = 0
	var/condition_to_use = 1
	var/bullet_view_punch = 1
	var/durability_mod = src.attachment_stats["durability_mod"]
	if(ranged_damage_type) damage_multiplier_to_use *= quality_bonus

	var/power_to_use = 1

	var/obj/item/bullet_cartridge/spent_bullet = handle_ammo(caller)

	if(requires_bullets)
		if(spent_bullet)
			SET(projectile_to_use,spent_bullet.projectile)
			SET(shoot_sounds_to_use,spent_bullet.shoot_sounds)
			SET(damage_type_to_use,spent_bullet.damage_type_bullet)
			SET(bullet_count_to_use,spent_bullet.projectile_count)
			ADD(bullet_spread_to_use,spent_bullet.base_spread)
			SET(projectile_speed_to_use,spent_bullet.projectile_speed)
			SET(bullet_color_to_use,spent_bullet.bullet_color)
			MUL(inaccuracy_modifier_to_use,spent_bullet.inaccuracy_modifier)
			MUL(bullet_view_punch,spent_bullet.view_punch_mod)
			ADD(penetrations_left,spent_bullet.penetrations)
			power_to_use = max(power_to_use,spent_bullet.bullet_length*spent_bullet.bullet_diameter*0.2)
			damage_multiplier_to_use *= quality_bonus
			var/condition_to_use_pre = max(0,1 - max(0,quality_bonus*4))
			condition_to_use_pre += FLOOR(heat_current*2,1)
			condition_to_use = condition_to_use_pre * durability_mod
		else
			handle_empty(caller)
			return FALSE
	else
		if(spent_bullet == FALSE)
			handle_empty(caller)
			return

	var/arm_strength = 0.5
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		arm_strength = A.get_attribute_power(ATTRIBUTE_STRENGTH)*0.75 + A.get_skill_power(SKILL_RANGED)*0.25
	if(wielded || !can_wield)
		arm_strength *= 10

	var/heat_per_shot_to_use = max(0.25,1 - arm_strength)*heat_per_shot_mod*power_to_use*0.006*bullet_count_to_use*(10/clamp(weight,5,20))
	var/view_punch_to_use = max(0.25,1 - arm_strength)*view_punch_mod*bullet_view_punch*power_to_use*0.04*TILE_SIZE*bullet_count_to_use*(1 + heat_current/0.2)
	var/recoil_delay_to_use = recoil_delay + max(0,(weight - 10)/10)

	if(src.stored_spellswap && src.stored_spellswap.desired_projectile)
		projectile_to_use = src.stored_spellswap.desired_projectile

	if(projectile_to_use)

		if(!length(params))
			params = list(PARAM_ICON_X=16,PARAM_ICON_Y=16)

		var/icon_pos_x = params[PARAM_ICON_X]
		var/icon_pos_y = params[PARAM_ICON_Y]

		var/prone = FALSE
		var/static_spread = get_static_spread() * quality_penalty
		var/heat_spread = get_heat_spread() * quality_penalty
		var/skill_spread = 0
		var/movement_spread = 0
		var/iff_tag = null
		var/loyalty_tag = null

		var/prone_mod = 0.75

		if(is_living(caller))
			var/mob/living/L = caller
			skill_spread = get_skill_spread(L)
			if(L.ai)
				skill_spread += RAND_PRECISE(0.05,0.1)
			movement_spread = get_movement_spread(L)
			heat_spread *= (1 - L.get_skill_power(SKILL_RANGED,0,0.5,1))
			if(L.horizontal) prone = TRUE
			if(use_iff_tag) iff_tag = L.iff_tag
			if(use_loyalty_tag) loyalty_tag = L.loyalty_tag

		if(length(attachment_stats))
			SET(shoot_sounds_to_use,attachment_stats["shoot_sounds"])
			SET(shoot_alert_to_use,attachment_stats["shoot_alert"])
			SET(damage_type_to_use,attachment_stats["damage_type"])
			ADD(bullet_count_to_use,attachment_stats["bullet_count"])
			MUL(bullet_spread_to_use,attachment_stats["bullet_spread"])
			MUL(projectile_speed_to_use,attachment_stats["projectile_speed"])
			SET(bullet_color_to_use,attachment_stats["bullet_color"])
			MUL(inaccuracy_modifier_to_use,attachment_stats["inaccuracy_modifier"])
			MUL(damage_multiplier_to_use,attachment_stats["damage_multiplier"])
			MUL(static_spread,attachment_stats["static_spread"])
			MUL(heat_spread,attachment_stats["heat_spread"])
			MUL(skill_spread,attachment_stats["skill_spread"])
			MUL(movement_spread,attachment_stats["movement_spread"])
			MUL(view_punch_to_use,attachment_stats["view_punch"])
			MUL(shoot_delay_to_use,attachment_stats["shoot_delay"])
			ADD(penetrations_left,attachment_stats["penetrations"])
			if(max_bursts_to_use > 1)
				ADD(max_bursts_to_use,attachment_stats["bursts_to_use"])
			MUL(prone_mod,attachment_stats["prone_mod"])

		if(can_wield && !wielded)
			movement_spread *= 2
			movement_spread += 0.01
			static_spread *= 2
			static_spread += 0.02
			view_punch_to_use *= 1.25
			view_punch_to_use += TILE_SIZE*0.1


		play_shoot_sounds(caller,shoot_sounds_to_use,shoot_alert_to_use)

		/* The problem with this is that it adds more sounds to be played by guns, which is already insane :(
		if(spent_bullet && projectile_speed_to_use >= TILE_SIZE*0.75)
			var/bullet_size = max(342,spent_bullet.bullet_length * spent_bullet.bullet_diameter)/342
			play_sound('sound/effects/bullet_crack.ogg', get_turf(src), pitch=RAND_PRECISE(0.95,1.05)-min(0.5,bullet_size*0.25),volume= 30 + bullet_size*25 + (projectile_speed_to_use/TILE_SIZE)*0.10)
		*/

		var/accuracy_loss = clamp(static_spread + heat_spread + max(skill_spread,0) + movement_spread,0,0.5)
		if(prone) accuracy_loss *= prone_mod
		projectile_speed_to_use = min(projectile_speed_to_use,TILE_SIZE - 1)

		shoot_projectile(
			caller,
			object,
			location,
			params,
			projectile_to_use,
			damage_type_to_use,
			icon_pos_x,
			icon_pos_y,
			accuracy_loss,
			projectile_speed_to_use,
			bullet_count_to_use,
			bullet_color_to_use,
			view_punch_to_use,
			damage_multiplier_to_use,
			iff_tag ? iff_tag : null,
			loyalty_tag ? loyalty_tag : null,
			inaccuracy_modifier_to_use,
			get_base_spread(),
			penetrations_left
		)

	last_shoot_time = world.time
	next_shoot_time = world.time + shoot_delay_to_use

	if(heat_max)
		if(recoil_delay_to_use > 0)
			queued_recoil = heat_per_shot_to_use
		else
			heat_current = min(heat_max, heat_current + heat_per_shot_to_use)
		START_THINKING(src)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		if(is_inventory(src.loc))
			var/obj/hud/inventory/I = src.loc
			var/damage_to_deal = (FLOOR((view_punch_to_use/TILE_SIZE)*2, 1) - 1)*2
			if(wielded)
				damage_to_deal -= 20

			if(damage_to_deal > 0)
				var/arm_damage = 0
				var/hand_damage = 0
				if(wielded)
					arm_damage = damage_to_deal*0.75 - 20
					hand_damage = damage_to_deal*0.25 - 20
				else if(can_wield && !wielded)
					hand_damage = damage_to_deal*0.9 - 20
					arm_damage = damage_to_deal*0.1 - 20
				else
					hand_damage = damage_to_deal*0.5 - 20
					arm_damage = damage_to_deal*0.5 - 20

				var/obj/item/organ/O_hand
				var/obj/item/organ/O_arm
				if(I.click_flags & RIGHT_HAND)
					O_arm = A.labeled_organs[BODY_ARM_RIGHT]
					O_hand = A.labeled_organs[BODY_HAND_RIGHT]
				else
					O_arm = A.labeled_organs[BODY_ARM_LEFT]
					O_hand = A.labeled_organs[BODY_HAND_LEFT]

				if(hand_damage >= 0 && O_hand && O_hand.health)
					if(O_hand.health.organic)
						O_hand.health.adjust_loss_smart(BRUTE=max(0,hand_damage*0.5 - 10),PAIN=hand_damage,organic=TRUE,robotic=FALSE)
					else
						O_hand.health.adjust_loss_smart(BRUTE=max(0,hand_damage*0.5 - 10),organic=TRUE,robotic=TRUE)

				if(arm_damage > 0 && O_arm && O_arm.health)
					if(O_arm.health.organic)
						O_arm.health.adjust_loss_smart(BRUTE=max(0,arm_damage*0.5 - 10),PAIN=arm_damage,organic=TRUE,robotic=FALSE)
					else
						O_arm.health.adjust_loss_smart(BRUTE=max(0,arm_damage*0.5 - 10),organic=TRUE,robotic=TRUE)

	if(use_iff_tag && firing_pin)
		firing_pin.on_shoot(caller,src)

	use_condition(condition_to_use)

	update_sprite()

	if(click_called && automatic && caller.client && is_player(caller)) //Automatic fire.
		SSclient.queued_automatics[src] = list(
			caller,
			params,
			damage_multiplier,
			max_bursts_to_use,
			shoot_delay_to_use
		)

	return TRUE

/obj/item/weapon/ranged/proc/handle_automatic(var/mob/caller,params,var/damage_multiplier=1,var/max_bursts_to_use=0,var/shoot_delay_to_use=1)

	var/mob/living/advanced/player/P = caller
	if(!P || !P.ckey || P.qdeleting) //Not even active.
		return FALSE

	if(!(params["left"] && P.attack_flags & CONTROL_MOD_LEFT || params["right"] && P.attack_flags & CONTROL_MOD_RIGHT) && !max_bursts_to_use) //No trigger.
		return FALSE

	var/obj/hud/inventory/I
	if(is_inventory(loc))
		I = loc
	if(!I && loc && loc.loc && is_item(loc) && is_inventory(loc.loc))
		I = loc.loc

	if(!I || !I.click_flags)
		return FALSE

	var/list/screen_loc_parsed = parse_screen_loc(P.client.last_params["screen-loc"])
	if(!length(screen_loc_parsed))
		log_error("Warning: [caller.get_debug_name()] had no screen loc parsed.")
		return FALSE

	var/turf/caller_turf = get_turf(caller)
	var/desired_x = FLOOR(screen_loc_parsed[1]/TILE_SIZE,1) + caller_turf.x - VIEW_RANGE
	var/desired_y = FLOOR(screen_loc_parsed[2]/TILE_SIZE,1) + caller_turf.y - VIEW_RANGE
	var/turf/T = locate(desired_x,desired_y,caller.z)
	if(!T)
		log_error("Warning: [caller] tried shooting in an invalid turf: [desired_x],[desired_y],[caller.z].")
		return FALSE

	if(!shoot(caller,T,P.client.last_location,P.client.last_params,damage_multiplier))
		return FALSE

	if(max_bursts_to_use > 0) //Not above because of shoot needing to run.
		current_bursts += 1

	if(max_bursts_to_use > 0 && current_bursts >= max_bursts_to_use) //End of burst.
		return FALSE

	return TRUE

/atom/proc/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damagetype/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color="#FFFFFF",var/view_punch=0,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/base_spread = get_base_spread(),var/penetrations_left=0)

	if(!target) CRASH("There is no valid target defined!")

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
		final_pixel_target_x = TILE_SIZE*0.5
		final_pixel_target_y = TILE_SIZE*0.5

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

	var/turf/T = get_turf(src)

	//Distance. In pixels.
	var/diff_x = target_fake_x - (T.x*TILE_SIZE) - TILE_SIZE*0.5
	var/diff_y = target_fake_y - (T.y*TILE_SIZE) - TILE_SIZE*0.5

	var/new_angle = ATAN2(diff_x,diff_y)
	new_angle += RAND_PRECISE(-accuracy_loss,accuracy_loss)*90

	var/x_offset = cos(new_angle)
	var/y_offset = sin(new_angle)

	. = list()

	for(var/i=1,i<=bullet_count_to_use,i++)

		var/list/local_xy_list = get_projectile_offset(x_offset,y_offset,i,bullet_count_to_use,base_spread) //Needs to be unique to each shot.

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
					M.client.recoil_pixel_x -= view_punch*normx
					M.client.recoil_pixel_y -= view_punch*normy

			var/mod = HYPOTENUSE(normx,normy)
			var/x_vel = normx * projectile_speed_to_use / mod
			var/y_vel = normy * projectile_speed_to_use / mod

			var/obj/projectile/P = new projectile_to_use(
				T,
				caller,
				src,
				x_vel,
				y_vel,
				final_pixel_target_x,
				final_pixel_target_y,
				location ? location : (is_turf(target) ? target : get_turf(target)),
				damage_type_to_use,
				target,
				bullet_color,
				caller,
				damage_multiplier,
				desired_iff_tag,
				desired_loyalty_tag,
				desired_inaccuracy_modifier,
				penetrations_left
			)
			INITIALIZE(P)
			FINALIZE(P)
			. += P


/atom/proc/get_base_spread() //Random spread for when it shoots more than one projectile.
	return 0

/atom/proc/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)
	var/new_angle = ATAN2(initial_offset_x,initial_offset_y)
	if(bullet_num_max > 1) new_angle += RAND_PRECISE(-accuracy,accuracy)*90
	return list(cos(new_angle),sin(new_angle))

/obj/item/weapon/ranged/proc/get_bullet_inaccuracy(var/mob/living/L,var/atom/target)

	. = inaccuracy_modifier

	if(L.next_move > 0)
		. += movement_inaccuracy_modifier

	if(. <= 0)
		return .

	if(L.client)
		var/total_zoom_mul = zoom_mul
		if(attachment_stats["zoom_mul"])
			total_zoom_mul *= attachment_stats["zoom_mul"]
		if(L.client.is_zoomed)
			. *= 1/(1 + total_zoom_mul*0.5)
		else
			. *= min(1,total_zoom_mul*0.35)/1

	. *= max(0.1,1 - L.get_skill_power(SKILL_PRECISION,0,0.5,0.9)) //Based on skill

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

/obj/item/weapon/ranged/click_on_object_alt(var/mob/caller,var/atom/object,location,control,params)

	if(attachment_undermount) return attachment_undermount.click_on_object_alt(caller,object,location,control,params)

	return FALSE
