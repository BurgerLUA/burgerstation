/obj/item/ore_bag
	name = "mining bag"
	desc = "The second best way to transport ores on your person."
	desc_extended = "A giant orange bag that is designed to hold all your ores. Can hold up to 100 ores."

	icon = 'icons/obj/item/storage/bags.dmi'
	icon_state = "mining"

	var/list/contained_ore = list() //Assoc list.

	var/ore_count = 0
	var/ore_limit = 100

	value = 300

	size = SIZE_3

/obj/item/ore_bag/get_value()
	. = ..()
	for(var/k in contained_ore)
		var/amount = contained_ore[k]
		var/material/M = MATERIAL(k)
		. += amount*1*M.value_per_unit

/obj/item/ore_bag/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","The counter shows [ore_count] objects inside.")

/obj/item/ore_bag/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	if(length(contained_ore))
		.["contained_ore"] = list()
		for(var/k in contained_ore)
			.["contained_ore"]["[k]"] = contained_ore[k]

/obj/item/ore_bag/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	for(var/k in object_data["contained_ore"])
		contained_ore[text2path(k)] = object_data["contained_ore"][k]

/obj/item/ore_bag/Finalize()
	. = ..()
	ore_count = 0
	for(var/k in contained_ore)
		ore_count += contained_ore[k]

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
		ore_count += ore_to_add
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
		caller.to_chat(span("warning","There was nothing to pick up on \the [T.name]!"))

	if(still_some_left)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),src::scoop_up_ore(),caller,T)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_scoop_up_ore(),caller,T)


/obj/item/ore_bag/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	if(istype(object,/obj/structure/interactive/ore_box))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/structure/interactive/ore_box/OB = object
		if(!length(src.contained_ore))
			caller.to_chat(span("notice","There is no ore in \the [src.name] that can be put into \the [OB.name]."))
			return TRUE
		for(var/k in src.contained_ore)
			OB.contained_ore[k] += src.contained_ore[k]
		src.contained_ore.Cut()
		ore_count = 0
		caller.to_chat(span("notice","You transfer all the ore in \the [src.name] to \the [OB.name]."))
		return TRUE

	var/turf/T = object
	if(!is_turf(object))
		if(is_turf(object.loc))
			T = object.loc
		else
			T = null

	if(!T)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)
	if(caller.attack_flags & CONTROL_MOD_DISARM)
		if(!length(contained_ore))
			caller.to_chat(span("warning","There is no ore to dump!"))
			return TRUE
		caller.to_chat(span("notice","You start dumping some ore..."))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),src::dump_some_ore(),caller,T)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_scoop_up_ore(),caller,T) //Not a typo.
	else
		scoop_up_ore(caller,T)


	return TRUE


/obj/item/ore_bag/proc/dump_some_ore(var/mob/caller,var/turf/T)

	var/ore_id = contained_ore[1]
	for(var/i=1,i<=min(CEILING(contained_ore[ore_id]/3,1),30),i++)
		if(contained_ore[ore_id] <= 0) //Possible race condition of two or more people dumping ore.
			break
		var/obj/item/material/ore/O = new(T)
		O.material_id = ore_id
		INITIALIZE(O)
		O.amount = min(contained_ore[ore_id],3)
		FINALIZE(O)
		contained_ore[ore_id] -= O.amount
		ore_count -= O.amount

	if(contained_ore[ore_id] <= 0)
		contained_ore -= ore_id

	if(!length(contained_ore))
		caller.to_chat(span("notice","You finish dumping all the ore."))
		return TRUE

	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),src::dump_some_ore(),caller,T)
	PROGRESS_BAR_CONDITIONS(caller,src,src::can_scoop_up_ore(),caller,T) //can_scoop_up_ore is not a typo. Pretty much the same thing.

	return TRUE

/obj/item/ore_bag/bluespace
	name = "bluespace mining bag"
	desc = "The best way to transport ores on your person."
	desc_extended = "A bluespace-upgraded variant of the beloved giant orange bag that is designed to hold all your ores. Can hold an unlimited number of ores."

	icon = 'icons/obj/item/storage/bags.dmi'
	icon_state = "mining_bluespace"

	ore_limit = INFINITY

	rarity = RARITY_RARE

	value = 1000

	size = SIZE_3

/obj/item/ore_bag/debug
	value_burgerbux = 1

/obj/item/ore_bag/debug/Generate()
	. = ..()
	contained_ore[/material/iron] = 9
	contained_ore[/material/phoron] = 10
	contained_ore[/material/carbon] = 11
	contained_ore[/material/gold] = 12