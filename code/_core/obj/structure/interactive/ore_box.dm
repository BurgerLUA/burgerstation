/obj/structure/interactive/ore_box
	name = "ore box"
	desc = "A crate for moving and storing ores"
	icon = 'icons/obj/structure/ore_box.dmi'
	icon_state = "ore_box"

	plane = PLANE_MOVABLE
	layer = LAYER_LARGE_OBJ

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 90

	density = TRUE

	var/list/contained_ore = list() //Assoc list.


/obj/structure/interactive/ore_box/get_value()
	. = ..()
	for(var/k in contained_ore)
		var/amount = contained_ore[k]
		var/material/M = MATERIAL(k)
		. += amount*1*M.value_per_unit

/obj/structure/interactive/ore_box/proc/can_dump_some_ore(var/mob/caller)

	if(get_dist(caller,src) > 1)
		return FALSE

	if(!length(contained_ore))
		return FALSE

	return TRUE



/obj/structure/interactive/ore_box/proc/dump_some_ore(var/mob/caller)

	var/turf/T = get_turf(caller)
	if(!T)
		return FALSE
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

	if(contained_ore[ore_id] <= 0)
		contained_ore -= ore_id

	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),src::dump_some_ore(),caller)
	PROGRESS_BAR_CONDITIONS(caller,src,src::can_dump_some_ore(),caller)

	return TRUE

/obj/structure/interactive/ore_box/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/C = caller
		if(C.attack_flags & CONTROL_MOD_DISARM)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),src::can_dump_some_ore(),caller)
			PROGRESS_BAR_CONDITIONS(caller,src,src::can_dump_some_ore(),caller)
			return TRUE

	if(object.type == /obj/item/material/ore)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/material/ore/O = object
		stack(O)
		return TRUE

	. = ..()

/obj/structure/interactive/ore_box/proc/stack(var/obj/item/material/ore/O)

	if(!O.material_id)
		return FALSE

	var/material/M = MATERIAL(O.material_id)
	if(!M)
		return FALSE

	contained_ore[O.material_id] += O.amount*O.material_multiplier
	qdel(O)
	return TRUE

/obj/structure/interactive/ore_box/get_examine_list(var/mob/examiner)
	. = ..()
	var/total_value = 0
	var/total_objects = 0
	for(var/k in contained_ore)
		var/amount = contained_ore[k]
		var/material/M = MATERIAL(k)
		total_value += amount*1*M.value_per_unit
		total_objects += amount
	. += div("notice","The counter shows [total_objects] objects inside.")
	. += div("notice","The estimated value of contained contents is [total_value] credits.")

