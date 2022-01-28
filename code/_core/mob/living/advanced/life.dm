/mob/living/advanced/death_message()
	src.do_emote("deathgasp")
	return TRUE

/mob/living/advanced/should_be_horizontal()
	if(!(labeled_organs[BODY_FOOT_RIGHT] || labeled_organs[BODY_FOOT_LEFT]))
		return TRUE
	. = ..()

/mob/living/advanced/on_life_slow()

	. = ..()

	if(.)
		handle_organs()

		var/target_mood = (200 * 0.5 + get_nutrition_mod() * get_hydration_mod() * get_nutrition_quality_mod()) - (health ? health.get_loss(PAIN) * max(0,1-get_attribute_power(ATTRIBUTE_ENDURANCE)) : 0 )
		target_mood = FLOOR(target_mood,1)
		if(mood == null) //Exactly null
			mood = target_mood
		if(mood != target_mood)
			last_mood_gain = clamp(target_mood-mood,-TICKS_TO_SECONDS(LIFE_TICK_SLOW)*(5/60),TICKS_TO_SECONDS(LIFE_TICK_SLOW)*(20/60)) //Lose/gain 5/20 mood in a minute due to other factors.
			mood += last_mood_gain
			mood = clamp(mood,0,200)
		var/obj/hud/button/mood/B = locate() in buttons
		if(B && B.last_mood != mood)
			B.update_sprite()

/mob/living/advanced/pre_death()

	if(driving)
		driving.exit_vehicle(src,get_turf(driving))

	if(!master && !delete_on_death)
		drop_hands(get_turf(src))

	. = ..()

mob/living/advanced/revive()

	var/species/S = SPECIES(species)
	if(!S)
		return FALSE
	if(sex == FEMALE)
		if(length(S.spawning_organs_female) > length(labeled_organs))
			return FALSE
	else
		if(length(S.spawning_organs_male) > length(labeled_organs))
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

/mob/living/advanced/handle_mouse_pointer()

	. = ..()

	if(!.)
		return .

	var/desired_spread = -1

	var/obj/item/weapon/ranged/R = right_item
	var/obj/item/weapon/ranged/L = left_item

	if(istype(R))
		desired_spread = max(0,desired_spread,R.heat_current)

	if(istype(L))
		desired_spread = max(0,desired_spread,L.heat_current)

	if(desired_spread >= 0)
		desired_spread *= 100
		desired_spread = clamp(1+CEILING(desired_spread,1),0,length(spread_icons))
		if(client.mouse_pointer_icon != spread_icons[desired_spread])
			set_mouse_pointer(spread_icons[desired_spread])
	else
		var/icon_to_use = intent == INTENT_HELP ? 'icons/pointers/help.dmi' : 'icons/pointers/non_help.dmi'
		if(client.mouse_pointer_icon != icon_to_use)
			set_mouse_pointer(icon_to_use)




