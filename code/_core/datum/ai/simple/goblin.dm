/ai/goblin
	var/item_delay = SECONDS_TO_TICKS(10)
	var/item_ticks = 0

	var/obj/item/obsessed_item

/ai/goblin/proc/find_loot()

	var/obj/item/best_item
	var/best_value = 400

	for(var/obj/item/I in view(owner,VIEW_RANGE*0.5))
		if(I.value > best_value && isturf(I.loc))
			best_item = I
			best_value = I.value
			continue

	if(best_item)
		obsessed_item = best_item
		return TRUE

	return FALSE

/ai/goblin/on_life(var/tick_rate)

	if(!obsessed_item)
		item_ticks += tick_rate
		if(item_ticks >= item_delay)
			item_ticks = 0
			find_loot()

	return ..()

/ai/goblin/handle_movement()

	if(obsessed_item)
		if(obsessed_item.qdeleting || !isturf(obsessed_item.loc))
			obsessed_item = null
		else if(get_dist(owner,obsessed_item) <= 1)
			var/mob/living/simple/goblin/G = owner
			G.add_to_bag(obsessed_item)
			obsessed_item = null
			owner.move_dir = 0x0
			return TRUE
		else
			owner.move_dir = get_dir(owner,obsessed_item)
			owner.movement_flags = MOVEMENT_RUNNING
			return TRUE

	if(objective_attack && owner.health.health_current <= (owner.health.health_max * 0.5))
		//Flee
		owner.move_dir = get_dir(objective_attack,owner)
		owner.movement_flags = MOVEMENT_RUNNING
		return TRUE

	return ..()

