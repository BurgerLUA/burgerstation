/mob/living/advanced/do_footstep(var/turf/T,var/list/footsteps_to_use,var/enter=TRUE)

	. = ..()

	if(.)
		var/obj/item/foot_left = labeled_organs[BODY_FOOT_LEFT]?.get_top_object()
		var/obj/item/foot_right = labeled_organs[BODY_FOOT_RIGHT]?.get_top_object()
		if(foot_left?.blood_stain_intensity > 2)
			var/obj/effect/cleanable/blood/footprint/F = new(T)
			F.set_dir(dir)
			F.icon_state = "human_left[enter ? "_enter" : "_exit"]"
			F.alpha = clamp(((foot_left.blood_stain_intensity-2)/2)*255,10,255)
			foot_left.set_bloodstain(max(2,foot_left.blood_stain_intensity - 0.1))
		if(foot_right?.blood_stain_intensity > 2)
			var/obj/effect/cleanable/blood/footprint/F = new(T)
			F.set_dir(dir)
			F.icon_state = "human_right[enter ? "_enter" : "_exit"]"
			F.alpha = clamp(((foot_right.blood_stain_intensity-2)/2)*255,10,255)
			foot_right.set_bloodstain(max(2,foot_right.blood_stain_intensity - 0.1))

/mob/living/advanced/on_sprint()

	if(health && health.adjust_stamina(-1))
		update_health_element_icons(stamina=TRUE)

	return ..()

/mob/living/advanced/handle_movement(var/adjust_delay=0)

	if(grabbing_hand && handcuffed)
		return FALSE

	if(driving)
		return driving.handle_movement(adjust_delay)

	. = ..()


mob/living/advanced/get_movement_delay(var/include_stance=TRUE)

	. = ..()

	var/health_mul = 1
	var/stamina_mul = 1
	var/pain_mul = 1
	var/adrenaline_bonus = 1 + ((get_status_effect_magnitude(ADRENALINE)/100)*(0.5 + (get_status_effect_duration(ADRENALINE)/100))*0.5)

	if(health)
		var/pain_bonus = min(1,get_status_effect_magnitude(PAINKILLER)/100) * min(1,0.5 + (get_status_effect_duration(PAINKILLER)/100)*0.5) * health.health_max
		health_mul = clamp(0.5 + ((health.health_current + pain_bonus)/health.health_max),0.5,1)
		stamina_mul = clamp(0.75 + ((health.stamina_current + pain_bonus)/health.stamina_max),0.75,1)
		pain_mul = clamp(0.1 + (1 - ((health.get_loss(PAIN) - pain_bonus)/health.health_max))*0.9,0.1,1)

	. *= move_delay_multiplier * (1/adrenaline_bonus) * (1/pain_mul) * (1/stamina_mul) * (1/health_mul)

/mob/living/advanced/toggle_sneak(var/on = TRUE)

	if(on && health && !health.adjust_stamina(-10))
		update_health_element_icons(stamina=TRUE)
		return FALSE

	return ..()

