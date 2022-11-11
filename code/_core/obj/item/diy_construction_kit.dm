/obj/item/diy_construction_kit
	name = "D.I.Y. construction kit"
	desc = "Need an engineer here!"
	desc_extended = "Allows you to slowly construct several types of buildings by placing frames down. Also holds a decent amount of materials."
	icon = 'icons/obj/item/diy_construction_kit.dmi'

	is_container = TRUE
	container_whitelist = list(/obj/item/material/)
	size = SIZE_4
	dynamic_inventory_count = MAX_INVENTORY_X
	weight = 10
	can_rename = TRUE
	var/build_type = "grilles"
	
/obj/item/diy_construction_kit/attack(atom/attacker, atom/victim, list/params, atom/blamed, ignore_distance, precise, damage_multiplier, damagetype/damage_type_override)
	return FALSE //no
/obj/item/diy_construction_kit/click_on_object(mob/caller, atom/object, location, control, params)
	if(!is_advanced(caller))
		caller.to_chat(span("notice","You don't have the brains to build!"))
		return ..()
	if(!get_turf(object))
		caller.to_chat(span("notice","Theres no floor here!"))
		return ..()
	var/mob/living/advanced/C = caller
	var/turf/simulated/floor/F = get_turf(object)
	if(C.intent == INTENT_DISARM)
		build_type = input(C,"What would you like to construct?","Contruction Selector","grilles") as anything in list("grilles","girders","frames","lattices")
		C.to_chat(span("notice","You decide to start constructing [build_type]."))
		return ..()
	var/other_hand
	if(istype(C.get_held_left(),/obj/item/diy_construction_kit))
		other_hand = BODY_HAND_RIGHT_HELD
	else
		other_hand = BODY_HAND_LEFT_HELD
	var/obj/item/I = C.inventories_by_id[other_hand].get_top_object()
	if(!I || !istype(I,/obj/item/material))
		for(var/obj/hud/slot in contents)
			var/obj/item/mayberod = slot.get_top_object()
			if(istype(mayberod,/obj/item/material/rod))
				var/obj/item/material/rod/foundrod = mayberod
				I = foundrod
				break
	if(!I)
		C.to_chat(span("notice","You dont have any rods in your inventory or toolkit!"))
		return ..()
	var/obj/structure/interactive/construction/O
	switch(build_type)
		if("grilles")
			if(!F.can_construct_on(C,/obj/structure/interactive/construction/grille))
				return ..()
			if(!istype(I,/obj/item/material/rod))
				caller.to_chat(span("notice","You need a rod in your other hand to construct a grille!"))
				return ..()
			var/obj/item/material/R = I
			if(R.amount < 1)
				C.to_chat(span("notice","You need more rods to constuct a grille!"))
			O = new /obj/structure/interactive/construction/grille(F)
			O.color = R.color
			O.material_id = R.material_id
			INITIALIZE(O)
			GENERATE(O)
			FINALIZE(O)
			R.add_item_count(-1)
			return TRUE
		if("girders")
			if(!F.can_construct_on(C,/obj/structure/interactive/construction/girder))
				return ..()
			if(!istype(I,/obj/item/material/rod))
				caller.to_chat(span("notice","You need a rod in your other hand to construct a girder!"))
			var/obj/item/material/R = I
			if(R.amount < 1)
				C.to_chat(span("notice","You need more rods to constuct a girder!"))
				return ..()
			O = new /obj/structure/interactive/construction/girder(F)
			O.color = R.color
			O.material_id = R.material_id
			INITIALIZE(O)
			GENERATE(O)
			FINALIZE(O)
			R.add_item_count(-1)
			return TRUE
		if("frames")
			if(!F.can_construct_on(C,/obj/structure/interactive/construction/frame))
				return ..()
			if(!istype(I,/obj/item/material/rod))
				caller.to_chat(span("notice","You need a rod in your other hand to construct a frame!"))
			var/obj/item/material/R = I
			if(R.amount < 1)
				C.to_chat(span("notice","You need more rods to constuct a frame!"))
				return ..()
			O = new /obj/structure/interactive/construction/frame(F)
			O.color = R.color
			O.material_id = R.material_id
			INITIALIZE(O)
			GENERATE(O)
			FINALIZE(O)
			R.add_item_count(-1)
			return TRUE
		if("lattices")
			if(!F.can_construct_on(C,/obj/structure/interactive/construction/lattice))
				return ..()
			if(!istype(I,/obj/item/material/rod))
				caller.to_chat(span("notice","You need a rod in your other hand to construct a lattice!"))
			var/obj/item/material/R = I
			if(R.amount < 1)
				C.to_chat(span("notice","You need more rods to constuct a lattice!"))
				return ..()
			O = new /obj/structure/interactive/construction/lattice(F)
			O.color = R.color
			O.material_id = R.material_id
			INITIALIZE(O)
			GENERATE(O)
			FINALIZE(O)
			R.add_item_count(-1)
			return TRUE
	. = ..()
	