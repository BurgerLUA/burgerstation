/mob/living/advanced/death_message()
	src.do_emote("deathgasp")
	return TRUE

/mob/living/advanced/get_horizontal()
	if(!(labeled_organs[BODY_FOOT_RIGHT] || labeled_organs[BODY_FOOT_LEFT]))
		return TRUE
	. = ..()

/mob/living/advanced/on_life()

	if(queue_update_items)
		update_items()
		queue_update_items = FALSE

	if(health && length(queue_organ_health_update))
		for(var/k in queue_organ_health_update)
			var/obj/item/organ/O = k
			if(!labeled_organs[O.id])
				continue
			if(!O.health)
				continue
			O.health.update_health()
		queue_organ_health_update.Cut()
		QUEUE_HEALTH_UPDATE(src) //If organs were updated, then the main body should be updated (which is done below in the . = ..())

	. = ..()

/mob/living/advanced/on_life_slow()

	. = ..()

	if(.)
		handle_organs()
		handle_mood()

/mob/living/advanced/proc/handle_mood()

	var/desired_mood = src.get_nutrition_mod() * src.get_hydration_mod() * (0.5 + src.get_nutrition_quality_mod()*0.5) * 100

	desired_mood = round(desired_mood,5)

	var/obj/hud/button/mood/B = locate() in buttons
	if(B && B.last_mood != desired_mood)
		B.last_mood = desired_mood
		B.update_sprite()

	return TRUE


/mob/living/advanced/pre_death()

	if(driving)
		driving.exit_vehicle(src,get_turf(driving))

	. = ..()



/mob/living/advanced/post_death()

	. = ..()

	for(var/k in src.using_inventories)
		var/obj/item/I = k
		I.close_inventory(src)

	if(src.loc && !master && !delete_on_death && is_turf(src.loc) && !is_player_controlled(src))
		drop_hands(src.loc)

/mob/living/advanced/rejuvenate()

	. = ..()

	var/list/missing_organs = list()
	for(var/k in TARGETABLE_LIMBS)
		var/obj/item/organ/O = labeled_organs[k]
		if(O)
			O.broken = FALSE
		else
			missing_organs += k //Must be the key.

	if(length(missing_organs))
		var/species/S = SPECIES(species)
		if(S)
			var/found_skin_color = S.default_color_skin
			var/found_detail_color = S.default_color_detail
			var/found_glow_color = S.default_color_glow
			var/obj/item/organ/OT = labeled_organs[BODY_TORSO]
			if(OT)
				if(OT.additional_blends["skin"]) found_skin_color = OT.additional_blends["skin"].color
				if(OT.additional_blends["skin_detail"]) found_detail_color = OT.additional_blends["skin_detail"].color
				if(OT.additional_blends["skin_glow"]) found_glow_color = OT.additional_blends["skin_glow"].color
			var/list/organset_to_use = sex == FEMALE && length(S.spawning_organs_female) ? S.spawning_organs_female : S.spawning_organs_male
			if(length(organset_to_use))
				for(var/k in missing_organs)
					var/obj/item/organ/O = add_organ(organset_to_use[k])
					if(O.enable_skin && O.additional_blends["skin"])
						O.add_blend("skin",desired_color = found_skin_color)
					if(O.enable_detail && O.additional_blends["skin_detail"])
						O.add_blend("skin_detail",desired_color = found_detail_color)
					if(O.enable_glow && O.additional_blends["skin_glow"])
						O.add_blend("skin_glow",desired_color = found_glow_color)

/mob/living/advanced/proc/can_be_revived()

	for(var/k in TARGETABLE_LIMBS)
		if(!labeled_organs[k])
			return FALSE

	return TRUE


mob/living/advanced/revive()

	if(!can_be_revived())
		return FALSE

	. = ..()

/mob/living/advanced/proc/handle_organs()

	if(!health)
		return FALSE

	for(var/k in labeled_organs)
		var/obj/item/organ/O = labeled_organs[k]
		CHECK_TICK(75,FPS_SERVER*2)
		if(O.has_life) O.on_life()

	return TRUE

var/global/list/spread_icons = list(
	'icons/pointers/accuracy/0.dmi',
	'icons/pointers/accuracy/1.dmi',
	'icons/pointers/accuracy/2.dmi',
	'icons/pointers/accuracy/3.dmi',
	'icons/pointers/accuracy/4.dmi',
	'icons/pointers/accuracy/5.dmi',
	'icons/pointers/accuracy/6.dmi',
	'icons/pointers/accuracy/7.dmi',
	'icons/pointers/accuracy/8.dmi',
	'icons/pointers/accuracy/9.dmi',
	'icons/pointers/accuracy/10.dmi'
)

#define SPREAD_CHANGE 2

/mob/living/advanced/handle_mouse_pointer()

	. = ..()

	if(!.)
		current_mouse_spread = 0
		return .

	var/desired_spread = -1

	var/obj/item/weapon/ranged/R = src.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
	var/obj/item/weapon/ranged/L = src.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()

	if(is_ranged_weapon(R))
		desired_spread = max(0,desired_spread,R.heat_current)

	if(is_ranged_weapon(L))
		desired_spread = max(0,desired_spread,L.heat_current)

	desired_spread *= 75 //Entirely arbitrary.
	var/difference = abs(desired_spread - current_mouse_spread)

	if(difference <= SPREAD_CHANGE)
		current_mouse_spread = desired_spread
	else
		if(desired_spread > current_mouse_spread)
			current_mouse_spread += SPREAD_CHANGE
		else if(desired_spread < current_mouse_spread)
			current_mouse_spread -= SPREAD_CHANGE

	if(current_mouse_spread > -1)
		var/final_mouse_spread = clamp(1+CEILING(current_mouse_spread,1),0,length(spread_icons))
		if(client.mouse_pointer_icon != spread_icons[final_mouse_spread])
			set_mouse_pointer(spread_icons[final_mouse_spread])
	else
		var/icon_to_use = intent == INTENT_HELP ? 'icons/pointers/help.dmi' : 'icons/pointers/non_help.dmi'
		if(client.mouse_pointer_icon != icon_to_use)
			set_mouse_pointer(icon_to_use)