/mob/living/advanced/on_sneak()

	if(health)
		if(health.adjust_stamina( -(2-stealth_mod)*2.5 ))
			update_health_element_icons(stamina=TRUE)
		else
			toggle_sneak(FALSE)
			return FALSE

	return ..()

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

	for(var/k in using_inventories)
		var/obj/item/I = k
		if(get_dist(src,I) > 1)
			I.close_inventory(src)

	if(. && isturf(old_loc))
		var/turf/T = old_loc
		//Right hand
		if(inventories_by_id[BODY_HAND_RIGHT_HELD]?.grabbed_object)
			var/distance = get_dist(src,inventories_by_id[BODY_HAND_RIGHT_HELD].grabbed_object)
			var/turf/grabbed_turf = get_turf(inventories_by_id[BODY_HAND_RIGHT_HELD].grabbed_object)
			var/bypass_safe = TRUE
			if(src.loyalty_tag && is_living(inventories_by_id[BODY_HAND_RIGHT_HELD].grabbed_object))
				var/mob/living/L = inventories_by_id[BODY_HAND_RIGHT_HELD].grabbed_object
				if(L.loyalty_tag == src.loyalty_tag)
					bypass_safe = FALSE
			if(distance > 1)
				if(bypass_safe || T.is_safe_teleport(FALSE) || !grabbed_turf.is_safe_teleport(FALSE))
					inventories_by_id[BODY_HAND_RIGHT_HELD].grabbed_object.glide_size = glide_size
					inventories_by_id[BODY_HAND_RIGHT_HELD].grabbed_object.Move(T)
				else
					inventories_by_id[BODY_HAND_RIGHT_HELD].release_object()

		//Left hand
		if(inventories_by_id[BODY_HAND_LEFT_HELD]?.grabbed_object)
			var/distance = get_dist(src,inventories_by_id[BODY_HAND_LEFT_HELD].grabbed_object)
			var/turf/grabbed_turf = get_turf(inventories_by_id[BODY_HAND_LEFT_HELD].grabbed_object)
			var/bypass_safe = TRUE
			if(src.loyalty_tag && is_living(inventories_by_id[BODY_HAND_LEFT_HELD].grabbed_object))
				var/mob/living/L = inventories_by_id[BODY_HAND_LEFT_HELD].grabbed_object
				if(L.loyalty_tag == src.loyalty_tag)
					bypass_safe = FALSE
			if(distance > 1)
				if(bypass_safe || T.is_safe_teleport(FALSE) || !grabbed_turf.is_safe_teleport(FALSE))
					inventories_by_id[BODY_HAND_LEFT_HELD].grabbed_object.glide_size = glide_size
					inventories_by_id[BODY_HAND_LEFT_HELD].grabbed_object.Move(T)
				else
					inventories_by_id[BODY_HAND_LEFT_HELD].release_object()
		if(is_simulated(T))
			var/turf/simulated/S = T
			if(S.blood_level_hard > 0 && S.blood_level > 0)
				S.add_blood_level(-1)
				//Step 1: Get the bodypart defines that are supposed to get messy.
				var/list/blood_items = list()
				if(horizontal) //Crawling.
					blood_items = list(
						BODY_TORSO = FALSE,
						BODY_GROIN = FALSE,
						BODY_ARM_LEFT = FALSE,
						BODY_ARM_RIGHT = FALSE,
						BODY_LEG_LEFT = FALSE,
						BODY_LEG_RIGHT = FALSE
					)
				else
					blood_items = list(
						BODY_FOOT_LEFT = FALSE,
						BODY_FOOT_RIGHT = FALSE
					)
				//Step 2: Get the clothing to mess up.
				for(var/obj/item/clothing/C in worn_objects)
					for(var/p in C.protected_limbs)
						if(blood_items[p])
							var/obj/item/clothing/C2 = blood_items[p]
							var/obj/hud/inventory/I = C.loc
							var/obj/item/organ/O = I.loc
							if(O.id != p)
								continue
							if(C.worn_layer >= C2.worn_layer)
								blood_items[p] = C
						else if(blood_items[p] == FALSE)
							blood_items[p] = C
				//Step 3: Go through all the clothing to mess up. If there is none, mess up the organ instead.
				for(var/k in blood_items)
					var/obj/item/clothing/C = blood_items[k]
					if(!C) //Give the organ a bloodstain instead.
						var/obj/item/organ/ORG = src.labeled_organs[k]
						if(!ORG)
							continue
						ORG.set_bloodstain(ORG.blood_stain_intensity + S.blood_level,S.blood_color)
					else //Give the clothing a bloodstain.
						C.set_bloodstain(C.blood_stain_intensity + S.blood_level,S.blood_color)

/mob/living/advanced/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	if(inventories_by_id[BODY_HAND_RIGHT_HELD]?.grabbed_object)
		inventories_by_id[BODY_HAND_RIGHT_HELD].check_grab()

	if(inventories_by_id[BODY_HAND_LEFT_HELD]?.grabbed_object)
		inventories_by_id[BODY_HAND_LEFT_HELD].check_grab()

	. = ..()

