/obj/structure/interactive/restocker
	name = "restocker"
	desc = "Restocks goods, as long as you have the materials to make them."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2"
	var/list/stored_material = list()

	bullet_block_chance = 50

	density = TRUE

	pixel_y = 10

/obj/structure/interactive/restocker/Crossed(atom/movable/O)
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
	desc_extended = "A machine that automatically fills magazines inserted into the machine with cheap surplus rounds."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2_ammo"
	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

/obj/structure/interactive/restocker/ammo/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/powercell/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/powercell/C = object
		if(C.charge_current >= C.charge_max)
			caller.to_chat(span("warning","You can't cram any more power into \the [C.name]!"))
			return TRUE
		C.charge_current = C.charge_max
		caller.to_chat(span("notice","You swap \the [C.name] for a fully charged one."))
		C.update_sprite()
		return TRUE

	if(istype(object,/obj/item/magazine/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/magazine/M = object
		var/obj/item/bullet_cartridge/bullet_to_create = M.ammo_surplus
		if(M.regenerate && M.ammo)
			bullet_to_create = M.ammo
		if(!bullet_to_create)
			caller.to_chat(span("warning","That magazine isn't registered in our system!"))
			return TRUE
		var/bullets_to_add = M.bullet_count_max - M.get_ammo_count()
		if(bullets_to_add <= 0)
			caller.to_chat(span("warning","\The [M.name] is already full!"))
			return TRUE
		if(M.next_regen > world.time)
			caller.to_chat(span("warning","That magazine was just filled! Please wait [CEILING(DECISECONDS_TO_SECONDS(M.next_regen-world.time),1)] seconds!"))
			return TRUE
		M.next_regen = world.time + SECONDS_TO_DECISECONDS(120)
		var/obj/item/bullet_cartridge/B = new bullet_to_create(src.loc)
		INITIALIZE(B)
		FINALIZE(B)
		B.add_item_count(bullets_to_add - B.amount,TRUE)
		B.transfer_src_to_magazine(caller,M,location,control,params)
		caller.to_chat(span("notice","\The [M.name] has been restocked with [bullets_to_add] bullets."))
		return TRUE

	return ..()

/obj/structure/interactive/restocker/ammo/premium
	name = "portable premium magazine restocker"
	desc = "Warning: Does not contain premium literature."
	desc_extended = "A machine that automatically fills magazines inserted into the machine with regular rounds. Expensive, but worth it."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2_ammo_premium"
	anchored = TRUE
	collision_flags = FLAG_COLLISION_WALL

/obj/structure/interactive/restocker/ammo/premium/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/powercell/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/powercell/C = object
		if(C.charge_current >= C.charge_max)
			caller.to_chat(span("warning","You can't cram any more power into \the [C.name]!"))
			return TRUE
		C.charge_current = C.charge_max
		caller.to_chat(span("notice","You swap \the [C.name] for a fully charged one."))
		C.update_sprite()
		return TRUE

	if(istype(object,/obj/item/magazine/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/magazine/M = object
		var/obj/item/bullet_cartridge/bullet_to_create = M.ammo
		if(M.regenerate && M.ammo)
			bullet_to_create = M.ammo
		if(!bullet_to_create)
			caller.to_chat(span("warning","That magazine isn't registered in our system!"))
			return TRUE
		var/bullets_to_add = M.bullet_count_max - M.get_ammo_count()
		if(bullets_to_add <= 0)
			caller.to_chat(span("warning","\The [M.name] is already full!"))
			return TRUE
		if(M.next_regen > world.time)
			caller.to_chat(span("warning","That magazine was just filled! Please wait [CEILING(DECISECONDS_TO_SECONDS(M.next_regen-world.time),1)] seconds!"))
			return TRUE
		M.next_regen = world.time + SECONDS_TO_DECISECONDS(120)
		if(is_player(caller))
			var/mob/living/advanced/player/A = caller
			var/credits = initial(bullet_to_create.value) * bullets_to_add
			if (M.regenerate && M.ammo)
				A.to_chat(span("notice","ERROR: NULL ACCOUNT. USER NOT CHARGED."))
			else
				A.adjust_currency(credits)
				A.to_chat(span("notice","Thank you for your purchase of [bullets_to_add] round(s). You have been charged [credits] credits."))
		var/obj/item/bullet_cartridge/B = new bullet_to_create(src.loc)
		INITIALIZE(B)
		FINALIZE(B)
		B.add_item_count(bullets_to_add - B.amount,TRUE)
		B.transfer_src_to_magazine(caller,M,location,control,params)
		caller.to_chat(span("notice","\The [M.name] has been restocked with [bullets_to_add] bullets."))
		return TRUE

	return ..()