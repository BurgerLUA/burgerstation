/mob/living/advanced/do_footstep(var/turf/T,var/list/footsteps_to_use,var/enter=TRUE)

	. = ..()

	if(. && is_simulated(T)) //This handles footprints
		var/turf/simulated/S = T
		if(S.blood_level_hard < BLOOD_LIMIT_HARD && S.blood_level < BLOOD_LIMIT)
			var/obj/item/foot_left = labeled_organs[BODY_FOOT_LEFT]?.get_top_object()
			var/obj/item/foot_right = labeled_organs[BODY_FOOT_RIGHT]?.get_top_object()
			if(foot_left && foot_left.blood_stain_intensity > 2)
				var/obj/effect/cleanable/blood/footprint/F = new(S)
				F.set_dir(dir)
				F.icon_state = "human_left_[enter ? "enter" : "exit"]"
				F.alpha = clamp(((foot_left.blood_stain_intensity-2)/2)*255,10,255)
				F.color = foot_left.blood_stain_color
				foot_left.set_bloodstain(max(foot_left.blood_stain_intensity - 0.3,2)) //Lower the bloodstain to 2.
			if(foot_right && foot_right.blood_stain_intensity > 2)
				var/obj/effect/cleanable/blood/footprint/F = new(S)
				F.set_dir(dir)
				F.icon_state = "human_right_[enter ? "enter" : "exit"]"
				F.alpha = clamp(((foot_right.blood_stain_intensity-2)/2)*255,10,255)
				F.color = foot_right.blood_stain_color
				foot_right.set_bloodstain(max(foot_right.blood_stain_intensity - 0.3,2)) //Lower the bloodstain to 2.

/mob/living/advanced/handle_movement(var/adjust_delay=0)

	if(grabbing_hand && handcuffed)
		return FALSE

	if(driving)
		return driving.handle_movement(adjust_delay)

	. = ..()

mob/living/advanced/get_movement_delay(var/include_stance=TRUE)

	. = ..()

	for(var/k in movement_organs)
		var/obj/item/organ/O = labeled_organs[k]
		if(O && O.broken)
			. *= 1.25

	if(inventories_by_id[BODY_HAND_LEFT_HELD])
		var/obj/hud/inventory/I = inventories_by_id[BODY_HAND_LEFT_HELD]
		if(I.grabbed_object)
			. *= 1.5*I.grab_level

	if(inventories_by_id[BODY_HAND_RIGHT_HELD])
		var/obj/hud/inventory/I = inventories_by_id[BODY_HAND_RIGHT_HELD]
		if(I.grabbed_object)
			. *= 1.5*I.grab_level

	if(health)
		. *= 2 - clamp( ((health.health_current - health.damage[PAIN] + pain_removal)/health.health_max) + 0.5,0,1)
		. *= 2 - clamp( (health.stamina_current/health.stamina_max) + 0.5,0,1)

	. *= move_delay_multiplier

/mob/living/advanced/get_footsteps(var/list/original_footsteps,var/enter=TRUE)

	if(footstep_left_right_counter)
		if(labeled_organs[BODY_FOOT_RIGHT])
			var/obj/item/organ/foot/O = labeled_organs[BODY_FOOT_RIGHT]
			return O.get_footsteps(original_footsteps,enter)
	else
		if(labeled_organs[BODY_FOOT_LEFT])
			var/obj/item/organ/foot/O = labeled_organs[BODY_FOOT_LEFT]
			return O.get_footsteps(original_footsteps,enter)

	return original_footsteps

