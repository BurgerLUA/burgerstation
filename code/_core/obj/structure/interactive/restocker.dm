/obj/structure/interactive/restocker
	name = "restocker"
	desc = "Restocks goods, as long as you have the materials to make them."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2"
	var/list/stored_material = list()

/obj/structure/interactive/restocker/Crossed(var/atom/movable/O)
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
	collision_flags = FLAG_COLLISION_REAL

/obj/structure/interactive/restocker/ammo/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(istype(object,/obj/item/magazine/))
		var/obj/item/magazine/M = object
		if(!M.ammo)
			caller.to_chat("That magazine isn't registered in our system!")
			return TRUE

		for(var/i=length(M.stored_bullets), i < M.bullet_count_max, i++)
			M.stored_bullets += new M.ammo(M)
			M.update_icon()

		caller.to_chat("\The [M.name] has been restocked.")

	return ..()