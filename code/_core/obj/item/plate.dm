/obj/item/plate
	name = "plate"
	desc = "Dinner is served."
	desc_extended = "A basic plate meant for holding food."
	icon = 'icons/obj/item/plate.dmi'
	icon_state = "plate_medium"
	mouse_opacity = 1
	layer = LAYER_OBJ_ITEM - 1
	size = SIZE_4
	weight = 1
	value = 10

	health = /health/construction/
	health_base = 1

	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

	var/max_load = 4
	var/max_size = SIZE_2

	pixel_y = 4

	var/broken = FALSE

/obj/item/plate/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("broken")
	SAVECONTENTS

/obj/item/plate/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("broken")
	LOADCONTENTS

/obj/item/plate/on_thrown(var/atom/owner,var/atom/hit_atom)

	if(hit_atom)
		on_destruction()

	return ..()

/obj/item/plate/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return !broken

/obj/item/plate/on_destruction(var/damage = TRUE)

	var/turf/T = get_turf(src)

	if(T) play_sound('sound/effects/ceramic_break.ogg',T)

	. = ..()

	broken = TRUE
	collision_bullet_flags &= ~FLAG_COLLISION_BULLET_SPECIFIC

	update_sprite()

	if(T)
		for(var/k in contents)
			var/atom/movable/M = k
			M.force_move(T)


/obj/item/plate/update_icon()

	. = ..()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(broken)
		icon_state = "[icon_state]_broken"


/obj/item/plate/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","This object holds up to [max_load] items that are size [max_size] or lower.")

/obj/item/plate/Crossed(atom/movable/O,atom/OldLoc)
	. = ..()

	if(!broken && O.loc == src.loc && is_item(O) && !istype(O,/obj/item/plate) && length(contents) < max_load)
		var/obj/item/I = O
		if(I.size <= max_size)
			I.drop_item(src)

/obj/item/plate/Entered(var/atom/movable/enterer,var/atom/oldloc)
	. = ..()
	if(oldloc != src)
		enterer.vis_flags &= ~VIS_INHERIT_ID
		vis_contents |= enterer

/obj/item/plate/Exited(var/atom/movable/exiter,var/atom/newloc)
	. = ..()
	if(newloc != src)
		vis_contents -= exiter
		exiter.vis_flags = initial(exiter.vis_flags)

/obj/item/plate/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller.attack_flags & CONTROL_MOD_DISARM && !broken)
		INTERACT_CHECK
		INTERACT_DELAY(30)
		var/list/byond_is_weird = list()
		for(var/obj/item/I in contents)
			byond_is_weird += I
		var/cooking_recipe/R = get_plate_recipe(byond_is_weird)
		if(!R) return TRUE

		var/obj/item/spawned_item
		if(R.result)
			var/turf/T = get_turf(src)
			spawned_item = new R.result(T)
			INITIALIZE(spawned_item)
			FINALIZE(spawned_item)
			spawned_item.force_move(T) //Calls enter exit ect

		for(var/obj/item/I in contents)
			if(I == spawned_item)
				continue
			if(spawned_item && spawned_item.reagents && I.reagents)
				I.reagents.transfer_reagents_to(spawned_item.reagents,I.reagents.volume_current,caller=caller)
			qdel(I)

		caller.to_chat(span("notice","You've created \a [R.name]! Bon appétit!"))

		return TRUE

	. = ..()