/mob/living/advanced/post_move(var/atom/old_loc)

	. = ..()

	if(!.)
		return .

	for(var/k in using_inventories)
		var/obj/item/I = k
		if(get_dist(src,I) > 1)
			I.close_inventory(src)

	if(src.z && !horizontal)
		var/obj/item/organ/sent_pain
		for(var/k in movement_organs)
			var/obj/item/organ/O = labeled_organs[k]
			if(O && O.health && O.broken && prob(80))
				if(O.health.organic)
					O.health.adjust_loss_smart(pain=1,organic=TRUE,robotic=FALSE)
					sent_pain = O
				else
					O.health.adjust_loss_smart(brute=1,organic=FALSE,robotic=TRUE)
		if(prob(5) && sent_pain && sent_pain.send_pain_response(20))
			src.to_chat(span("warning","Your broken [sent_pain.name] struggles to keep you upright!"))

	if(isturf(old_loc))
		var/turf/T = old_loc
		//Right hand
		if(inventories_by_id[BODY_HAND_RIGHT_HELD]?.grabbed_object)
			var/atom/movable/M = inventories_by_id[BODY_HAND_RIGHT_HELD].grabbed_object
			var/distance = get_dist(src,M)
			var/turf/grabbed_turf = get_turf(M)
			var/bypass_safe = TRUE
			if(src.loyalty_tag && is_living(M))
				var/mob/living/L = M
				if(!allow_hostile_action(src.loyalty_tag,L))
					bypass_safe = FALSE
			if(distance > 1)
				if(bypass_safe || T.is_safe() || !grabbed_turf.is_safe())
					M.glide_size = glide_size
					M.Move(T)
				else
					inventories_by_id[BODY_HAND_RIGHT_HELD].release_object()
			if(is_living(M))
				var/mob/living/L = M
				L.handle_transform()

		//Left hand
		if(inventories_by_id[BODY_HAND_LEFT_HELD]?.grabbed_object)
			var/atom/movable/M = inventories_by_id[BODY_HAND_LEFT_HELD].grabbed_object
			var/distance = get_dist(src,M)
			var/turf/grabbed_turf = get_turf(M)
			var/bypass_safe = TRUE
			if(src.loyalty_tag && is_living(M))
				var/mob/living/L = M
				if(!allow_hostile_action(src.loyalty_tag,L))
					bypass_safe = FALSE
			if(distance > 1)
				if(bypass_safe || T.is_safe() || !grabbed_turf.is_safe())
					M.glide_size = glide_size
					M.Move(T)
				else
					inventories_by_id[BODY_HAND_LEFT_HELD].release_object()
			if(is_living(M))
				var/mob/living/L = M
				L.handle_transform()

	if(is_simulated(loc))
		var/turf/simulated/S = loc
		if(S.blood_level_hard > 0 && S.blood_level > 0) //Has blood.
			S.add_blood_level(-1) //So blood stops leaving footprints if it gets crossed over too much.
			var/list/dirt_items = list()
			if(horizontal) //Crawling.
				if(intent == INTENT_HARM)
					dirt_items = TARGETABLE_LIMBS
				else
					dirt_items = list(
						BODY_TORSO = FALSE,
						BODY_GROIN = FALSE,
						BODY_ARM_LEFT = FALSE,
						BODY_ARM_RIGHT = FALSE,
						BODY_LEG_LEFT = FALSE,
						BODY_LEG_RIGHT = FALSE
					)
			else
				dirt_items = list(
					BODY_FOOT_LEFT = FALSE,
					BODY_FOOT_RIGHT = FALSE
				)
			make_dirty(dirt_items,S.blood_level,S.blood_color)


/mob/living/advanced/proc/make_dirty(var/list/dirt_items,var/dirt_strength=1,var/dirt_color="#FFFFFF")

	if(dirt_strength <= 0)
		return FALSE

	if(!dirt_items)
		dirt_items = TARGETABLE_LIMBS
	else
		dirt_items = dirt_items.Copy() //New list.

	//Step 1: Get the clothing to mess up.
	for(var/obj/item/clothing/C in worn_objects)
		for(var/p in C.protected_limbs) //p would be what was protected for the C object
			if(dirt_items[p]) //Existing clothing found.
				var/obj/item/clothing/C2 = dirt_items[p] //Existing clothing.
				var/obj/hud/inventory/I = C.loc
				var/obj/item/organ/O = I.loc
				if(O.id != p)
					continue
				if(C.worn_layer >= C2.worn_layer)
					dirt_items[p] = C
			else if(dirt_items[p] == FALSE)
				dirt_items[p] = C

	//Step 2: Go through all the clothing to mess up. If there is none, mess up the organ instead.
	for(var/k in dirt_items)
		var/obj/item/I = dirt_items[k] ? dirt_items[k] : src.labeled_organs[k]
		if(I)
			var/new_strength = I.blood_stain_intensity + dirt_strength
			var/ratio = dirt_strength / new_strength
			if(ratio < 1)
				dirt_color = blend_colors(I.blood_stain_color,dirt_color,ratio)
			I.set_bloodstain(new_strength,dirt_color)


	return TRUE

/mob/living/advanced/proc/make_clean(var/list/clean_items,var/clean_strength=1)

	if(clean_strength <= 0)
		return FALSE

	if(!clean_items)
		clean_items = TARGETABLE_LIMBS
	else
		clean_items = clean_items.Copy() //New list.

	//Step 1: Get the clothing to clean up.
	for(var/obj/item/clothing/C in worn_objects)
		for(var/p in C.protected_limbs) //p would be what was protected for the C object
			if(clean_items[p]) //Existing clothing found.
				var/obj/item/clothing/C2 = clean_items[p] //Existing clothing.
				var/obj/hud/inventory/I = C.loc
				var/obj/item/organ/O = I.loc
				if(O.id != p)
					continue
				if(C.worn_layer >= C2.worn_layer)
					clean_items[p] = C
			else if(clean_items[p] == FALSE)
				clean_items[p] = C

	//Step 2: Go through all the clothing to clean up. If there is none, clean up the organ instead.
	for(var/k in clean_items)
		var/obj/item/I = clean_items[k] ? clean_items[k] : src.labeled_organs[k]
		if(I) //Give the clothing a stain if it exists (dirt)
			var/new_strength = I.blood_stain_intensity - clean_strength
			if(new_strength <= 0)
				I.set_bloodstain(0)
			else
				I.set_bloodstain(new_strength,I.blood_stain_color)

	return TRUE


/mob/living/advanced/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	if(inventories_by_id[BODY_HAND_RIGHT_HELD]?.grabbed_object)
		inventories_by_id[BODY_HAND_RIGHT_HELD].check_grab()

	if(inventories_by_id[BODY_HAND_LEFT_HELD]?.grabbed_object)
		inventories_by_id[BODY_HAND_LEFT_HELD].check_grab()

	. = ..()

