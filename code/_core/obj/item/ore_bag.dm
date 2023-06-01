/obj/item/ore_bag
	name = "mining bag"
	desc = "The second best way to transport ores on your person."
	desc_extended = "A giant orange bag that is designed to hold all your ores."

	icon = 'icons/obj/item/storage/bags.dmi'
	icon_state = "mining"

	var/list/contained_ore = list() //Assoc list.

	var/ore_count = 0
	var/ore_limit = 100

	value = 300

	size = SIZE_3

/obj/item/ore_bag/proc/can_scoop_up_ore(var/mob/caller,var/turf/T)

	if(get_dist(caller,T) > 1)
		return FALSE

	if(!is_inventory(src.loc))
		return FALSE

	var/obj/hud/inventory/I = src.loc
	if(I.owner != caller)
		return FALSE

	return TRUE



/obj/item/ore_bag/proc/scoop_up_ore(var/mob/caller,var/turf/T)

	var/did_transfer = FALSE
	var/was_full = FALSE
	var/still_some_left = FALSE
	var/limit = 15
	for(var/k in T.contents)
		var/atom/movable/M = k
		if(M.type != /obj/item/material/ore)
			continue
		var/obj/item/material/ore/O = k
		if(O.qdeleting)
			continue //Possible race condition.
		if(limit <= 0)
			still_some_left = TRUE
			break
		var/ore_to_add = min(O.amount,ore_limit-ore_count)
		if(ore_to_add <= 0)
			was_full = TRUE
			break
		O.add_item_count(-ore_to_add)
		contained_ore[O.material_id] += ore_to_add
		did_transfer = TRUE
		if(!O.qdeleting)
			break
		limit--

	if(did_transfer)
		if(was_full || still_some_left)
			caller.to_chat(span("notice","You pick up some of the ores on \the [T.name]."))
		else
			caller.to_chat(span("notice","You pick up all of the ores on \the [T.name]."))
	else
		caller.to_chat(span("notice","There was nothing to pick up on \the [T.name]."))

	if(still_some_left)
		PROGRESS_BAR(caller,src,3,src::scoop_up_ore(),caller,T)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_scoop_up_ore(),caller,T)


/obj/item/ore_bag/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	var/turf/T = object
	if(!is_turf(object) && is_turf(object.loc))
		T = object.loc

	if(!T)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(5)
	scoop_up_ore(caller,object)

	return TRUE




/obj/item/ore_bag/bluespace
	name = "bluespace mining bag"
	desc = "The best way to transport ores on your person."
	desc_extended = "A bluespace-upgraded variant of the beloved giant orange bag that is designed to hold all your ores."

	icon = 'icons/obj/item/storage/bags.dmi'
	icon_state = "mining_bluespace"

	ore_limit = INFINITY

	rarity = RARITY_RARE

	value = 1000

	size = SIZE_3