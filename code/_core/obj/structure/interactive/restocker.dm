/obj/structure/interactive/restocker
	name = "restocker"
	desc = "Restocks goods, as long as you have the materials to make them."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2"
	var/list/stored_material = list()

	bullet_block_chance = 50

/obj/structure/interactive/restocker/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	store(O)
	return ..()

/obj/structure/interactive/restocker/proc/store(var/atom/movable/O)

	if(istype(O,/obj/item/material/))
		var/obj/item/material/I = O
		for(var/material_type in I.material)
			stored_material[material_type] += I.material[material_type]
		return TRUE

	return FALSE

/obj/structure/interactive/restocker/ammo
	name = "portable magazine restocker"
	desc = "Warning: Does not contain literature."
	desc_extended = "A machine that automatically fills magazines inserted into the machine with the magazine's purchased ammo type."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2_ammo"
	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

/obj/structure/interactive/restocker/ammo/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(istype(object,/obj/item/magazine/))
		var/obj/item/magazine/M = object
		if(!M.ammo)
			caller.to_chat(span("warning","That magazine isn't registered in our system!"))
			return TRUE

		var/bullets_to_add = M.bullet_count_max - M.get_ammo_count()
		if(bullets_to_add <= 0)
			caller.to_chat(span("warning","\The [M.name] is already full!"))
			return TRUE
		var/obj/item/bullet_cartridge/B = new M.ammo(src.loc)
		INITIALIZE(B)
		B.add_item_count(bullets_to_add - B.item_count_current,TRUE)
		B.transfer_src_to_magazine(caller,M,location,control,params)
		caller.to_chat(span("notice","\The [M.name] has been restocked with [bullets_to_add] bullets."))

		return TRUE

	return ..()