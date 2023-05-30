/obj/structure/interactive/ore_box
	name = "ore box"
	desc = "A crate for moving and storing ores"
	icon = 'icons/obj/structure/ore_box.dmi'
	icon_state = "ore_box"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

	density = TRUE


	var/list/contained_ore = list() //Assoc list.

/obj/structure/interactive/ore_box/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/C = caller
		if(C.attack_flags & CONTROL_MOD_DISARM)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			for(var/k in contents)
				var/obj/item/I = k
				I.drop_item(get_turf(C))
			C.to_chat(span("notice","You dump everything in \the [src.name] at your feet."))

	if(istype(object,/obj/item/material/ore))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/material/ore/O = object
		stack(O)
		return TRUE

	. = ..()

/obj/structure/interactive/ore_box/Crossed(atom/movable/O,atom/OldLoc)

	if(O.type == /obj/item/material/ore)
		stack(O)

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
	. += div("notice","The counter shows [length(contents)] objects inside.")
	. += div("notice","The estimated value of contained contents is [] credits.")

