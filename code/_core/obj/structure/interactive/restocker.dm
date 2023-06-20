/obj/structure/interactive/restocker
	name = "restocker"
	desc = "Restocks goods, as long as you have the materials to make them."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2"

	bullet_block_chance = 50

	density = TRUE

	pixel_y = 10

/obj/structure/interactive/restocker/ammo
	name = "portable magazine restocker"
	desc = "Warning: Does not contain literature."
	desc_extended = "A machine that automatically fills magazines inserted into the machine with cheap surplus rounds."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2_ammo"
	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL
	var/premium = FALSE //Is this a premium ammo restocker?

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
		if(premium && M.ammo)
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
		M.stored_bullets[bullet_to_create] += bullets_to_add
		M.update_sprite()
		caller.to_chat(span("notice","\The [M.name] has been restocked with [bullets_to_add] [initial(bullet_to_create.name)]."))
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
	premium = TRUE
